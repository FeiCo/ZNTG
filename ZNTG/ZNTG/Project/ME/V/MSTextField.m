//
//  MSTextField.m
//  RongChangShangPin
//
//  Created by Sai on 16/2/16.
//  Copyright © 2016年 ShangHai. All rights reserved.
//

#import "MSTextField.h"

@interface MSTextField()<UITextFieldDelegate>
@end

@implementation MSTextField
- (instancetype)init{
    self = [super init];
    if(self){
        self.text = @"";
        self.delegate = self;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        self.textColor = [UIColor blackColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        self.textColor = [UIColor blackColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        self.delegate = self;
        self.text = @"";
    }
    return self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 15) {
        return NO;
    }
    return YES;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGFloat y = (CGRectGetHeight(bounds) - 20)/2;
    return CGRectMake(5, y, 20, 20);
}


- (void)showShakeAnimation{
    // 获取到当前的View
    CALayer *viewLayer = self.layer;
    
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}
@end
