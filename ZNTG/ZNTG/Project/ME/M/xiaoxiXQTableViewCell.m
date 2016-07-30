//
//  xiaoxiXQTableViewCell.m
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//
// 昵称的字体
#define PHNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define PHTextFont [UIFont systemFontOfSize:15]


#import "xiaoxiXQTableViewCell.h"
#import "xiaoxiXQ.h"
#import "xiaoxiXQdata.h"

@interface xiaoxiXQTableViewCell ()

@property(nonatomic,weak) UILabel *xxXIANGQ;
@property(nonatomic,weak) UILabel *xxSJ;
@property(nonatomic,weak) UIView *bjtp;

@end
@implementation xiaoxiXQTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)xiaoxiYQcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"xxXQ";
    xiaoxiXQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[xiaoxiXQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
           UIView *bj = [[UIView alloc]init];
        [self.contentView  addSubview: bj];
        
        UILabel * xxxq = [[UILabel alloc] init ];
        xxxq.numberOfLines = 0;
        xxxq.font = PHTextFont;
        [self.contentView addSubview:xxxq];
        UILabel * xxsj = [[UILabel alloc] init ];
        xxsj.font = PHNameFont;
        [self.contentView addSubview:xxsj];
     
        xxsj.textColor = [UIColor grayColor];
        
        self.xxXIANGQ = xxxq;
        self.xxSJ = xxsj;
        self.bjtp = bj;
        self.contentView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        
    }
    return self;
}

-(void)setXxXQmodel:(xiaoxiXQ *)xxXQmodel
{
    
    _xxXQmodel = xxXQmodel;
    [self settingData];
    [self settingFrame];
    

}

-(void)settingData
{
    xiaoxiXQdata *data = _xxXQmodel.xxXQ;
    _xxXIANGQ.text = data.xiaoxiContent;
    _xxSJ.text = data.shijian;
    
    _bjtp.backgroundColor = [UIColor whiteColor];
    _bjtp.layer.cornerRadius = 6;
    _bjtp.layer.borderWidth = 1;
    _bjtp.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1].CGColor;
    
}

-(void)settingFrame
{

    _xxSJ.frame = self.xxXQmodel.shijianF;
    _xxXIANGQ.frame = self.xxXQmodel.contentF;
    _bjtp.frame = self.xxXQmodel.beijingtu;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
