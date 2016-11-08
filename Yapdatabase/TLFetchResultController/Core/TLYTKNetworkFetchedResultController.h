//
//  TLYTKNetworkFetchedResultController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/11/8.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "TLBaseFetchedResultController.h"
#import <YTKNetwork.h>


@interface TLYTKNetworkFetchedResultController : TLBaseFetchedResultController
@property (nonatomic, strong) NSArray* originalData;
@property (nonatomic, strong) NSArray* refreshData;
@property (nonatomic, strong) NSArray* loadmoreData;

- (NSComparisonResult)sortingForObject1:(id)obj1 andObject2:(id)obj2;

@end
