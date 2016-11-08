//
//  TLTableViewCell.h
//  Yapdatabase
//
//  Created by terrylin on 2016/11/7.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTableViewCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, strong) id object;

-(void)configCellAtIndexPath:(NSIndexPath*)indexPath withObject:(id)object NS_REQUIRES_SUPER;

@end
