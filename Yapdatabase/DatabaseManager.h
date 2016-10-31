//
//  DatabaseManager.h
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YapDatabase/YapDatabase.h>

FOUNDATION_EXTERN NSString* UIDatabaseConnectionDidUpdateNotification;
FOUNDATION_EXTERN NSString * kNotificationsKey;


@interface DatabaseManager : NSObject
@property (nonatomic, strong, readonly) YapDatabaseConnection *uiDatabaseConnection;
@property (nonatomic, strong, readonly) YapDatabaseConnection *bgDatabaseConnection;
@property (nonatomic, strong, readonly) YapDatabase* database;

+ (instancetype)sharedInstance;

@end
