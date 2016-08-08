//
//  PlateView.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PlateView.h"

@implementation PlateView {
    UIImageView *transverseImage;
    UIImageView *triangleImage;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
}

- (instancetype)init {
    self = [super init];
    if (self) {
       [self initializePlateView];
    }
    return self;
}

- (void)initializePlateView {
    NSArray *icons  = @[ @"sheng", @"zhi", @"hui", @"srdz" ];
    NSArray *titles = @[ @"胜赢", @"智赢", @"慧赢", @"私人定制" ];
    buttonWidth = kScreenWidth / 4;
    buttonHeight = kScreenHeightScale(180);
    
    for (int i=0; i<icons.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        [button addTarget:self action:@selector(onclickWithButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * buttonWidth, button.bottom - 20 - 4, button.width, 20)];
        titleLabel.tag = i + 10;
        titleLabel.text = [titles objectAtIndex:i];
        titleLabel.textColor = i == 0 ? kCustomColor(239, 63, 59, 1) : kCustomColor(76, 76, 76, 1);
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:titleLabel];
    }
    
    for (int i=0; i<3; i++) {
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * buttonWidth, kScreenHeightScale(20), 0.5, buttonHeight - kScreenHeightScale(20) * 2)];
        line.backgroundColor = kCustomColor(230, 230, 230, 1);
        [self addSubview:line];
    }
    
    if (!transverseImage) {
        transverseImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, buttonHeight - kScreenHeightScale(4), buttonWidth, kScreenHeightScale(4))];
        transverseImage.image = [UIImage imageNamed:@"transverse"];
        [self addSubview:transverseImage];
    }
    
    if (!triangleImage) {
        UIImage *image = [UIImage imageNamed:@"Home_Triangle"];
        CGFloat triangleW = image.size.width;
        CGFloat triangleH = image.size.height;
        CGFloat triangleX = (buttonWidth - triangleW) / 2;
        
        triangleImage = [[UIImageView alloc] initWithFrame:CGRectMake(triangleX, buttonHeight + kScreenHeightScale(11), triangleW, triangleH)];
        triangleImage.image = image;
        [self addSubview:triangleImage];
    }
}

- (void)onclickWithButton:(UIButton *)sender {
    CGRect transverseFrame = transverseImage.frame;
    CGRect triangleFrame = triangleImage.frame;
    [UIView animateWithDuration:0.15 animations:^{
        transverseImage.frame = CGRectMake(sender.left, transverseFrame.origin.y, transverseFrame.size.width, transverseFrame.size.height);
    }];
    
    [UIView animateWithDuration:0.05 animations:^{
        triangleImage.frame = CGRectMake((sender.centerX - (triangleFrame.size.width / 2)), triangleFrame.origin.y, triangleFrame.size.width, triangleFrame.size.height);
    }];
    
    for (int i=0; i<4; i++) {
        UILabel *label = [self viewWithTag:i + 10];
        label.textColor = kCustomColor(76, 76, 76, 1);
    }
    
    UILabel *titleLabel = [self viewWithTag:sender.tag + 10];
    titleLabel.textColor = kCustomColor(239, 63, 59, 1);
    
    if (self.plateViewBlock) {
        self.plateViewBlock(sender);
    }
}

- (void)plateViewBlock:(PlateViewBlock)aBlock {
    self.plateViewBlock = aBlock;
}

@end
