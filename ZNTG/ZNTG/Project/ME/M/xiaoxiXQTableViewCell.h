//
//  xiaoxiXQTableViewCell.h
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  xiaoxiXQ;
@interface xiaoxiXQTableViewCell : UITableViewCell


@property (nonatomic, strong)   xiaoxiXQ* xxXQmodel;
+ (instancetype)xiaoxiYQcellWithTableView:(UITableView *)tableView;

@end
