//
//  CustomAlertView.m
//  AlertView
//
//  Created by wujing on 16/4/12.
//  Copyright © 2016年 wujing. All rights reserved.
//

#import "CustomAlertView.h"
#define _K_SCREEN_WIDTH ([[UIScreen mainScreen ] bounds ].size.width)

#define kAlertWidth (245  * _K_SCREEN_WIDTH/320)
#define kTitleWidth (kAlertWidth-16-32)
#define kContentWidth (kAlertWidth + 10)

#define kContentMaxHeight 150.0f
#define kContentMinHeight 34.0f

#define kTitleTopMargin 5.0f
#define kTitleHeight 25.0f

#define kSingleButtonWidth (160.0f * _K_SCREEN_WIDTH/320)
#define kCoupleButtonWidth (107.0f * _K_SCREEN_WIDTH/320)
#define kButtonHeight 40.0f
#define kButtonBottomMargin 10.0f

#define kContentBottomMargin 12.0f
#define kContentTopMargin 0.0f

#define KCoupleButtonPadding 1.0f

#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]
@interface CustomAlertView ()


@end


@implementation CustomAlertView{
}

+ (void)popViewWithTitle:(NSString *)title
             contentText:(UIView *)content
      contentFrame:(CGRect)contentFrame
              bottomView:(UIView*)bottomView
             bottomFrame:(CGRect)bottomFrame
         leftButtonTitle:(NSString *)leftTitle
        rightButtonTitle:(NSString *)rigthTitle
               leftBlock:(dispatch_block_t)leftBlock
              rightBlock:(dispatch_block_t)rightBlock
            dismissBlock:(dispatch_block_t)dismissBlock
{
    CustomAlertView* popView=[CustomAlertView new];
    
    popView.leftBlock=leftBlock;
    popView.rightBlock=rightBlock;
    popView.dismissBlock=dismissBlock;
    
    popView.backgroundColor = [UIColor whiteColor];
    popView.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - kTitleWidth) * 0.5, kTitleTopMargin, kTitleWidth, 30)];
   
//    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chakanniu"]];
//    imageV.frame = CGRectMake(0,0, kAlertWidth, contentFrame.size.height);
//    
//    NSLog(@"gggg%f",contentFrame.size.height);
    
    UIButton *cancellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancellButton setImage:[UIImage imageNamed:@"KejianX"] forState:UIControlStateNormal];
    cancellButton.frame = CGRectMake(kAlertWidth - 40, kTitleTopMargin + 5, 30, 30);
    [cancellButton addTarget:popView action:@selector(cancellBtnClick:) forControlEvents:UIControlEventTouchDown];
    [popView addSubview:cancellButton];
    popView.lbTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    popView.lbTitle.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
    popView.lbTitle.textAlignment=NSTextAlignmentCenter;
    popView.lbTitle.backgroundColor=[UIColor clearColor];
    [popView addSubview:popView.lbTitle];
    popView.lbTitle.text = title;
    

//    UILabel *jifenL  = [[UILabel alloc] initWithFrame:CGRectMake(kAlertWidth / 2 - 60,  contentFrame.size.height -150, 60, 30)];
//    UILabel *jifenN  = [[UILabel alloc] initWithFrame:CGRectMake(kAlertWidth / 2 ,  contentFrame.size.height -150, 50, 30)];
//    
//    jifenL.text = @"积分：";
//    jifenN.text = title;
//    jifenN.textColor = [UIColor redColor];
//    
//    jifenL.textAlignment = NSTextAlignmentRight;
    
    content.frame =CGRectMake(0,40, kAlertWidth, contentFrame.size.height);
    
