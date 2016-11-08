//
//  TLTableViewCell.m
//  Yapdatabase
//
//  Created by terrylin on 2016/11/7.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "TLTableViewCell.h"

@implementation TLTableViewCell

-(void)configCellAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object
{
    self.indexPath = indexPath;
    self.object = object;
}

@end
