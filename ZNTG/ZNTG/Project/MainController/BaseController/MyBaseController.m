//
//  BaseViewController.m
//  ShiJiBroadcast
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 shouhonginfo. All rights reserved.
//

#import "MyBaseController.h"
#import "MBProgressHUD.h"
#import "UIImage+PHTintColor.h"

@interface MyBaseController (){
    UIButton *_leftBotton;
    UIButton *_rightButton;
    IQKeyboardReturnKeyHandler *_returnKeyHandler;
}
@end

@implementation MyBaseController
- (UIButton *)leftBotton{
    if(!_leftBotton){
        _leftBotton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBotton.backgroundColor = [UIColor clearColor];
        _leftBotton.frame = CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight);
        UIImage *image = [UIImage imageNamed:@"NaviBack"];
        [_leftBotton setImage:[image imageWithTintColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_leftBotton addTarget:self action:@selector(onClickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBotton;
}

- (UIButton *)rightButton{
    if(!_rightButton){
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        _rightButton.frame = CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight);
        //  [_rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(onClickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (IQKeyboardReturnKeyHandler *)returnKeyHandler{
    if(!_returnKeyHandler){
       _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    }
    return _returnKeyHandler;
}

- (void)showHUDWithStr:(NSString *)str{
    __weak typeof(self.view) weekSelf = self.view;
    MBProgressHUD *showHUD = [MBProgressHUD showHUDAddedTo:weekSelf animated:YES];
    showHUD.color = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
    showHUD.animationType = MBProgressHUDAnimationZoomOut;
    showHUD.mode = MBProgressHUDModeText;
    showHUD.labelText = str;
//    showHUD.labelColor = [UIColor whiteColor];
    [showHUD hide:YES afterDelay:1];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    navigationBar.barTintColor = kThemeColor;

    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBotton];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDefault;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //屏幕旋转
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
//    //webSocket返回的信息
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webSocketReceiveMessage:) name:kWebSocketReceiveMessage object:nil];
//    
//    //webSocket的状态
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webSocketState:) name:kWebSocketState object:nil];
//    
//    //发送消息的状态
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendMessageState:) name:kSendMessageState object:nil];
//    
//    //网络状态
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkState:) name:kNetworkState object:nil];
    
}


- (void)webSocketReceiveMessage:(NSNotification *)notification{
}

- (void)webSocketState:(NSNotification *)notification{
}


- (void)sendMessageState:(NSNotification *)notification{
}

- (void)networkState:(NSNotification *)notification{
}

- (void)onClickLeftBtn:(UIButton *)sender{
     NSLog(@"%@",kMethodMessage);
}


- (void)onClickRightBtn:(UIButton *)sender{
    NSLog(@"%@",kMethodMessage);
}


- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification{
    NSLog(@"%@",kMethodMessage);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

/**
 *  是否支持屏幕旋转
 *
 *  @return YES:支持
 */
- (BOOL)shouldAutorotate{
    return NO;
}

/**
 *  支持屏幕旋转的方向
 *
 *  @return 
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  屏幕将要旋转时回调该方法
 *
 *  @param toInterfaceOrientation
 *  @param duration
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"开始旋转屏幕");
}


/**
 *  屏幕旋转完成时回调该方法
 *
 *  @param fromInterfaceOrientation
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [UIViewController attemptRotationToDeviceOrientation];
     NSLog(@"结束旋转屏幕");
}
@end
