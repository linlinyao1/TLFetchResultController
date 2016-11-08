//
//  UserListApi.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "UserListApi.h"

@implementation UserListApi

- (NSString *)requestUrl {
    return @"/users";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"since": @(self.offset),
             };
}

@end
