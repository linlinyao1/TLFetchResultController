//
//  NetworkFetchedResultController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/28.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "NetworkFetchedResultController.h"
#import <YTKNetwork.h>
#import "UserListApi.h"
#import "GithubUser.h"
#import "DatabaseManager.h"

@implementation NetworkFetchedResultController

-(YTKRequest*)refreshRequest
{
    return [UserListApi new];
}

-(NSArray*)listDataFromResponseObject:(id)responseObject
{
    return responseObject;
}

-(void)refreshDataWithCompletion:(BoolCompletion)completion
{
    YTKRequest* request = [self refreshRequest];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray* listData = [self listDataFromResponseObject:request.responseObject];
        YapDatabaseConnection* connect = [DatabaseManager sharedInstance].bgDatabaseConnection;
        [connect asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
            for (NSDictionary* dict in listData) {
                GithubUser* user = [GithubUser yy_modelWithJSON:dict];
                GithubUser* oldUser = [transaction objectForKey:user.uid inCollection:@"user"];
                if (oldUser) {
                    [oldUser updateWithObject:user];
                    [transaction setObject:oldUser forKey:oldUser.uid inCollection:@"user"];
                }else{
                    [transaction setObject:user forKey:user.uid inCollection:@"user"];
                }
            }
        }];
        
        if (completion) {
            completion(YES);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(NO);
        }
    }];
}



@end
