//
//  XiaoXiHuiFuCell.h
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XiaoXiHuiFu;
@interface XiaoXiHuiFuCell : UITableViewCell


@property (nonatomic, strong)   XiaoXiHuiFu* xxHFmodel;
+ (instancetype)XiaoXiHuiFucellWithTableView:(UITableView *)tableView;

@end