//    [content addSubview:imageV];
//    [content addSubview:jifenL];
//    [content addSubview:jifenN];
    
    popView.tvContent = content;
    popView.layer.cornerRadius = 5;
    popView.layer.masksToBounds = YES;
    [popView addSubview:content];
    
    

    
    CGRect leftBtnFrame;
    CGRect rightBtnFrame;
    
    if (!leftTitle) {
        rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, CGRectGetMaxY(popView.tvContent.frame)+kContentBottomMargin -120, kSingleButtonWidth, kButtonHeight);
        popView.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        popView.rightBtn.frame = rightBtnFrame;
        
    }else {
        leftBtnFrame = CGRectMake(0, CGRectGetMaxY(popView.tvContent.frame)+kContentBottomMargin, (kAlertWidth - KCoupleButtonPadding) / 2, kButtonHeight);
        rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + KCoupleButtonPadding, CGRectGetMaxY(popView.tvContent.frame)+kContentBottomMargin, (kAlertWidth - KCoupleButtonPadding) / 2, kButtonHeight);
        popView.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        popView.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        popView.leftBtn.frame = leftBtnFrame;
        popView.rightBtn.frame = rightBtnFrame;
    }
    popView.rightBtn.backgroundColor=color(235, 60, 64, 1);
    popView.leftBtn.backgroundColor=color(250, 126, 59, 1);
    [popView.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
    [popView.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    popView.leftBtn.titleLabel.font = popView.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [popView.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [popView.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [popView.leftBtn addTarget:popView action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [popView.rightBtn addTarget:popView action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    popView.leftBtn.layer.masksToBounds = popView.rightBtn.layer.masksToBounds = YES;
//    popView.leftBtn.layer.cornerRadius = popView.rightBtn.layer.cornerRadius = 3.0;
    [popView addSubview:popView.leftBtn];
    [popView addSubview:popView.rightBtn];
    
   

//    [popView resetFrame];
    bottomView.frame =CGRectMake(0, CGRectGetMaxY(popView.rightBtn.frame)+kContentTopMargin, kAlertWidth, bottomFrame.size.height);
    popView.tvBottom = bottomView;
    [popView addSubview:bottomView];
    [popView resetFrame];
    [popView show];
    
}



-(void)cancellBtnClick:(UIButton *)sender {
    
    [self dismissAlert];
    
}



- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    
    self.frame=CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5,
                                       100,
                                       self.frame.size.width,
                                       self.frame.size.height);
   [ UIView animateWithDuration:0.8 animations:^{
//       self.frame=CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5,
//                             -self.frame.origin.y-30,
//                             self.frame.size.width,
//                             self.frame.size.height);
//       NSLog(@"------------------------%f",self.frame.size.height);
//       NSLog(@"------------------------%f",self.frame.origin.y);
       [topVC.view addSubview:self];
   }];

}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];


    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5,
                            CGRectGetHeight(topVC.view.bounds),
                            self.frame.size.width,
                            self.frame.size.height);
    if (_leftLeave) {
        self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
    }else {
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
    }
    
    [super removeFromSuperview];
    
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    NSLog(@"sssss");
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.11f;
        self.backImageView.alpha = 0.7f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView addGestureRecognizer:tapGesture];
        
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    
  
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame =  self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - self.frame.size.height) * 0.5,
                                              self.frame.size.width,
                                              self.frame.size.height);


    [super willMoveToSuperview:newSuperview];
}

#pragma mark UITapGestureRecognizer
-(void)handleTapPress:(UITapGestureRecognizer *)gestureRecognizer
{
    _leftLeave = YES;
    [self dismissAlert];
}
#pragma mark -
-(void)resetFrame{
    CGSize labelSize = [self.tvContent sizeThatFits:CGSizeMake(kContentWidth, 1000)];
    
    {
        CGRect frame=self.tvContent.frame;
        frame.size.height=MAX(labelSize.height, kContentMinHeight);
        frame.size.height=MIN(labelSize.height, kContentMaxHeight);
        self.tvContent.frame=frame;
//        self.tvContent.scrollEnabled=(self.tvContent.frame.size.height==kContentMaxHeight);
    }
    CGSize labelSize1 = [self.tvBottom sizeThatFits:CGSizeMake(kContentWidth, 1000)];
    
    {
        CGRect frame=self.tvBottom.frame;
        frame.size.height=MAX(labelSize1.height, kContentMinHeight);
        frame.size.height=MIN(labelSize1.height, kContentMaxHeight);
        self.tvBottom.frame=frame;
//                self.tvContent.scrollEnabled=(self.tvContent.frame.size.height==kContentMaxHeight);
    }
    

    {

        CGRect leftBtnFrame = CGRectMake(0, CGRectGetMaxY(self.tvContent.frame)+kContentBottomMargin, (kAlertWidth - KCoupleButtonPadding) / 2, kButtonHeight);
        CGRect rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + KCoupleButtonPadding, CGRectGetMaxY(self.tvContent.frame)+kContentBottomMargin, (kAlertWidth - KCoupleButtonPadding) / 2, kButtonHeight);
        self.leftBtn.frame = leftBtnFrame;
        self.rightBtn.frame = rightBtnFrame;
    }
    
    {
        CGRect frame=self.frame;
        frame.size.height=kTitleTopMargin+kTitleHeight+kContentTopMargin*2+kContentBottomMargin+kButtonHeight+kButtonBottomMargin
        +self.tvContent.frame.size.height+self.tvBottom.frame.size.height;
        NSLog(@"the frame is %f",self.tvContent.frame.size.height);
        frame.size.width=kAlertWidth;
        self.frame=frame;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
