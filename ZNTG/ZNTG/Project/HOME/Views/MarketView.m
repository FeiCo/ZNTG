//
//  MarketView.m
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "MarketView.h"

@implementation MarketView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeMarketView];
    }
    return self;
}

- (void)initializeMarketView {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:20];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = kCustomColor(5, 160, 8, 1);
    [self addSubview:_priceLabel];
    
    _changeLabel = [[UILabel alloc] init];
    _changeLabel.font = [UIFont systemFontOfSize:13];
    _changeLabel.textAlignment = NSTextAlignmentCenter;
    _changeLabel.textColor = kCustomColor(5, 160, 8, 1);
    [self addSubview:_changeLabel];
}

- (void)layoutSubviews {
    _nameLabel.frame = CGRectMake(0, kScreenHeightScale(16), self.width,kScreenHeightScale(30));
    _priceLabel.frame = CGRectMake(0, _nameLabel.bottom + kScreenHeightScale(6), self.width,kScreenHeightScale(40));
    _changeLabel.frame = CGRectMake(0, _priceLabel.bottom + kScreenHeightScale(6), self.width,kScreenHeightScale(30));
}

- (void)handleMarketViewWithName:(NSString *)aName
                         atPrice:(NSString *)aPrice
                        atChange:(NSString *)aChange
                       atApplies:(NSString *)applies {
    self.nameLabel.text = aName;
    self.priceLabel.text = aPrice;
    self.changeLabel.text = [NSString stringWithFormat:@"%@ %@",aChange,applies];
}

@end
