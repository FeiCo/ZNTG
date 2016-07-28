//
//  wjmmViewController.m
//  XinLanDe
//
//  Created by Peter on 6/8/16.
//  Copyright © 2016 Sai. All rights reserved.
//

#import "wjmmViewController.h"
#import "MSTextField.h"
#import "JKCountDownButton.h"
#import "NSString+HandleString.h"
#import "MSNetRequest.h"
#import "JSONKit.h"
#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface wjmmViewController ()

@property (nonatomic,strong) MSTextField *phoneField;//手机号
@property (nonatomic,strong) MSTextField *passWordField;//密码
@property (nonatomic,strong) MSTextField *againpassWordField;//再次确认密码
@property (nonatomic,strong) MSTextField *verifyCodeField;//验证码
@property (nonatomic,strong) UIButton *nextBtn;//下一步

@end

@implementation wjmmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor =  [UIColor whiteColor];
    self.title = @"修改密码";
    
    [self setzhmmView];
    [self.leftBotton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setzhmmView {
    UIView *whiteBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 15, screenB.size.width, 200)];
    whiteBackground.backgroundColor = [UIColor whiteColor];
    
    UIView *fengexian1 = [[UIView alloc] initWithFrame:CGRectMake(60, 50, screenB.size.width - 80, 0.5)];
    UIView *fengexian2 = [[UIView alloc] initWithFrame:CGRectMake(60, 100, screenB.size.width - 80, 0.5)];
    UIView *fengexian3 = [[UIView alloc] initWithFrame:CGRectMake(60, 150, screenB.size.width - 80, 0.5)];
    UIView *fengexian4 = [[UIView alloc] initWithFrame:CGRectMake(60, 200, screenB.size.width - 80, 0.5)];
    fengexian1.backgroundColor = color(200, 200, 200, 1);
    fengexian2.backgroundColor = color(200, 200, 200, 1);
    fengexian3.backgroundColor = color(200, 200, 200, 1);
    fengexian4.backgroundColor = color(200, 200, 200, 1);
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13.5, 20, 23)];
    UIImageView *passwordImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 113.5, 20, 23)];
    UIImageView *passwordImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 163.5, 20, 23)];
    UIImageView *yanzhengma = [[UIImageView alloc] initWithFrame:CGRectMake(20, 63.5, 20, 23)];
    
    userImage.image = [UIImage imageNamed:@"DLPhone"];
    passwordImage1.image = [UIImage imageNamed:@"DLpassword"];
    passwordImage2.image = [UIImage imageNamed:@"DLpassword"];
    yanzhengma.image = [UIImage imageNamed:@"DLyzm"];
    
    
    MSTextField *userT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 5, screenB.size.width - 30 - 60, 40)];

    MSTextField *yanzhengmaT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 55, screenB.size.width - 30 - 160, 40)];
    
    MSTextField *setpasswordT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 105, screenB.size.width - 30 - 60, 40)];
    
    MSTextField *makesurepasswordT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 155, screenB.size.width - 30 - 60, 40)];
    
    JKCountDownButton *fasong = [JKCountDownButton buttonWithType:UIButtonTypeSystem];
    setpasswordT.secureTextEntry = YES;
    makesurepasswordT.secureTextEntry = YES;
    fasong.frame = CGRectMake(screenB.size.width - 148, 60, 128, 30);
    [fasong setTitle:@"获取语音验证码" forState:UIControlStateNormal];
    [fasong setTintColor:color(239, 73, 75, 1)];
    fasong.layer.borderWidth = 1;
    fasong.layer.borderColor = color(239, 73, 75, 1).CGColor;
    fasong.layer.cornerRadius = 15;
    [fasong addTarget:self action:@selector(onClickVerifyCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    userT.tintColor = color(241, 74, 25, 1);
    setpasswordT.tintColor = color(241, 74, 25, 1);
    makesurepasswordT.tintColor = color(241, 74, 25, 1);
    yanzhengmaT.tintColor = color(241, 74, 25, 1);
    
    userT.placeholder = @"请输入手机号";
    setpasswordT.placeholder = @"设置您的密码";
    makesurepasswordT.placeholder = @"确认您的密码";
    yanzhengmaT.placeholder =@"您的手机验证码";
    
    userT.clearButtonMode = YES;
    setpasswordT.clearButtonMode = YES;
    makesurepasswordT.clearButtonMode = YES;
    yanzhengmaT.clearButtonMode = YES;
    
    
    UIButton *queDin = [UIButton buttonWithType:UIButtonTypeSystem];
    queDin.backgroundColor = color(241, 74, 25, 1);
    [queDin setTitle:@"确定" forState:UIControlStateNormal];
    queDin.titleLabel.font = [UIFont systemFontOfSize:18];
    [queDin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queDin.frame = CGRectMake(40, 255, screenB.size.width - 80, 44);
    queDin.layer.cornerRadius = 5;
    [queDin addTarget:self action:@selector(onClickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteBackground addSubview:fengexian1];
    [whiteBackground addSubview:fengexian2];
    [whiteBackground addSubview:fengexian3];
    [whiteBackground addSubview:fengexian4];
    [whiteBackground addSubview:userImage];
    [whiteBackground addSubview:passwordImage1];
    [whiteBackground addSubview:passwordImage2];
    [whiteBackground addSubview:yanzhengma];
    [whiteBackground addSubview:userT];
    [whiteBackground addSubview:setpasswordT];
    [whiteBackground addSubview:makesurepasswordT];
    [whiteBackground addSubview:yanzhengmaT];
    [whiteBackground addSubview:fasong];
    
    
    [self.view addSubview:whiteBackground];
    [self.view addSubview:queDin];
    
    _phoneField = userT;
    _passWordField = setpasswordT;
    _againpassWordField = makesurepasswordT;
    _verifyCodeField = yanzhengmaT;
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
        
        NSDictionary *dictionary = @{@"type":@"SendSMS",@"smstype":@"rf1",@"TelPhone":phoneString};
        [MSNetRequest requestMethodsWithPOST:dictionary url:kGetLogin successBlock:^(id responseObject) {
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            if([jsonString isEqualToString:@"SendOver"]){
                [self showHUDWithStr:@"次数已达到上限,每天仅4次"];
                [sender stop];
            }else if ([jsonString isEqualToString:@"SendSuccess"]){
                [self showHUDWithStr:@"获取验证码成功"];
            }else if ([jsonString isEqualToString:@"SendFalse"]){
                [self showHUDWithStr:@"发送失败"];
                [sender stop];
            }else if ([jsonString isEqualToString:@"TelPhoneError"]){
                [self showHUDWithStr:@"手机号码错误"];
                [sender stop];
            }
        } failureBlock:^(NSString *errorDescribe) {
            [self showHUDWithStr:@"网络不给力！"];
            [sender stop];
        }];
        
    }
}





-(void)onClickNextBtn:(UIButton *)sender {
    NSString *phoneString = [_phoneField.text stringByTrimingWhitespace];
    NSString *verifyCodeString = [_verifyCodeField.text stringByTrimingWhitespace];
    NSString *passWordString = [_passWordField.text stringByTrimingWhitespace];
    NSString *againpassWordString = [_againpassWordField.text stringByTrimingWhitespace];
    
    BOOL isPhoneNumber = [phoneString verifyIsPhoneNumber];
    
    
    if([phoneString length] <= 0 || !isPhoneNumber){
        [self showHUDWithStr:@"请输入11位手机号"];
        [_phoneField showShakeAnimation];
    }else if ([verifyCodeString length] <= 0){
        [self showHUDWithStr:@"请输入验证码"];
        [_verifyCodeField showShakeAnimation];
    }else if ([passWordString length] <= 0){
        [self showHUDWithStr:@"请输入新密码"];
        [_passWordField showShakeAnimation];
    }else if (passWordString != againpassWordString)
    {
      [self showHUDWithStr:@"两次输入不一致"];
      [_againpassWordField showShakeAnimation];
    }
    else
    {
    
        NSDictionary *dictionary = @{@"type":@"AForgetPassword",@"qqnum":phoneString,@"NewPassword":passWordString,@"verifycode":verifyCodeString};
        [MSNetRequest requestMethodsWithPOST:dictionary url:kGetLogin successBlock:^(id responseObject) {
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonDictionary = [jsonString objectFromJSONStringWithParseOptions:JKSerializeOptionPretty];
            
            NSString *statString = [jsonDictionary objectForKey:@"GetState"];
            if([statString isEqualToString:@"VcodeFalese"]){
                [self showHUDWithStr:@"验证码不正确"];
            }else if ([statString isEqualToString:@"false"]){
                [self showHUDWithStr:@"修改失败,请重试"];
            }else if ([statString isEqualToString:@"success"]){
                [self showHUDWithStr:@"找回密码成功"];
                [self.navigationController popViewControllerAnimated:NO];
            }
        } failureBlock:^(NSString *errorDescribe) {
            [self showHUDWithStr:@"网络不给力！"];
        }];
        
    }
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
