//
//  dengLuViewController.m
//  XinLanDe
//
//  Created by Peter on 6/8/16.
//  Copyright © 2016 Sai. All rights reserved.
//

#import "dengLuViewController.h"
#import "wjmmViewController.h"
#import "zhuceViewController.h"
#import "MSTextField.h"
#import "NSString+HandleString.h"
#import "MBProgressHUD.h"
#import "MSNetRequest.h"
#import "JSONKit.h"

#import "UIDevice+ScreenType.h"

//tencent login
//#import <ImSDK/ImSDK.h>

//#import "IMALoginParam.h"

#define kDaysInSeconds(x)      (x * 24 * 60 * 60)

#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]


@interface dengLuViewController ()

{
//    __weak id<WXApiDelegate>    _tlsuiwx;
//    TencentOAuth                *_openQQ;
//    IMALoginParam               *_loginParam;
}


@property(nonatomic,weak) MSTextField *phoneField;
@property(nonatomic,weak) MSTextField *passWordField;

@property(nonatomic,weak) UISwitch *remenberPassword;

@property(nonatomic,copy) NSString *userSig;
@property(nonatomic,assign)BOOL isLoginIMMode;

@end

@implementation dengLuViewController


#define kIMAAutoLoginParam @"kIMAAutoLoginParam"

- (void)dealloc
{
    if(self.isLoginIMMode == 1) {
    DebugLog(@"IMALoginViewController=====>>>>> release");
//    _tlsuiwx = nil;
//    _openQQ = nil;
    
//    [_loginParam saveToLocal];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setDengLuView];
    // Do any additional setup after loading the view.
    if(self.isLoginIMMode == 1)
    {
    
//tencent add
//    [WXApi registerApp:WX_APP_ID];
    //demo暂不提供微博登录
    //[WeiboSDK registerApp:WB_APPKEY];
    
    // 因TLSSDK在IMSDK里面初始化，必须先初始化IMSDK，才能使用TLS登录
    // 导致登出然后使用相同的帐号登录，config会清掉
//    
//    BOOL isAutoLogin = [IMAPlatform isAutoLogin];
//    if (isAutoLogin)
//    {
//        _loginParam = [IMALoginParam loadFromLocal];
//    }
//    else
//    {
//        _loginParam = [[IMALoginParam alloc] init];
//    }
//    
//    [IMAPlatform configWith:_loginParam.config];
//    
//    if (isAutoLogin && [_loginParam isVailed])
//    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self autoLogin];
//        });
//    }
//    else
//    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [self pullLoginUI];
//        });
//        
//    }
 
    
//tencent add
    }
    
}



//- (void)autoLogin
//{
//    if ([_loginParam isExpired])
//    {
//        [[HUDHelper sharedInstance] syncLoading:@"刷新票据。。。"];
//        //刷新票据
//        [[TLSHelper getInstance] TLSRefreshTicket:_loginParam.identifier andTLSRefreshTicketListener:self];
//    }
//    else
//    {
//        [self loginIMSDK];
//    }
//}



//- (void)loginIMSDK
//{
//    //直接登录
//    __weak dengLuViewController *weakSelf = self;
//    [[HUDHelper sharedInstance] syncLoading:@"正在登录"];
//    [[IMAPlatform sharedInstance] login:_loginParam succ:^{
//        [[HUDHelper sharedInstance] syncStopLoadingMessage:@"登录成功"];
//        NSLog(@"登录成功");
////        [weakSelf enterMainUI];
//        [weakSelf dismissViewControllerAnimated:YES completion:^{
//        }];
//        
//    } fail:^(int code, NSString *msg) {
//        [[HUDHelper sharedInstance] syncStopLoadingMessage:IMALocalizedError(code, msg) delay:2 completion:^{
////            [weakSelf pullLoginUI];
//        }];
//    }];
//}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *isremerberpsw = [userDefaults objectForKey:kUserRemenberPSW];
    NSString *phone = [userDefaults objectForKey:kUserName];
    NSString *passWord = [userDefaults objectForKey:kUserLoginPSW];
    if(phone){
        self.phoneField.text = phone;
    }
    if (isremerberpsw) {
    if ([isremerberpsw isEqualToString:@"YES"]) {
        [_remenberPassword setOn:YES];
        if (passWord) {
            self.passWordField.text = passWord;
        }
      }
    }
   
}


