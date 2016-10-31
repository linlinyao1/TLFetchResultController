//
//  DatabaseManager.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "DatabaseManager.h"
#import <YYModel.h>


NSString *const UIDatabaseConnectionWillUpdateNotification = @"UIDatabaseConnectionWillUpdateNotification";
NSString * UIDatabaseConnectionDidUpdateNotification = @"UIDatabaseConnectionDidUpdateNotification";
NSString * kNotificationsKey = @"notifications";


@implementation DatabaseManager

static DatabaseManager* _manager = nil;

+ (instancetype)sharedInstance
{
    if (!_manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [DatabaseManager new];
        });
    }
    return _manager;
}

+ (NSString *)databasePath
{
    NSString *databaseName = @"model.sqlite";
    
    NSURL *baseURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory
                                                            inDomain:NSUserDomainMask
                                                   appropriateForURL:nil
                                                              create:YES
                                                               error:NULL];
    
    NSURL *databaseURL = [baseURL URLByAppendingPathComponent:databaseName isDirectory:NO];
    
    return databaseURL.filePathURL.path;
}


- (id)init
{
    NSAssert(_manager == nil, @"Must use sharedInstance singleton (global MyDatabaseManager)");
    
    if ((self = [super init]))
    {
        [self setupDatabase];
    }
    return self;
}


- (YapDatabaseSerializer)databaseSerializer
{
    // This is actually the default serializer.
    // We just included it here for completeness.
    
    YapDatabaseSerializer serializer = ^(NSString *collection, NSString *key, id object){
        return [object yy_modelToJSONData];
    };
    
    return serializer;
}

- (YapDatabaseDeserializer)databaseDeserializer
{
    // Pretty much the default serializer,
    // but it also ensures that objects coming out of the database are immutable.
    
    YapDatabaseDeserializer deserializer = ^(NSString *collection, NSString *key, NSData *data){
        Class cls = NSClassFromString(key);
        id object = [cls yy_modelWithJSON:data];
        return object;
    };
    
    return deserializer;
}


- (void)setupDatabase
{
    NSString *databasePath = [[self class] databasePath];
    
//    _database = [[YapDatabase alloc] initWithPath:databasePath
//                                      serializer:[self databaseSerializer]
//                                    deserializer:[self databaseDeserializer]
//                                    preSanitizer:nil
//                                   postSanitizer:nil
//                                         options:nil];
    _database = [[YapDatabase alloc] initWithPath:databasePath];
    
    _uiDatabaseConnection = [_database newConnection];
    _uiDatabaseConnection.objectCacheLimit = 400;
    _uiDatabaseConnection.metadataCacheEnabled = NO;
    
    _bgDatabaseConnection = [_database newConnection];
    _bgDatabaseConnection.objectCacheLimit = 400;
    _bgDatabaseConnection.metadataCacheEnabled = NO;
    
    [_uiDatabaseConnection enableExceptionsForImplicitlyEndingLongLivedReadTransaction];
    [_uiDatabaseConnection beginLongLivedReadTransaction];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yapDatabaseModified:)
                                                 name:YapDatabaseModifiedNotification
                                               object:_database];
}


- (void)yapDatabaseModified:(NSNotification *)ignored
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIDatabaseConnectionWillUpdateNotification
                                                        object:self.database];
    
    // Move uiDatabaseConnection to the latest commit.
    // Do so atomically, and fetch all the notifications for each commit we jump.
    
    NSArray *notifications = [_uiDatabaseConnection beginLongLivedReadTransaction];
    
    // Notify observers that the uiDatabaseConnection was updated
    
    NSDictionary *userInfo = @{
                               kNotificationsKey : notifications,
                               };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIDatabaseConnectionDidUpdateNotification
                                                        object:self.database
                                                      userInfo:userInfo];

}
@end
