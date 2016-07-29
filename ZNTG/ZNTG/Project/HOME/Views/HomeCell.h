//
//  HomeCell.h
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

- (void)handleHomeCellWithName:(NSString *)name
                     buyAmount:(NSString *)buyAmount
                         price:(NSString *)price
                      contents:(NSArray *)contents;

@end
