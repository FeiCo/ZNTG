//
//  PlateView.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PlateView.h"

@implementation PlateView
{
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    UIImageView *transverseImage;
    UILabel *title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializePlateView];
    }
    return self;
}

- (void)initializePlateView {
    NSArray *icons  = @[ @"sheng", @"zhi", @"hui", @"srdz" ];
    NSArray *titles = @[ @"胜赢", @"智赢", @"慧赢", @"私人定制" ];
    buttonWidth = CGRectGetWidth(self.frame) / 4;
    buttonHeight = kScreenHeightScale(180);
    
    for (int i=0; i<icons.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        [button addTarget:self action:@selector(onclickWithButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(i * buttonWidth, button.bottom - 20 - 10, button.width, 20)];
        title.text = [titles objectAtIndex:i];
        title.textColor = kCustomColor(76, 76, 76, 1);
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        title.tag = i;
        [self addSubview:title];
    }
    
    for (int i=0; i<3; i++) {
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * buttonWidth, kScreenHeightScale(20), 0.5, buttonHeight - kScreenHeightScale(20) * 2)];
        line.backgroundColor = kCustomColor(230, 230, 230, 1);
        [self addSubview:line];
    }
    
    transverseImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, buttonHeight - kScreenHeightScale(4), buttonWidth, kScreenHeightScale(4))];
    transverseImage.image = [UIImage imageNamed:@"transverse"];
    [self addSubview:transverseImage];
}

- (void)onclickWithButton:(UIButton *)sender {
    CGRect oldFrame = transverseImage.frame;
    [UIView animateWithDuration:0.25 animations:^{
           transverseImage.frame = CGRectMake(sender.left, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
    }];
}

@end
