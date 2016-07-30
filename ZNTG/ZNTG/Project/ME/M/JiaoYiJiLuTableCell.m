//
//  JiaoYiJiLuTableCell.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "JiaoYiJiLuTableCell.h"

#define screenB  [UIScreen mainScreen].bounds

@interface JiaoYiJiLuTableCell()


@property(weak,nonatomic)UILabel *label1;
@property(weak,nonatomic)UILabel *label2;
@property(weak,nonatomic)UILabel *label3;
@property(weak,nonatomic)UILabel *label4;

@end

@implementation JiaoYiJiLuTableCell


+(instancetype)JiaoYiJiLuWithTableView:(UITableView *)tableview {
    static NSString *id = @"jiaoyijilu";
    JiaoYiJiLuTableCell *cell = [tableview dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[JiaoYiJiLuTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label1 = [[UILabel alloc] init];
        UILabel *label2 = [[UILabel alloc] init];
        UILabel *label3 = [[UILabel alloc] init];
        UILabel *label4 = [[UILabel alloc] init];
        
        _label1 = label1;
        _label2 = label2;
        _label3 = label3;
        _label4 = label4;
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:label3];
        [self.contentView addSubview:label4];
    }
    return self;
}



-(void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    [self settingFrame];
    [self settingData];
}


-(void)settingFrame {
    _label1.frame = CGRectMake(15, 10, 100, 30);
    _label2.frame = CGRectMake(screenB.size.width - 120, 10, 100, 30);
    _label3.frame = CGRectMake(15, 45, 100, 30);
    _label4.frame = CGRectMake(screenB.size.width - 120, 45, 100, 30);
}


-(void)settingData {
    _label1.text = @"赢胜";
    _label1.font = [UIFont systemFontOfSize:22];
    _label1.textColor = [UIColor grayColor];
    _label2.text = @"￥15.00";
    _label2.font = [UIFont systemFontOfSize:22];
    _label2.textAlignment = NSTextAlignmentRight;
    _label3.text = @"2016/07/20";
    _label3.textColor = [UIColor lightGrayColor];
    _label4.text = @"成功";
    _label4.textColor = [UIColor lightGrayColor];
    _label4.textAlignment = NSTextAlignmentRight;
    
}

@end
