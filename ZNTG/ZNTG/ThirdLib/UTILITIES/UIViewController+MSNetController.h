//
//  UIViewController+MSNetController.h
//  MyNote
//
//  Created by Sai on 16/2/19.
//  Copyright © 2016年 SayingLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSNoNetView.h"

@interface UIViewController (MSNetController)<MSNoNetViewDelegate>

/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现
 */
- (void)reloadNetRequest;

/**
 *  显示没有网络视图
 */
- (void)showNoNetWork;

/**
 *  隐藏没有网络视图
 */
- (void)hiddenNoNetWork;
@end