-(void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (_remenberPassword.isOn) {
        
       [userDefaults setValue:@"YES" forKey:kUserRemenberPSW];
    }
    else
    {
        [userDefaults setValue:@"NO" forKey:kUserRemenberPSW];
    }
    
}


-(void)setDengLuView{
    
    UIButton *dismissb = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissb.frame = CGRectMake(20, 30, 30, 30);
    [dismissb setImage:[UIImage imageNamed:@"dismissX"] forState:UIControlStateNormal];
    [dismissb addTarget:self action:@selector(dismissBClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((screenB.size.width - 60) /2, 30, 60, 30)];
    title.text = @"登录";
    title.font = [UIFont systemFontOfSize:20];
    
    
//    UILabel  *title = [[UILabel alloc] initWithFrame:CGRectMake((screenB.size.width - 60) / 2, 25, 60, 40)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.font = [UIFont boldSystemFontOfSize:22];
//    title.text = @"登录";
    
//    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dlicon"]];
//    UIImageView *iconbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dliconbg"]];
    
    
    //for denglu
    UIView *fengeV1 = [[UIView alloc] init];
    fengeV1.backgroundColor = color(200, 200, 200, 1);
    UIView *fengeV2 = [[UIView alloc] init];
    fengeV2.backgroundColor = color(200, 200, 200, 1);
    
    UIImageView *userImage =[[UIImageView alloc] init];
    UIImageView *passwordImage = [[UIImageView alloc] init];
    userImage.image = [UIImage imageNamed:@"DLPhone"];
    passwordImage.image = [UIImage imageNamed:@"DLpassword"];
    
    
    MSTextField *userT = [[MSTextField alloc] init];
    MSTextField *passwordT = [[MSTextField alloc] init];
    userT.tintColor = color(239, 78, 81, 1);
    passwordT.tintColor = color(239, 78, 81, 1);
    passwordT.secureTextEntry = YES;
    userT.placeholder = @"请输入用户名";
    passwordT.placeholder = @"请输入密码";
    userT.clearButtonMode = YES;
    passwordT.clearButtonMode = YES;
    userT.borderStyle = UITextBorderStyleNone;
    passwordT.borderStyle = UITextBorderStyleNone;
    
    UIView *blackbackground = [[UIView alloc] init];
    blackbackground.backgroundColor = color(254, 255, 255, 1);
    
    
    UIButton *denglu = [UIButton buttonWithType:UIButtonTypeSystem];
    denglu.backgroundColor = color(239, 78, 81, 1);
    [denglu setTitle:@"登录" forState:UIControlStateNormal];
    denglu.titleLabel.font = [UIFont systemFontOfSize:18];
    [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    denglu.layer.cornerRadius = 5;
    [denglu addTarget:self action:@selector(dengluB) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPass setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPass.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetPass setTitleColor:color(93, 94, 95, 1) forState:UIControlStateNormal];
    forgetPass.titleLabel.textAlignment = NSTextAlignmentLeft;
    [forgetPass addTarget:self action:@selector(wangJiMiMa) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *hmyzh = [[UILabel alloc] init ];
    hmyzh.text = @"还没有账号？";
    hmyzh.font = [UIFont systemFontOfSize:13];
    hmyzh.textColor = [UIColor grayColor];
    
    UIButton *registe = [UIButton buttonWithType:UIButtonTypeSystem];
    registe.titleLabel.textAlignment = NSTextAlignmentRight;
    [registe setTitle:@"立即注册" forState:UIControlStateNormal];
    registe.titleLabel.font = [UIFont systemFontOfSize:13];
    [registe setTitleColor:color(242, 138, 142, 1) forState:UIControlStateNormal];
    [registe addTarget:self action:@selector(zhuCe) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //for denglu
    UIView *fengeV3 = [[UIView alloc] init];
    fengeV3.backgroundColor = color(232, 233, 233, 1);

    UILabel *yyzhdl = [[UILabel alloc] init];
    yyzhdl.text = @"已有账户登录";
    yyzhdl.backgroundColor = [UIColor whiteColor];
    yyzhdl.textAlignment = NSTextAlignmentCenter;
    yyzhdl.font = [UIFont systemFontOfSize:13];
    yyzhdl.textColor = color(242, 138, 142, 1);
    
    
    //qq
    UIButton *qqbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqbtn setImage:[UIImage imageNamed:@"dsfqq"] forState:UIControlStateNormal];
    qqbtn.tag = 3;
    [qqbtn addTarget:self action:@selector(diSanFangClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *qqtitle = [[UILabel alloc]init];
    qqtitle.text = @"QQ";
    qqtitle.textColor = color(100, 100, 100, 1);
    qqtitle.textAlignment = NSTextAlignmentCenter;
    qqtitle.font = [UIFont systemFontOfSize:14];
    //wx
    UIButton *wxbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxbtn setImage:[UIImage imageNamed:@"dsfwx"] forState:UIControlStateNormal];
    wxbtn.tag = 1;
    [wxbtn addTarget:self action:@selector(diSanFangClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *wxtitle = [[UILabel alloc]init];
    wxtitle.text = @"微信";
    wxtitle.textColor = color(100, 100, 100, 1);
    wxtitle.textAlignment = NSTextAlignmentCenter;
    wxtitle.font = [UIFont systemFontOfSize:14];

    //wb
    UIButton *wbbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wbbtn setImage:[UIImage imageNamed:@"dsfwb"] forState:UIControlStateNormal];
    
    wbbtn.tag = 2;
    [wbbtn addTarget:self action:@selector(diSanFangClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *wbtitle = [[UILabel alloc]init];
    wbtitle.text = @"微博";
    wbtitle.textColor = color(100, 100, 100, 1);
    wbtitle.textAlignment = NSTextAlignmentCenter;
    wbtitle.font = [UIFont systemFontOfSize:14];

    
    UILabel *jiZhuMiMA = [[UILabel alloc] init];
    jiZhuMiMA.text = @"记住密码";
    jiZhuMiMA.font = [UIFont systemFontOfSize:14];
    
    UISwitch *switcher = [[UISwitch alloc] init];
//    switcher.tintColor = color(241, 74, 25, 1);
    switcher.onTintColor = color(239, 78, 81, 1);
    [switcher.layer setValue:@(0.6) forKey:@"transform.scale"];
//    [switcher addTarget:self action:@selector(switcherStateChange:) forControlEvents:UIControlEventValueChanged];
    _remenberPassword = switcher;
    
  
    
    
    CGFloat dsfPadding = (screenB.size.width - 120) / 6;
    
//    icon.frame = CGRectMake((screenB.size.width - 80) / 2, 80, 80, 80);
//    iconbg.frame = CGRectMake((screenB.size.width - 80) / 2, 80, 130, 130);
    
    fengeV1.frame = CGRectMake(80, 40, screenB.size.width - 120, 0.5);
    fengeV2.frame = CGRectMake(80, 90, screenB.size.width - 120, 0.5);
    userImage.frame = CGRectMake(40, 13.5, 20, 23);
    passwordImage.frame = CGRectMake(40, 63.5, 20, 23);
    userT.frame = CGRectMake(80, 5, screenB.size.width - 30 - 80, 40);
    passwordT.frame = CGRectMake(80, 55, screenB.size.width - 30 - 80, 40);
    blackbackground.frame = CGRectMake(0, 130, screenB.size.width, 100);
    
    jiZhuMiMA.frame = CGRectMake(screenB.size.width - 157, 235,80, 44);
    switcher.frame = CGRectMake(screenB.size.width - 90, 240, 80, 44);
    
    denglu.frame = CGRectMake(40, 290, screenB.size.width - 80, 44);
    forgetPass.frame = CGRectMake(30, 375, 100, 20);
    hmyzh.frame = CGRectMake(screenB.size.width - 80 - 100, 375, 80, 20);
    registe.frame = CGRectMake(screenB.size.width - 30 - 100, 375, 100, 20);
    
    fengeV3.frame = CGRectMake(40, screenB.size.height - 107, screenB.size.width - 80, 0.5);
    yyzhdl.frame = CGRectMake((screenB.size.width - 120) / 2, screenB.size.height - 117, 120, 20);
    qqbtn.frame = CGRectMake(4 * dsfPadding + 80, screenB.size.height - 80, 40,40);
    qqtitle.frame = CGRectMake(4 * dsfPadding + 80, screenB.size.height - 33, 40, 20);
    wxbtn.frame = CGRectMake(2 * dsfPadding, screenB.size.height - 80, 40,40);
    wbbtn.frame = CGRectMake(3 * dsfPadding + 40, screenB.size.height - 80, 40,40);
    wxtitle.frame = CGRectMake(2 * dsfPadding, screenB.size.height - 33, 40, 20);
    wbtitle.frame = CGRectMake(3 * dsfPadding + 40, screenB.size.height - 33, 40, 20);
    

    
    [blackbackground addSubview:fengeV1];
    [blackbackground addSubview:fengeV2];

    [blackbackground addSubview:userImage];
    [blackbackground addSubview:passwordImage];
    [blackbackground addSubview:userT];
    [blackbackground addSubview:passwordT];
    [self.view addSubview:jiZhuMiMA];
    [self.view addSubview:switcher];
    
//    [self.view addSubview:title];
//    [self.view addSubview:iconbg];
//    [self.view addSubview:icon];
    [self.view addSubview:dismissb];
    [self.view addSubview:title];
    
    [self.view addSubview:blackbackground];
    [self.view addSubview:denglu];
    [self.view addSubview:forgetPass];
    [self.view addSubview:registe];
    [self.view addSubview:hmyzh];
    
//    [self.view addSubview:fengeV3];
//    [self.view addSubview:yyzhdl];
//    
//    [self.view addSubview:qqtitle];
//    [self.view addSubview:qqbtn];
//    [self.view addSubview:wxtitle];
//    [self.view addSubview:wxbtn];
//    [self.view addSubview:wbtitle];
//    [self.view addSubview:wbbtn];
    
    _phoneField = userT;
    _passWordField = passwordT;
}

//
//-(void)switcherStateChange:(UISwitch *)sender {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    if (sender.isOn) {
//        DebugLog(@"denglu switch is on");
//       [userDefaults setValue:@"YES" forKey:kUserRemenberPSW];
//    }
//    else
//    {
//        DebugLog(@"denglu switch is off");
//        [userDefaults setValue:@"NO" forKey:kUserRemenberPSW];
//    }
//    
//}

//第三方登录点击事件
-(void)diSanFangClick:(UIButton *)sender {
    
    
    NSLog(@"第三方点击按钮%li",(long)sender.tag);
}


-(void)dengluB {
    NSString *userAccount = [_phoneField.text stringByTrimingWhitespace];
    NSString *userPassWord = [_passWordField.text stringByTrimingWhitespace];
    
    if([userAccount length] <= 0 || [userPassWord length] <= 0){
        if([userAccount length] <= 0){
            [self showHUDWithStr:@"请输入手机号"];
            [_phoneField showShakeAnimation];
        }else{
            [self showHUDWithStr:@"请输入密码"];
            [_passWordField showShakeAnimation];
        }
    }else{
        
        __weak UIView *selfView = self.view;
        MBProgressHUD *showHUD = [MBProgressHUD showHUDAddedTo:selfView animated:YES];
        showHUD.color = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        showHUD.animationType = MBProgressHUDAnimationZoomOut;
        showHUD.mode = MBProgressHUDModeIndeterminate;
        showHUD.labelText = @"登录中...";
        [showHUD hide:YES afterDelay:5];
        
        NSDictionary *dictionary = @{@"username":userAccount,@"password":userPassWord};
        [MSNetRequest requestMethodsWithPOST:dictionary url:kGetLogin successBlock:^(id responseObject) {
            [showHUD removeFromSuperview];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *jsonDictionary = [jsonString objectFromJSONStringWithParseOptions:JKSerializeOptionPretty];
        
            NSNumber *type = [jsonDictionary objectForKey:@"type"];
            if(type.integerValue == 1){
                
                NSDictionary *datadic = [jsonDictionary valueForKey:@"obj"];
                
                NSString *userAutoGraph = [datadic valueForKey:kUserAutoGraph];
                NSString *userBirthday = [datadic valueForKey:kUserBirthday];
                NSString *headerImage = [datadic valueForKey:kUserImage];
                NSString *userNickName = [datadic valueForKey:kUserNickName];
                NSString *userId = [datadic valueForKey:kUserId];
                NSString *userName= [datadic valueForKey:kUserName];
                NSString *userGender = [datadic valueForKey:kUserGender];
                NSString *userToken = [jsonDictionary valueForKey:kUserToken];
                NSString *loginstate = [_remenberPassword isOn] ? @"YES" : @"NO";
                
                [userDefaults setValue:@"YES" forKey:kUserLoginState];
                [userDefaults setValue:userAutoGraph forKey:kUserAutoGraph];
                [userDefaults setValue:userBirthday forKey:kUserBirthday];
                [userDefaults setValue:headerImage forKey:kUserImage];
                [userDefaults setValue:userNickName forKey:kUserNickName];
                [userDefaults setValue:userId forKey:kUserId];
                [userDefaults setValue:userName forKey:kUserName];
                [userDefaults setValue:userGender forKey:kUserGender];
                [userDefaults setValue:userToken forKey:kUserToken];
                [userDefaults setValue:userPassWord forKey:kUserLoginPSW];
                [userDefaults setValue:loginstate forKey:kUserRemenberPSW];

                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }else
            {
                [self showHUDWithStr:@"用户名或密码错误"];
                [userDefaults setObject:@"NO" forKey:kUserLoginState];
                [userDefaults synchronize];
            }
        } failureBlock:^(NSString *err) {
            [showHUD removeFromSuperview];
            [self showHUDWithStr:@"网络不给力！"];
        }];
        
    }
}



//-(void)tencentLogin{
////    TIMLoginParam *login_param1 = [[TIMLoginParam alloc ]init];
////    login_param1.accountType = @"200";
////    login_param1.identifier = @"1000007";
////    login_param1.userSig = _userSig;
////    login_param1.appidAt3rd = @"1400011448";
////    login_param1.sdkAppId = 1400011448;
//    
//    
//    _openQQ = nil;
//    _tlsuiwx = nil;
//    dispatch_async(dispatch_get_main_queue(), ^{
//            _loginParam.identifier = @"13917912367";
//            _loginParam.accountType = @"200";
//            _loginParam.appidAt3rd = @"1400011448";
//            _loginParam.sdkAppId = 1400011448;
//            _loginParam.userSig = _userSig;
//            _loginParam.tokenTime = [[NSDate date] timeIntervalSince1970];
//            // 获取本地的登录config
//            [self loginIMSDK];
//    });
//    
//
//    [self loginIMSDK];
//}




-(void)wangJiMiMa{
  
    wjmmViewController * wjmm = [[wjmmViewController alloc] init];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    [self.navigationController pushViewController:wjmm animated:YES];
    
    
}

-(void)zhuCe {
    zhuceViewController *zhuce = [[zhuceViewController alloc] init];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    [self.navigationController pushViewController:zhuce animated:YES];
    
}


-(void)dismissBClick{
    
   [ self dismissViewControllerAnimated:YES completion:^{
        
   }];
}


#pragma mark - TLSOpenLoginListener

////第三方登录成功之后，再次登陆tls换取userinfo
//-(void)OnOpenLoginSuccess:(TLSUserInfo *)userinfo
//{
//    //回调时已结束登录流程 销毁微信回调对象
//    //根据登录结果处理
////    [self loginWith:userinfo];
//}
//
//-(void)OnOpenLoginFail:(TLSErrInfo*)errInfo
//{
//    DebugLog(@"%@",errInfo);
//}
//
//-(void)OnOpenLoginTimeout:(TLSErrInfo*)errInfo
//{
//    DebugLog(@"%@",errInfo);
//}

#pragma mak - delegate<TencentLoginDelegate>
-(void)tencentDidNotNetWork
{
    DebugLog(@"tencentDidNotNetWork");
}

-(void)tencentDidLogin
{
    DebugLog(@"tencentDidLogin");
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    DebugLog(@"tencentDidNotLogin");
}




-(instancetype)initWithLoginMode:(DengLuLoginMode)mode{
    self = [super init];
    if (self) {
        if (DengLuLoginModedBoth) {
            _isLoginIMMode =YES;
        }
        else
        {
            _isLoginIMMode = NO;
        }
    }
    return self;
}

-(BOOL)isLoginIMMode {
    if(!_isLoginIMMode)
    {
        _isLoginIMMode = NO;
    }
    return _isLoginIMMode;
}

@end
