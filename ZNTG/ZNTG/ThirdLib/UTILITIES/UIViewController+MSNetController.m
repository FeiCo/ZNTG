//
//  UIViewController+MSNetController.m
//  MyNote
//
//  Created by Sai on 16/2/19.
//  Copyright © 2016年 SayingLin. All rights reserved.
//

#import "UIViewController+MSNetController.h"
@implementation UIViewController (MSNetController)

/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现
 */
- (void)reloadNetRequest{
    
}

/**
 *  显示没有网络
 */
- (void)showNoNetWork{
    MSNoNetView *view = [MSNoNetView instanceNoNetView];
    view.delegate = self;
    [self.view addSubview:view];
}

/**
 *  隐藏没有网络
 */
- (void)hiddenNoNetWork{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[MSNoNetView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)reloadNetworkDataSource:(id)sender{
    if([self respondsToSelector:@selector(reloadNetRequest)]){
        [self performSelector:@selector(reloadNetRequest)];
    }
}
@end
