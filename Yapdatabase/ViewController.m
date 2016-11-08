//
//  ViewController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "ViewController.h"
#import "UserListApi.h"
#import "GithubUser.h"
#import "DatabaseManager.h"
#import "FetchedResultController.h"
#import "TableViewController.h"
#import "GitUserTableViewController.h"
#import "GitUserFetchedResultController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GitUserTableViewController* table = [[GitUserTableViewController alloc] initWithStyle:UITableViewStylePlain];
    table.fetchedResultsController = [GitUserFetchedResultController new];
    table.view.frame = self.view.bounds;
    [self.view addSubview:table.view];
    [table willMoveToParentViewController:self];
    [self addChildViewController:table];
    [table didMoveToParentViewController:self];
    
    
//    [[DatabaseManager sharedInstance].uiDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
//        GithubUser* user = [transaction objectForKey:@"136" inCollection:@"user"];
//        NSLog(@"decode user:\n %@",user);
//    }];
    
    // Do any additional setup after loading the view, typically from a nib.
//    UserListApi* api = [UserListApi new];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (request.responseJSONObject) {
//            YapDatabaseConnection* connect = [DatabaseManager sharedInstance].bgDatabaseConnection;
//            [connect asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
//                NSArray* array = request.responseJSONObject;
//                for (NSDictionary* dict in array) {
//                    GithubUser* user = [GithubUser yy_modelWithJSON:dict];
//                    GithubUser* oldUser = [transaction objectForKey:user.uid inCollection:@"user"];
//                    if (oldUser) {
//                        [oldUser updateWithObject:user];
//                        [transaction setObject:oldUser forKey:oldUser.uid inCollection:@"user"];
//                    }else{
//                        [transaction setObject:user forKey:user.uid inCollection:@"user"];
//                    }
//                }
//            }completionBlock:^{
//                [connect readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
//                    NSArray* array = request.responseJSONObject;
//                    for (NSDictionary* dict in array) {
//                        NSNumber* uid = dict[@"id"];
//                        GithubUser* user = [transaction objectForKey:[uid stringValue] inCollection:@"user"];
//                        NSLog(@"decode user:/n %@",user);
//                    }
//                }];
//            }];
//
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//    }];
}


@end
