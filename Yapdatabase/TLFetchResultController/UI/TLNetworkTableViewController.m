//
//  TLNetworkTableViewController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/11/8.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "TLNetworkTableViewController.h"
#import <MJRefresh.h>

@interface TLNetworkTableViewController ()

@end

@implementation TLNetworkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MJRefreshNormalHeader* r_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    r_header.lastUpdatedTimeLabel.hidden = YES;
    r_header.stateLabel.hidden = YES;
    [self.tableView setMj_header:r_header];
    
    MJRefreshAutoNormalFooter* l_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    l_footer.stateLabel.hidden = YES;
    [self.tableView setMj_footer:l_footer];
}

-(void)refresh{
    [self.fetchedResultsController refreshWithCompletion:^(NSError *error) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadMore{
    [self.fetchedResultsController loadmoreWithCompletion:^(NSError *error) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

@end
