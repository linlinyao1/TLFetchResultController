//
//  GitUserTableViewController.m
//  Yapdatabase
//
//  Created by terrylin on 2016/11/8.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "GitUserTableViewController.h"

@interface GitUserTableViewController ()

@end

@implementation GitUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    GithubUser* user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [user login];
    cell.detailTextLabel.text = [user uid];
    return cell;
}



@end
