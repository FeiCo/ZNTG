//
//  zhuceViewController.m
//  XinLanDe
//
//  Created by Peter on 6/8/16.
//  Copyright © 2016 Sai. All rights reserved.
//

#import "zhuceViewController.h"

#import "MSTextField.h"
#import "JKCountDownButton.h"

#import "LYHTTPClient.h"

#import "MSNetRequest.h"
#import "NSString+HandleString.h"
#import "JSONKit.h"
#import "DTAlertView.h"


#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface zhuceViewController ()

@property (nonatomic,strong) MSTextField *nickNameField;//用户昵称
@property (nonatomic,strong) MSTextField *phoneField;//手机号
@property (nonatomic,strong) MSTextField *verifyCodeField;//验证码
@property (nonatomic,strong) MSTextField *passWordField;//密码
@property (nonatomic,weak) UISwitch *obeyLisences;//密码

@end

@implementation zhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账号注册";
    [self.leftBotton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];    // Do any additional setup after loading the view.
    [self setZhuCeView];
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setZhuCeView {
    UIView *whiteBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 15, screenB.size.width, 250)];
    whiteBackground.backgroundColor = [UIColor whiteColor];
    
    UIView *fengexian1 = [[UIView alloc] initWithFrame:CGRectMake(60, 50, screenB.size.width - 100, 0.5)];
    UIView *fengexian2 = [[UIView alloc] initWithFrame:CGRectMake(60, 100, screenB.size.width - 100, 0.5)];
    UIView *fengexian3 = [[UIView alloc] initWithFrame:CGRectMake(60, 150, screenB.size.width - 100, 0.5)];
    UIView *fengexian4 = [[UIView alloc] initWithFrame:CGRectMake(60, 200, screenB.size.width - 100, 0.5)];
    fengexian1.backgroundColor = color(239, 240, 240, 1);
    fengexian2.backgroundColor = color(239, 240, 240, 1);
    fengexian3.backgroundColor = color(239, 240, 240, 1);
    fengexian4.backgroundColor = color(239, 240, 240, 1);
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 113.5, 20, 23)];
    UIImageView *shoujiImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13.5, 20, 23)];
    UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 163.5, 20, 23)];
    UIImageView *yanzhengma = [[UIImageView alloc] initWithFrame:CGRectMake(20, 63.5, 20, 23)];
    
    UISwitch *obeyLicense = [[UISwitch alloc] init];
    //    switcher.tintColor = color(241, 74, 25, 1);
    obeyLicense.onTintColor = color(239, 78, 81, 1);
    [obeyLicense.layer setValue:@(0.4) forKey:@"transform.scale"];
    obeyLicense.frame = CGRectMake(100, 200, 60, 60);
    
    userImage.image = [UIImage imageNamed:@"DLusername"];
    passwordImage.image = [UIImage imageNamed:@"DLpassword"];
    yanzhengma.image = [UIImage imageNamed:@"DLyzm"];
    shoujiImage.image = [UIImage imageNamed:@"DLPhone"];
    
    
    MSTextField *userT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 105, screenB.size.width - 30 - 60, 40)];
    MSTextField *phoneT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 5, screenB.size.width - 30 - 60, 40)];
    MSTextField *passwordT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 155, screenB.size.width - 30 - 60, 40)];
    MSTextField *yanzhengmaT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 55, screenB.size.width - 30 - 160, 40)];
    passwordT.secureTextEntry = YES;
    JKCountDownButton *fasong = [JKCountDownButton buttonWithType:UIButtonTypeSystem];
    fasong.frame = CGRectMake(screenB.size.width - 120, 60, 100, 30);
    [fasong setTitle:@"获取验证码" forState:UIControlStateNormal];
    [fasong setTintColor:color(239, 24, 24, 1)];
    fasong.layer.borderWidth = 1;
    fasong.layer.borderColor = color(239, 24, 24, 1).CGColor;
    fasong.layer.cornerRadius = 15;
    [fasong addTarget:self action:@selector(onClickVerifyCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    phoneT.tintColor = color(241, 74, 25, 1);
    userT.tintColor = color(241, 74, 25, 1);
    passwordT.tintColor = color(241, 74, 25, 1);
    yanzhengmaT.tintColor = color(241, 74, 25, 1);
    
    userT.placeholder = @"请输入昵称";
    phoneT.placeholder =@"请输入手机号";
    passwordT.placeholder = @"请输入密码";
    yanzhengmaT.placeholder =@"请输入验证码";
    
    userT.clearButtonMode = YES;
    passwordT.clearButtonMode = YES;
    phoneT.clearButtonMode = YES;
    yanzhengmaT.clearButtonMode = YES;
    
    
    UIButton *zhuceB = [UIButton buttonWithType:UIButtonTypeSystem];
    zhuceB.backgroundColor = color(239, 78, 81, 1);
    [zhuceB setTitle:@"注册" forState:UIControlStateNormal];
    zhuceB.titleLabel.font = [UIFont systemFontOfSize:18];
    [zhuceB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuceB.frame = CGRectMake(40, 315, screenB.size.width - 80, 44);
    zhuceB.layer.cornerRadius = 5;
    [zhuceB addTarget:self action:@selector(onClickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteBackground addSubview:fengexian1];
    [whiteBackground addSubview:fengexian2];
    [whiteBackground addSubview:fengexian3];
    [whiteBackground addSubview:fengexian4];
    [whiteBackground addSubview:userImage];
    [whiteBackground addSubview:passwordImage];
    [whiteBackground addSubview:shoujiImage];
    [whiteBackground addSubview:yanzhengma];
    
    [whiteBackground addSubview:userT];
    
    [whiteBackground addSubview:passwordT];
    [whiteBackground addSubview:yanzhengmaT];
    [whiteBackground addSubview:phoneT];
    [whiteBackground addSubview:fasong];
    
    
    [self.view addSubview:whiteBackground];
    [self.view addSubview:zhuceB];
    [self.view addSubview:obeyLicense];
    
    _nickNameField = userT;
    _phoneField = phoneT;
    _verifyCodeField = yanzhengmaT;
    _passWordField = passwordT;
    _obeyLisences = obeyLicense;
    
    
}



- (void)onClickVerifyCodeBtn:(JKCountDownButton *)sender{
    NSString *phoneString = [_phoneField.text stringByTrimingWhitespace];
    BOOL isPhoneNumber = [phoneString verifyIsPhoneNumber];
    
    if([phoneString length] <= 0 || !isPhoneNumber){
        [self showHUDWithStr:@"请输入11位手机号"];
        [_phoneField showShakeAnimation];
    }else{
        sender.enabled = NO;
        
        [sender startWithSecond:180];
        [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
        
        NSDictionary *dictionary = @{@"phone":phoneString};
        
        NSLog(@"%@",kGetSMSValidate);

        [MSNetRequest requestMethodsWithPOST:dictionary url:kGetSMSValidate successBlock:^(id responseObject) {
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *jsondic = [jsonString objectFromJSONString];
            NSLog(@"the result:%@ data:%@ message:%@",[jsondic valueForKey:@"result"],[jsondic valueForKey:@"data"],[jsondic valueForKey:@"message"]);
            NSString *result = [jsondic valueForKey:@"result"];
            if([result isEqualToString:@"SendOver"]){
                [self showHUDWithStr:@"次数已达到上限,每天仅4次"];
                [sender stop];
            }else if ([result isEqualToString:@"success"]){
                [self showHUDWithStr:@"获取验证码成功"];
            }else if ([result isEqualToString:@"SendFalse"]){
                [self showHUDWithStr:@"发送失败"];
                [sender stop];
            }else if ([result isEqualToString:@"TelPhoneError"]){
                [self showHUDWithStr:@"手机号码错误"];
                [sender stop];
            }
        } failureBlock:^(NSString *errorDescribe) {
            [self showHUDWithStr:@"网络不给力！"];
            [sender stop];
        }];
        
    }
}



- (void)onClickRegisterBtn:(UIButton *)sender{
    NSString *nickNameString = [_nickNameField.text stringByTrimingWhitespace];
    NSString *phoneString = [_phoneField.text stringByTrimingWhitespace];
    NSString *verifyCodeString = [_verifyCodeField.text stringByTrimingWhitespace];
    NSString *passWordString = [_passWordField.text stringByTrimingWhitespace];

    
    BOOL isPhoneNumber = [phoneString verifyIsPhoneNumber];
    
    
    if([nickNameString length] <= 0){
        [self showHUDWithStr:@"昵称不能为空"];
        [_nickNameField showShakeAnimation];
    }else if([phoneString length] <= 0 || !isPhoneNumber){
        [self showHUDWithStr:@"请输入11位手机号"];
        [_phoneField showShakeAnimation];
    }else if ([verifyCodeString length] <= 0){
        [self showHUDWithStr:@"请输入验证码"];
        [_verifyCodeField showShakeAnimation];
    }else if ([passWordString length] <= 0){
        [self showHUDWithStr:@"请输入密码"];
        [_passWordField showShakeAnimation];
    }else{
        
        NSDictionary *dictionary = @{@"phone":phoneString,@"password":passWordString,@"code":verifyCodeString};
        
            
        [MSNetRequest requestMethodsWithPOST:dictionary url:kGetRegister successBlock:^(id responseObject) {
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *jsonDictionary = [jsonString objectFromJSONStringWithParseOptions:JKSerializeOptionPretty];
            
            NSString *statString = [jsonDictionary objectForKey:@"RegisterState"];
            if([statString isEqualToString:@"VcodeFalese"]){
                [self showHUDWithStr:@"验证码不正确"];
            }else if ([statString isEqualToString:@"VcodeNull"]){
                [self showHUDWithStr:@"未发送验证码！"];
            }else if ([statString isEqualToString:@"passwordFalese"]){
                [self showHUDWithStr:@"两次输入的密码不一致！"];
            }else if ([statString isEqualToString:@"QQRealdy"]){
                [self showHUDWithStr:@"手机号已被注册!"];
            }else if ([statString isEqualToString:@"NicknameFalese"]){
                [self showHUDWithStr:@"用户昵称已经存在!"];
            }else if ([statString isEqualToString:@"passwordFalese"]){
                [self showHUDWithStr:@"两次输入的密码不一致！"];
            }else if ([statString isEqualToString:@"RegisterFalese"]){
                [self showHUDWithStr:@"注册失败，请联系客服！"];

            }else if ([statString isEqualToString:@"RegisterSuccess"]){
                
                DTAlertView * alertView = [DTAlertView alertViewUseBlock:^(DTAlertView *alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex) {
                    if(buttonIndex == cancelButtonIndex){
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                    }
                } title:@"注册成功！" message:[NSString stringWithFormat:@"\n用户昵称:%@ \n密码：%@",nickNameString,passWordString] cancelButtonTitle:@"确定" positiveButtonTitle:@""];
                [alertView showWithAnimation:DTAlertViewAnimationSlideTop];
            }
        } failureBlock:^(NSString *err) {
            [self showHUDWithStr:@"网络不给力！"];
        }];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
