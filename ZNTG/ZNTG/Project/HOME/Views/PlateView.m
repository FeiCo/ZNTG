//
//  PlateView.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PlateView.h"

@implementation PlateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializePlateView];
    }
    return self;
}

- (void)initializePlateView {
    NSArray *icons = @[ @"sheng", @"zhi", @"hui", @"srdz" ];
    NSArray *titles = @[ @"胜赢", @"智赢", @"慧赢", @"私人定制" ];
    
    CGFloat buttonWidth = CGRectGetWidth(self.frame) / 4;
    CGFloat buttonHeight = kScreenHeightScale(180);
    for (int i=0; i<icons.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        [self addSubview:button];
    }
    
}


@end
