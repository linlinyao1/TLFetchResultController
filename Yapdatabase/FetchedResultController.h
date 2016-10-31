//
//  FetchedResultController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/10/21.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import <YapDatabase/YapDatabaseViewTransaction.h>
#import <YapDatabase/YapDatabaseView.h>

@import UIKit;


@interface FetchedResultController : NSObject
@property (nonatomic, strong, readonly) YapDatabaseConnection *uiDatabaseConnection;
@property (nonatomic, strong) YapDatabaseViewMappings* mappings;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;

@end
