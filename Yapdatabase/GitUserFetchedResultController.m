//
//  GitUserFetchedResultController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/11/8.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "GitUserFetchedResultController.h"
#import "UserListApi.h"
#import "GithubUser.h"

@implementation GitUserFetchedResultController


-(YTKRequest *)refreshRequest
{
    UserListApi* userListRequest = [UserListApi new];
    return userListRequest;
}

-(YTKRequest *)loadmoreRequest
{
    UserListApi* userListRequest = [UserListApi new];
    userListRequest.offset = self.originalData.count;
    return userListRequest;
}

-(Class)viewModelClass
{
    return [GithubUser class];
}

- (NSComparisonResult)sortingForObject1:(GithubUser*)obj1 andObject2:(GithubUser*)obj2
{
    return [obj1.login compare:obj2.login options:NSCaseInsensitiveSearch];
}

@end
