//
//  TLFetchedResultsTableViewController.h
//  Yapdatabase
//
//  Created by terrylin on 2016/11/7.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBaseFetchedResultController.h"
#import "TLTableViewCell.h"

@interface TLFetchedResultsTableViewController : UITableViewController
@property (nonatomic, strong) __kindof TLBaseFetchedResultController* fetchedResultsController;


#pragma mark - for inherit
-(void)configCell:(TLTableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
