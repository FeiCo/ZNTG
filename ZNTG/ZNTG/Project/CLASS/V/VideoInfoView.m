//
//  VideoInfoView.m
//  ZNTG
//
//  Created by FeiCao on 16/8/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "VideoInfoView.h"
#import "UILabel+WidthAndHeight.h"

@implementation VideoInfoView
{
    NSInteger thumbNumber;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeVideoInfoView];
    }
    return self;
}

- (void)initializeVideoInfoView {
    CGFloat margin = kScreenWidthScale(16);
    CGFloat textHeight = kScreenHeightScale(40);
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, kScreenHeightScale(48), kScreenWidthScale(90), kScreenHeightScale(90))];
    _iconImageView.image = [UIImage imageNamed:@"hyh"];
    [self addSubview:_iconImageView];
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"何燕华";
    _nameLabel.font = [UIFont systemFontOfSize:16];
    CGFloat nameLabelWidth = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(_iconImageView.right + margin, _iconImageView.top, nameLabelWidth, textHeight);
    [self addSubview:_nameLabel];
    
    UIImageView *positionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_nameLabel.right + margin, _nameLabel.top, kScreenWidthScale(24), kScreenHeightScale(27))];
    positionImageView.image = [UIImage imageNamed:@"v"];
    [self addSubview:positionImageView];
    
    
    _positionLabel = [[UILabel alloc] init];
    _positionLabel.text = @"金牌投股";
    _positionLabel.font = [UIFont systemFontOfSize:13];
    _positionLabel.textColor = kCustomColor(110, 110, 110, 1);
    CGFloat positionLabelWidth = [UILabel getWidthWithTitle:_positionLabel.text font:_positionLabel.font];
    _positionLabel.frame = CGRectMake(positionImageView.right + margin, positionImageView.top, positionLabelWidth, textHeight);
    [self addSubview:_positionLabel];
    
    
    _watchNumberLabel = [[UILabel alloc] init];
    NSString *watchNumer = @"2520";
    NSString *watchNumerString = [NSString stringWithFormat:@"已观看人数 %@",watchNumer];
    _watchNumberLabel.textColor = kCustomColor(84, 84, 84, 1);
    _watchNumberLabel.font = [UIFont systemFontOfSize:13];
    CGFloat watchNumberWidth = [UILabel getWidthWithTitle:watchNumerString font:_watchNumberLabel.font];
    _watchNumberLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + margin, watchNumberWidth, textHeight);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:watchNumerString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kCustomColor(236, 57, 21, 1) range:NSMakeRange(6, watchNumer.length)];
    _watchNumberLabel.attributedText = attributedString;
    [self addSubview:_watchNumberLabel];
    
    
    _thumbNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat thumbNumberWidth = kScreenWidthScale(180);
    CGFloat thumbNumberHeight = kScreenHeightScale(70);
    _thumbNumberButton.frame = CGRectMake(self.width - margin - thumbNumberWidth, kScreenHeightScale(64), thumbNumberWidth, thumbNumberHeight);
    _thumbNumberButton.backgroundColor = kCustomColor(239, 63, 59, 1);
    _thumbNumberButton.layer.masksToBounds = YES;
    _thumbNumberButton.layer.cornerRadius = thumbNumberHeight / 2;
    [_thumbNumberButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    thumbNumber = 999;
    [_thumbNumberButton setTitle:[NSString stringWithFormat:@"%ld",thumbNumber] forState:UIControlStateNormal];
    [_thumbNumberButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_thumbNumberButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [_thumbNumberButton addTarget:self action:@selector(onclickWithThumbNumberButton:) forControlEvents:UIControlEventTouchUpInside];
    _thumbNumberButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_thumbNumberButton];
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(margin, _thumbNumberButton.bottom + kScreenHeightScale(60), self.width - margin * 2, 0.5)];
    line.backgroundColor = kCustomColor(196, 196, 196, 1);
    [self addSubview:line];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, line.bottom + margin, self.width - margin * 2, textHeight)];
    NSString *title = @"持股是目前最佳的选择";
    NSString *titleText = [NSString stringWithFormat:@"主题: %@",title];
    _titleLabel.textColor = kCustomColor(68, 68, 68, 1);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:titleText];
    [titleString addAttribute:NSForegroundColorAttributeName value:kCustomColor(236, 57, 21, 1) range:NSMakeRange(0 ,3)];
    _titleLabel.attributedText = titleString;
    [self addSubview:_titleLabel];
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, _titleLabel.bottom + margin, self.width - margin * 2, textHeight)];
    NSString *timeString = @"2016-07-29";
    _timeLabel.text = [NSString stringWithFormat:@"播出时间: %@",timeString];
    _timeLabel.textColor = kCustomColor(130, 130, 130, 1);
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_timeLabel];
    
    UILabel *hemLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    hemLine.backgroundColor = kCustomColor(220, 220, 220, 1);
    [self addSubview:hemLine];
}

- (void)onclickWithThumbNumberButton:(UIButton *)sender {
    thumbNumber += 1;
    [_thumbNumberButton setTitle:[NSString stringWithFormat:@"%ld",thumbNumber] forState:UIControlStateNormal];
}
@end
