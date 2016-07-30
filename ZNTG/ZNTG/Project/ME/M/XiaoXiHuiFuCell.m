//
//  XiaoXiHuiFuCell.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "XiaoXiHuiFuCell.h"
#import "XiaoXiHuiFudata.h"
#import "XiaoXiHuiFu.h"

// 昵称的字体
#define PHNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define PHTextFont [UIFont systemFontOfSize:15]


// 回答正文的字体
#define PHHuiDaTextFont [UIFont systemFontOfSize:13]


@interface XiaoXiHuiFuCell()


@property(nonatomic,weak)UILabel *askContent;
@property(nonatomic,weak)UILabel *auswerContent;
@property(nonatomic,weak)UILabel *shijian;

@property(nonatomic,weak)UIView *beiJingV;
@property(nonatomic,weak)UIView *subBeiJingV;


@end

@implementation XiaoXiHuiFuCell


+(instancetype)XiaoXiHuiFucellWithTableView:(UITableView *)tableview {
    static NSString *id = @"xiaoxiHUIFU";
    XiaoXiHuiFuCell *cell = [tableview dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[XiaoXiHuiFuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *askcontent = [[UILabel alloc] init];
        UILabel *auswerContent = [[UILabel alloc] init];
        UILabel *shijian = [[UILabel alloc] init];
        UIView *beiJingV = [[UIView alloc] init];
        UIView *subBeiJingV = [[UIView alloc] init];
        
        shijian.textColor = [UIColor grayColor];
        
        beiJingV.layer.cornerRadius = 5;
        beiJingV.layer.borderWidth = 1;
        beiJingV.layer.borderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1].CGColor;
        
        subBeiJingV.layer.cornerRadius = 2;
        subBeiJingV.layer.borderWidth = 1;
        subBeiJingV.layer.borderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1].CGColor;
        
        askcontent.font = PHTextFont;
        shijian.font = PHNameFont;
        auswerContent.font = PHHuiDaTextFont;
        
        [self.contentView addSubview:beiJingV];
        [self.contentView addSubview:subBeiJingV];
        [self.contentView addSubview:askcontent];
        [self.contentView addSubview:auswerContent];
        [self.contentView addSubview:shijian];
        _askContent = askcontent;
        _auswerContent = auswerContent;
        _beiJingV = beiJingV;
        _subBeiJingV = subBeiJingV;
        _shijian = shijian;
        
        
        self.contentView.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1];
    }
    return self;
}


-(void)setXxHFmodel:(XiaoXiHuiFu *)xxHFmodel {
    _xxHFmodel = xxHFmodel;
    [self settingFrame];
    [self settingData];
}


-(void)settingFrame {
    _askContent.frame = _xxHFmodel.askContentF;
    _auswerContent.frame = _xxHFmodel.auswerContentF;
    _beiJingV.frame =_xxHFmodel.beiJingTuF;
    _beiJingV.backgroundColor = [UIColor whiteColor];
    _subBeiJingV.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _subBeiJingV.frame = _xxHFmodel.subBeiJingTuF;
    _shijian.frame = _xxHFmodel.shijianF;
}


-(void)settingData {
    XiaoXiHuiFudata *data = _xxHFmodel.xxHF;
    _askContent.text = data.wenContent;
    _askContent.numberOfLines = 0;
    _auswerContent.numberOfLines = 0;
    _shijian.text = data.shijian;
    NSString *huidazhe = data.huiDaZhe;
    huidazhe = [huidazhe stringByAppendingString:@"："];
    NSRange range = [huidazhe rangeOfString:huidazhe];
    NSString *totlalString = [huidazhe stringByAppendingString:data.huiDaContent];
    NSMutableAttributedString *huiDa =[[NSMutableAttributedString alloc] initWithString:totlalString];
    [huiDa addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242 / 255.0 green:79 / 255.0 blue:66 / 255.0 alpha:1] range:range];

    _auswerContent.attributedText = huiDa;
}

@end
