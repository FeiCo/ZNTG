//
//  MyBaseController.h
//
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 shouhonginfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardManager.h"

@interface MyBaseController : UIViewController
@property (nonatomic,strong,readonly) UIButton *leftBotton;
@property (nonatomic,strong,readonly) UIButton *rightButton;
@property (nonatomic,retain,readonly) IQKeyboardReturnKeyHandler *returnKeyHandler;

/**
 *  当屏幕发生旋转时回调该方法
 *
 *  @param notification
 */
- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification;

/**
 *  webSocket返回消息
 *
 *  @param notification
 */
- (void)webSocketReceiveMessage:(NSNotification *)notification;


/**
 *  webSocket连接状态
 *
 *  @param notification
 */
- (void)webSocketState:(NSNotification *)notification;


/**
 *  发送消息状态
 *
 *  @param notification
 */
- (void)sendMessageState:(NSNotification *)notification;


/**
 *  网络状态
 *
 *  @param notification 
 */
- (void)networkState:(NSNotification *)notification;

/**
 *  导航栏上左边按钮的事件
 *
 *  @param sender
 */
- (void)onClickLeftBtn:(UIButton *)sender;

/**
 *  导航栏上右边按钮的事件
 *
 *  @param sender 
 */
- (void)onClickRightBtn:(UIButton *)sender;


- (void)showHUDWithStr:(NSString *)str;
@end
