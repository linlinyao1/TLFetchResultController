//
//  TLYTKNetworkFetchedResultController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/11/8.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "TLYTKNetworkFetchedResultController.h"
#import <YYModel.h>

@interface TLYTKNetworkFetchedResultController ()
@property (nonatomic, strong) YTKRequest* refreshRequest;
@property (nonatomic, strong) YTKRequest* loadmoreRequest;
@end

@implementation TLYTKNetworkFetchedResultController

-(YTKRequest *)refreshRequest
{
    return nil;
}

-(YTKRequest *)loadmoreRequest
{
    return nil;
}

-(NSUInteger)numberOfSections
{
    return 1;
}

-(NSUInteger)numberOfItemsInSection:(NSUInteger)section
{
    return self.originalData.count;
}

-(id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.originalData objectAtIndex:indexPath.row];
}


-(NSArray*)listDataFromResponseObject:(id)responseObject
{
    return responseObject;
}
-(NSArray*)viewModelDataFromJsonList:(NSArray*)list
{
    NSMutableArray* mArray = [NSMutableArray array];
    Class modelClass = [self viewModelClass];
    for (NSDictionary* dict in list) {
        id model = [modelClass yy_modelWithJSON:dict];
        if (model) {
            [mArray addObject:model];
        }
    }
    return [mArray copy];
}


-(BOOL)shouldInsertObject:(id)object
{
    return [self.originalData containsObject:object];
}

-(void)refreshWithCompletion:(void (^)(NSError *))complectionHanlder
{
    YTKRequest* request = [self refreshRequest];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray* array = [self listDataFromResponseObject:request.responseJSONObject];
        if (array.count) {
            self.refreshData = array;
            NSArray* models = [self viewModelDataFromJsonList:array];
            self.originalData = [models sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [self sortingForObject1:obj1 andObject2:obj2];
            }];
        }
        if (complectionHanlder) {
            complectionHanlder(nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complectionHanlder) {
            complectionHanlder(request.error);
        }
    }];
}

-(void)loadmoreWithCompletion:(void (^)(NSError *))complectionHanlder
{
    YTKRequest* request = [self loadmoreRequest];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complectionHanlder) {
            complectionHanlder(nil);
        }
        NSArray* array = [self listDataFromResponseObject:request.responseJSONObject];
        if (array.count) {
            self.loadmoreData = array;
            NSArray* models = [self viewModelDataFromJsonList:array];
            NSMutableArray* mArray = [self.originalData mutableCopy];
            for (id obj in models) {
                if (![self.originalData containsObject:obj]) {
                    [mArray addObject:obj];
                }
            }
            self.originalData = [mArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [self sortingForObject1:obj1 andObject2:obj2];
            }];
        }
        if (complectionHanlder) {
            complectionHanlder(nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complectionHanlder) {
            complectionHanlder(request.error);
        }
    }];
}


- (NSComparisonResult)sortingForObject1:(id)obj1 andObject2:(id)obj2
{
    return [obj1 compare:obj2];
}

@end
