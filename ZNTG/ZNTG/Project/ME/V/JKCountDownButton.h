//
//  JKCountDownButton.h
//  BangBangCai
//
//  Created by handjc on 15/4/2.
//  Copyright (c) 2015年 TianYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;
typedef NSString* (^DidChangeBlock)(JKCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(JKCountDownButton *countDownButton,int second);

typedef void (^TouchedDownBlock)(JKCountDownButton *countDownButton,NSInteger tag);

@interface JKCountDownButton : UIButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}

@property (nonatomic,strong) UIColor *changeFontColor;
@property (nonatomic,strong) UIColor *normalFontColor;
- (void)addToucheHandler:(TouchedDownBlock)touchHandler;

- (void)didChange:(DidChangeBlock)didChangeBlock;
- (void)didFinished:(DidFinishedBlock)didFinishedBlock;
- (void)startWithSecond:(int)second;
- (void)stop;
@end
