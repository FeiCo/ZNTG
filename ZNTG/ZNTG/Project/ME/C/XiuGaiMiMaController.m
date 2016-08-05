//
//  XiuGaiMiMaController.m
//  HuiJing
//
//  Created by Peter on 7/6/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "XiuGaiMiMaController.h"


#import "wjmmViewController.h"
#import "MSTextField.h"
#import "JKCountDownButton.h"
#import "NSString+HandleString.h"
#import "MSNetRequest.h"
#import "JSONKit.h"
#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]


#import "dengLuViewController.h"

@interface XiuGaiMiMaController()

@property (nonatomic,strong) MSTextField *oldPSW;//旧密码
@property (nonatomic,strong) MSTextField *passWordField;//密码
@property (nonatomic,strong) MSTextField *againpassWordField;//再次确认密码

@property (nonatomic,strong) UIButton *nextBtn;//下一步

@end

@implementation XiuGaiMiMaController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor =  color(239, 249, 241, 1);
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
    UIView *whiteBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 15, screenB.size.width, 150)];
    whiteBackground.backgroundColor = [UIColor whiteColor];
    
    UIView *fengexian1 = [[UIView alloc] initWithFrame:CGRectMake(60, 50, screenB.size.width - 80, 0.5)];
    UIView *fengexian2 = [[UIView alloc] initWithFrame:CGRectMake(60, 100, screenB.size.width - 80, 0.5)];

    fengexian1.backgroundColor = color(239, 240, 240, 1);
    fengexian2.backgroundColor = color(239, 240, 240, 1);

    
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13.5, 20, 23)];
    UIImageView *passwordImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 63.5, 20, 23)];
    UIImageView *passwordImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 113.5, 20, 23)];
    
    userImage.image = [UIImage imageNamed:@"dlsuo"];
    passwordImage1.image = [UIImage imageNamed:@"dlsuo"];
    passwordImage2.image = [UIImage imageNamed:@"dlsuo"];
    
    
    MSTextField *oldPSW = [[MSTextField alloc] initWithFrame:CGRectMake(60, 5, screenB.size.width - 30 - 60, 40)];
    
    MSTextField *setpasswordT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 55, screenB.size.width - 30 - 60, 40)];
    
    MSTextField *makesurepasswordT = [[MSTextField alloc] initWithFrame:CGRectMake(60, 105, screenB.size.width - 30 - 60, 40)];
    
    oldPSW.secureTextEntry = YES;
    setpasswordT.secureTextEntry = YES;
    makesurepasswordT.secureTextEntry = YES;
   
    
    oldPSW.tintColor = color(39, 129, 195, 1);
    setpasswordT.tintColor = color(39, 129, 195, 1);
    makesurepasswordT.tintColor = color(39, 129, 195, 1);

    
    oldPSW.placeholder = @"输入旧密码";
    setpasswordT.placeholder = @"设置您的新密码";
    makesurepasswordT.placeholder = @"确认您的新密码";

    
    oldPSW.clearButtonMode = YES;
    setpasswordT.clearButtonMode = YES;
    makesurepasswordT.clearButtonMode = YES;

    
    
    UIButton *queDin = [UIButton buttonWithType:UIButtonTypeSystem];
    queDin.backgroundColor = color(241, 74, 25, 1);
    [queDin setTitle:@"确定" forState:UIControlStateNormal];
    queDin.titleLabel.font = [UIFont systemFontOfSize:18];
    [queDin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queDin.frame = CGRectMake(40, 205, screenB.size.width - 80, 44);
    queDin.layer.cornerRadius = 5;
    [queDin addTarget:self action:@selector(onClickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteBackground addSubview:fengexian1];
    [whiteBackground addSubview:fengexian2];
    [whiteBackground addSubview:userImage];
    [whiteBackground addSubview:passwordImage1];
    [whiteBackground addSubview:passwordImage2];
    [whiteBackground addSubview:oldPSW];
    [whiteBackground addSubview:setpasswordT];
    [whiteBackground addSubview:makesurepasswordT];
    
    
    [self.view addSubview:whiteBackground];
    [self.view addSubview:queDin];
    
    _oldPSW = oldPSW;
    _passWordField = setpasswordT;
    _againpassWordField = makesurepasswordT;
}



-(void)onClickNextBtn:(UIButton *)sender {
    NSString *oldpsw = [_oldPSW.text stringByTrimingWhitespace];
    NSString *passWordString = [_passWordField.text stringByTrimingWhitespace];
    NSString *againpassWordString = [_againpassWordField.text stringByTrimingWhitespace];
    __weak __typeof__(self) weakSelf = self;
    
    if([passWordString isEqualToString:oldpsw]){
        [self showHUDWithStr:@"新旧密码应设置不一样"];
        [_passWordField showShakeAnimation];
    }else if (![passWordString isEqualToString:againpassWordString]){
        [self showHUDWithStr:@"请输入一样的新密码"];
        [_againpassWordField showShakeAnimation];
    }else{
        NSDictionary *dictionary = @{@"passWordOld":oldpsw,@"passWordNew":againpassWordString};
       
        [MSNetRequest requestMethodsWithGET:dictionary url:kUserLoginPSW successBlock:^(id responseObject) {
            
            NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonDictionary = [jsonString objectFromJSONStringWithParseOptions:JKSerializeOptionPretty];
            
            NSString *statString = [jsonDictionary valueForKey:@"result"];
           if ([statString isEqualToString:@"fail"]){
               
               if ([[jsonDictionary valueForKey:@"message"] isEqualToString:@"原密码错误"]) {
                   [self showHUDWithStr:@"原密码错误"];
               }
               else {
                [self showHUDWithStr:@"修改失败,请重新登录"];
               dengLuViewController *denglu = [[dengLuViewController alloc] init];
               [weakSelf presentViewController:denglu animated:YES completion:^{
               }];
               }
            }else if ([statString isEqualToString:@"success"]){
                [weakSelf showHUDWithStr:@"修改密码成功"];
                double delayInSeconds = 1.5;
                //        __weak __typeof(self)weakSelf = self;
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *newpassword = againpassWordString;
                [userDefaults setValue:newpassword forKey:kUserLoginPSW];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
//                [self.navigationController popViewControllerAnimated:NO];
            }
        } failureBlock:^(NSString *errorDescribe) {
            [self showHUDWithStr:@"请重新登录后修改"];
            double delayInSeconds = 1.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                dengLuViewController *denglu = [[dengLuViewController alloc] init];
                [weakSelf presentViewController:denglu animated:YES completion:^{
                }];
            });
            
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
