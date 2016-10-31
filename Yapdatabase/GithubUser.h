//
//  GithubUser.h
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface GithubUser : NSObject <NSCoding, NSCopying>
@property (nonatomic, copy) NSString* login;
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, copy) NSString* avatar_url;
@property (nonatomic, copy) NSString* gravatar_id;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* html_url;
@property (nonatomic, copy) NSString* followers_url;
@property (nonatomic, copy) NSString* following_url;
@property (nonatomic, copy) NSString* gists_url;
@property (nonatomic, copy) NSString* starred_url;
@property (nonatomic, copy) NSString* subscriptions_url;
@property (nonatomic, copy) NSString* organizations_url;
@property (nonatomic, copy) NSString* repos_url;
@property (nonatomic, copy) NSString* events_url;
@property (nonatomic, copy) NSString* received_events_url;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* site_admin;


-(instancetype)updateWithObject:(GithubUser*)user;

@end
