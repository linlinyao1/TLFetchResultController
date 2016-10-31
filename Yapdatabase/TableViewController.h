//
//  TableViewController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/10/24.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkFetchedResultController.h"

@interface TableViewController : UITableViewController
@property (nonatomic, strong) NetworkFetchedResultController* frc;
@end
