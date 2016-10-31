//
//  NetworkFetchedResultController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/10/28.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "FetchedResultController.h"
typedef void (^BoolCompletion)(BOOL finished);

@interface NetworkFetchedResultController : FetchedResultController
- (void)refreshDataWithCompletion:(BoolCompletion)completion;

@end
