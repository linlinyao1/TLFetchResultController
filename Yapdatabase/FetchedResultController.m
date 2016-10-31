//
//  FetchedResultController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/21.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "FetchedResultController.h"

#import "GithubUser.h"

@interface FetchedResultController ()
@property (nonatomic, strong, readonly) YapDatabaseView* databaseView;

@end

@implementation FetchedResultController

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self registerDatabaseView];
        self.mappings = [[YapDatabaseViewMappings alloc] initWithGroups:@[[self groupingName]] view:[self databaseViewName]];
        _uiDatabaseConnection = [DatabaseManager sharedInstance].uiDatabaseConnection;
        [self.uiDatabaseConnection beginLongLivedReadTransaction];
        [self.uiDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
            // One time initialization
            [self.mappings updateWithTransaction:transaction];
        }];
    }
    return self;
}


-(NSString*)databaseViewName
{
    return @"users";
}

-(NSString*)groupingName
{
    return @"all";
}


-(void)registerDatabaseView
{
    _databaseView = [[[DatabaseManager sharedInstance].database registeredExtensions] objectForKey:[self databaseViewName]];
    if (!_databaseView) {
        YapDatabaseViewGrouping *grouping = [YapDatabaseViewGrouping withObjectBlock:^NSString * _Nullable(YapDatabaseReadTransaction * _Nonnull transaction, NSString * _Nonnull collection, NSString * _Nonnull key, id  _Nonnull object) {
            return [self groupingName];
        }];
        
        YapDatabaseViewSorting* sorting =[YapDatabaseViewSorting withRowBlock:^NSComparisonResult(YapDatabaseReadTransaction * _Nonnull transaction, NSString * _Nonnull group,
                                                                                                  NSString * _Nonnull collection1, NSString * _Nonnull key1, GithubUser*  _Nonnull object1, id  _Nullable metadata1,
                                                                                                  NSString * _Nonnull collection2, NSString * _Nonnull key2, GithubUser*  _Nonnull object2, id  _Nullable metadata2) {
            
            return [object1.uid compare:object2.uid];
        }];
        
        YapDatabaseView *databaseView =
        [[YapDatabaseView alloc] initWithGrouping:grouping
                                          sorting:sorting];
        
        [[DatabaseManager sharedInstance].database registerExtension:databaseView withName:[self databaseViewName]];
    }
}

-(NSUInteger)numberOfSections
{
    return [self.mappings numberOfSections];
}

-(NSUInteger)numberOfItemsInSection:(NSUInteger)section
{
    return [self.mappings numberOfItemsInSection:section];
}

-(id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    __block id object = nil;
    [self.uiDatabaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction){
        object = [[transaction ext:self.mappings.view] objectAtIndexPath:indexPath withMappings:self.mappings];
    }];
    return object;
}



@end
