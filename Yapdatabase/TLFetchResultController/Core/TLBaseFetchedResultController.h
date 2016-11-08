//
//  TLBaseFetchedResultController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/11/7.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TLBaseFetchedResultController;
@protocol TLBaseFetchedResultControllerUpdater <NSObject>
-(void)FetchedResultControllerWillUpdate:(TLBaseFetchedResultController*)controller;
-(void)FetchedResultControllerDidUpdate:(TLBaseFetchedResultController*)controller;
@end

@interface TLBaseFetchedResultController : NSObject

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;

-(void)refreshWithCompletion:(void (^)(NSError *error))complectionHanlder;
-(void)loadmoreWithCompletion:(void (^)(NSError *error))complectionHanlder;

- (Class)viewModelClass;

@end
