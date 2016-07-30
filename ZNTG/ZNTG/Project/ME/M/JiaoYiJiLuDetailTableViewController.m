//
//  JiaoYiJiLuDetailTableViewController.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "JiaoYiJiLuDetailTableViewController.h"
#import "JiaoYiJiLuDetailCell.h"

@implementation JiaoYiJiLuDetailTableViewController



-(void)viewDidLoad {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
    
    
}


#pragma mark -- TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiaoYiJiLuDetailCell *cell = [JiaoYiJiLuDetailCell JiaoYiJiLuDetailWithTableView:tableView];
    cell.dataDict = [NSDictionary new];
    return cell;
}



@end
