//
//  JiaoYiJiLuDetailCell.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "JiaoYiJiLuDetailCell.h"

#define screenB  [UIScreen mainScreen].bounds

@interface JiaoYiJiLuDetailCell()

@property(weak,nonatomic)UIButton *jiaoYiBtn;
@property(weak,nonatomic)UILabel *label1;
@property(weak,nonatomic)UILabel *label2;
@property(weak,nonatomic)UILabel *label3;
@property(weak,nonatomic)UILabel *label4;
@property(weak,nonatomic)UILabel *label5;
@property(weak,nonatomic)UILabel *label6;
@property(weak,nonatomic)UILabel *label7;
@property(weak,nonatomic)UILabel *label8;
@property(weak,nonatomic)UILabel *label9;
@property(weak,nonatomic)UILabel *label10;


@end

@implementation JiaoYiJiLuDetailCell

+(instancetype)JiaoYiJiLuDetailWithTableView:(UITableView *)tableview {
    static NSString *id = @"jiaoyijiluDetail";
    JiaoYiJiLuDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[JiaoYiJiLuDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *jiaoYiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        UILabel *label1 = [[UILabel alloc] init];
        UILabel *label2 = [[UILabel alloc] init];
        UILabel *label3 = [[UILabel alloc] init];
        UILabel *label4 = [[UILabel alloc] init];
        UILabel *label5 = [[UILabel alloc] init];
        UILabel *label6 = [[UILabel alloc] init];
        UILabel *label7 = [[UILabel alloc] init];
        UILabel *label8 = [[UILabel alloc] init];
        UILabel *label9 = [[UILabel alloc] init];
        UILabel *label10 = [[UILabel alloc] init];
        
        UIView *fenGe1 = [[UIView alloc] initWithFrame:CGRectMake(10, 60, screenB.size.width - 20, 1)];
        UIView *fenGe2 = [[UIView alloc] initWithFrame:CGRectMake(10, 110, screenB.size.width - 20, 1)];
        fenGe1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        fenGe2.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        
        _label1 = label1;
        _label2 = label2;
        _label3 = label3;
        _label4 = label4;
        _label5 = label5;
        _label6 = label6;
        _label7 = label7;
        _label8 = label8;
        _label9 = label9;
        _label10 = label10;
        _jiaoYiBtn = jiaoYiBtn;
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:label3];
        [self.contentView addSubview:label4];
        [self.contentView addSubview:label5];
        [self.contentView addSubview:label6];
        [self.contentView addSubview:label7];
        [self.contentView addSubview:label8];
        [self.contentView addSubview:label9];
        [self.contentView addSubview:label10];
        [self.contentView addSubview:fenGe1];
        [self.contentView addSubview:fenGe2];
        [self.contentView addSubview:jiaoYiBtn];
    }
    return self;
}



-(void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    [self settingFrame];
    [self settingData];
}


-(void)settingFrame {
    _label1.frame = CGRectMake(15, 70, 100, 30);
    _label2.frame = CGRectMake(screenB.size.width - 120, 70, 100, 30);
    _label3.frame = CGRectMake(15, 115, 100, 30);
    _label4.frame = CGRectMake(screenB.size.width - 120, 115, 100, 30);
    _label5.frame = CGRectMake(15, 145, 100, 30);
    _label6.frame = CGRectMake(screenB.size.width - 120, 145, 100, 30);
    _label7.frame = CGRectMake(15, 175, 100, 30);
    _label8.frame = CGRectMake(screenB.size.width - 180, 175, 160, 30);
    _label9.frame = CGRectMake(15, 205, 100, 30);
    _label8.font = [UIFont systemFontOfSize:16];
    _label10.font = [UIFont systemFontOfSize:16];
    _label8.textAlignment = NSTextAlignmentRight;
    _label10.textAlignment = NSTextAlignmentRight;
    _label10.frame = CGRectMake(screenB.size.width - 180, 205, 160, 30);
    _jiaoYiBtn.frame = CGRectMake((screenB.size.width - 140)/2, 10, 140, 40);
}


-(void)settingData {
    _label1.text = @"金      额";
//    _label1.font = [UIFont systemFontOfSize:22];
    _label1.textColor = [UIColor grayColor];
    _label2.text = @"￥15.00";
    _label2.font = [UIFont systemFontOfSize:22];
    _label2.textAlignment = NSTextAlignmentRight;
    _label3.text = @"名      称";
    _label3.textColor = [UIColor grayColor];
    _label4.text = @"胜赢";
    _label4.textColor = [UIColor grayColor];
    _label4.textAlignment = NSTextAlignmentRight;
    
    _label5.text = @"交易类型";
//    _label5.font = [UIFont systemFontOfSize:22];
    _label5.textColor = [UIColor grayColor];
    _label6.text = @"网银";
//    _label6.font = [UIFont systemFontOfSize:22];
    _label6.textAlignment = NSTextAlignmentRight;
    _label6.textColor = [UIColor grayColor];
    _label7.text = @"流水号";
    _label7.textColor = [UIColor grayColor];
    _label8.text = @"1233435434534535";
    _label8.textColor = [UIColor grayColor];
    _label8.textAlignment = NSTextAlignmentRight;
    
    _label9.text = @"交易时间";
    _label10.text = @"2016-07-22 10:05:24";
    _label9.textColor = [UIColor grayColor];
    _label10.textColor = [UIColor grayColor];
    
    [_jiaoYiBtn setTitle:@"支付成功" forState:UIControlStateNormal];
    _jiaoYiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_jiaoYiBtn setImage:[UIImage imageNamed:@"JIAOYIcg"] forState:UIControlStateNormal];
    _jiaoYiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _jiaoYiBtn.adjustsImageWhenHighlighted = NO;
    _jiaoYiBtn.tintColor = [UIColor colorWithRed:100/255.0 green:213/255.0 blue:56/255.0 alpha:1];
    
}



@end
