//
//  JiaoYiJiLuDetailCell.h
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiaoYiJiLuDetailCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *dataDict;
+(instancetype)JiaoYiJiLuDetailWithTableView:(UITableView *)tableview;

@end
