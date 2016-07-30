//
//  JiaoYiJiLuTableViewController.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "JiaoYiJiLuTableViewController.h"
#import "JiaoYiJiLuTableCell.h"

#import "JiaoYiJiLuDetailTableViewController.h"

@implementation JiaoYiJiLuTableViewController

-(void)viewDidLoad {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
    
    
}


#pragma mark -- TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiaoYiJiLuTableCell *cell = [JiaoYiJiLuTableCell JiaoYiJiLuWithTableView:tableView];
    cell.dataDict = [NSDictionary new];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JiaoYiJiLuDetailTableViewController *jiaoYiDetail =[[JiaoYiJiLuDetailTableViewController alloc]init];
    [self.navigationController pushViewController:jiaoYiDetail animated:YES];
}


@end
