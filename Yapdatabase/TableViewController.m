//
//  TableViewController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/24.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "TableViewController.h"
#import "GithubUser.h"
#import <MJRefresh.h>
#import "DatabaseManager.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frc = [NetworkFetchedResultController new];
    MJRefreshNormalHeader* r_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    r_header.lastUpdatedTimeLabel.hidden = YES;
    r_header.stateLabel.hidden = YES;
    [self.tableView setMj_header:r_header];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yapDatabaseModified:)
                                                 name:UIDatabaseConnectionDidUpdateNotification
                                               object:self.frc.uiDatabaseConnection.database];
    
}

-(void)refresh{
    [self.frc refreshDataWithCompletion:^(BOOL finished) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.frc numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.frc numberOfItemsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    GithubUser* user = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = [user login];
    cell.detailTextLabel.text = [user uid];
    return cell;
}


- (void)yapDatabaseModified:(NSNotification *)notification
{
    // Jump to the most recent commit.
    // End & Re-Begin the long-lived transaction atomically.
    // Also grab all the notifications for all the commits that I jump.
    // If the UI is a bit backed up, I may jump multiple commits.
    
    NSArray *notifications = [[notification userInfo] objectForKey:kNotificationsKey];
    
    // Process the notification(s),
    // and get the change-set(s) as applies to my view and mappings configuration.
    //
    // Note: the getSectionChanges:rowChanges:forNotifications:withMappings: method
    // automatically invokes the equivalent of [mappings updateWithTransaction:] for you.
    
    NSArray *sectionChanges = nil;
    NSArray *rowChanges = nil;
    
    [[self.frc.uiDatabaseConnection ext:self.frc.mappings.view] getSectionChanges:&sectionChanges
                                                           rowChanges:&rowChanges
                                                     forNotifications:notifications
                                                         withMappings:self.frc.mappings];
    
    // No need to update mappings.
    // The above method did it automatically.
    
    if ([sectionChanges count] == 0 & [rowChanges count] == 0)
    {
        // Nothing has changed that affects our tableView
        return;
    }
    
    [self.tableView beginUpdates];
    
    for (YapDatabaseViewSectionChange *sectionChange in sectionChanges)
    {
        switch (sectionChange.type)
        {
            case YapDatabaseViewChangeDelete :
            {
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionChange.index]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeInsert :
            {
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionChange.index]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            default:
            {
                break;
            }
        }
    }
    
    for (YapDatabaseViewRowChange *rowChange in rowChanges)
    {
        switch (rowChange.type)
        {
            case YapDatabaseViewChangeDelete :
            {
                [self.tableView deleteRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeInsert :
            {
                [self.tableView insertRowsAtIndexPaths:@[ rowChange.newIndexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeMove :
            {
                [self.tableView deleteRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView insertRowsAtIndexPaths:@[ rowChange.newIndexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeUpdate :
            {
                [self.tableView reloadRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationNone];
                break;
            }
        }
    }
    
    [self.tableView endUpdates];
}


@end
