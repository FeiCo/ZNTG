//
//  JiaoYiJiLuTableCell.h
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiaoYiJiLuTableCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *dataDict;
+(instancetype)JiaoYiJiLuWithTableView:(UITableView *)tableview;
@end
