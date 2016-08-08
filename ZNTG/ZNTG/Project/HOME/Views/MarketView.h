//
//  MarketView.h
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketView : UIScrollView

@property (nonatomic, strong) UILabel *nameLabel; // 名称
@property (nonatomic, strong) UILabel *priceLabel; // 最新价
@property (nonatomic, strong) UILabel *changeLabel; // 涨跌

- (void)handleMarketViewWithName:(NSString *)aName
                         atPrice:(NSString *)aPrice
                        atChange:(NSString *)aChange
                       atApplies:(NSString *)applies;

@end
