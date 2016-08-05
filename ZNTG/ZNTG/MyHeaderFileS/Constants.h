//
//  Header.h
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#pragma mark -- TabBarItem

#define KHomeItemImage  @"tab12"
#define KTeacherItemImage  @"tab22"
#define KClassItemImage  @"tab32"
#define KMeItemImage   @"tab42"
#define KHomeItemImageSelected  @"tab11"
#define KTeacherItemImageSelected   @"tab21"
#define KClassItemImageSelected   @"tab31"
#define KMeItemImageSelected   @"tab41"

#define KHomeTitle  @"主页"
#define KTeacherTitle  @"名师"
#define KClassTitle  @"课件"
#define KMeTitle  @"我的"


//导航栏的背景颜色
#define kThemeColor  [UIColor colorWithRed:240/255.0 green:69/255.0 blue:24/255.0 alpha:1]
//屏幕的宽
#define kScreenWidth  [[UIScreen mainScreen]bounds].size.width
//屏幕的高
#define kScreenHeight  [[UIScreen mainScreen]bounds].size.height
//导航栏的高度
#define kNavigationBarHeight [self.navigationController navigationBar].bounds.size.height
//状态栏的高度
#define kStateBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//标签栏的高度
#define kTabBarHeight  [self.tabBarController tabBar].bounds.size.height

//十六进制颜色
#define kHexadecimalColor(rgbValue,a) [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:a]

//获取RGB颜色
#define kCustomColor(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

//获取图片颜色
#define kImageColor(args) [UIColor colorWithPatternImage:[UIImage imageNamed:args]]

//判断是否是iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否是iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否是retina
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0f)

//判断是否为iOS7
#define IS_IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f)



#define IPHONE_4_POW_2 (pow(320, 2) + pow(480,2))

#define IPHONE_5_POW_2 (pow(320, 2) + pow(568,2))

#define IPHONE_6_POW_2 (pow(375, 2) + pow(667,2))

#define IPHONE_6PLUS_POW_2 (pow(414, 2) + pow(736,2))

#define IPHONE_SCREEN_POW_2 (pow(kScreenWidth,2)+ pow(kScreenHeight,2))


//是否是IPHONE_4
#define IS_IPHONE_4 (IPHONE_4_POW_2 == IPHONE_SCREEN_POW_2)

//是否是IPHONE_5
#define IS_IPHONE_5 (IPHONE_5_POW_2 == IPHONE_SCREEN_POW_2)

//是否是IPHONE_6
#define IS_IPHONE_6 (IPHONE_6_POW_2 == IPHONE_SCREEN_POW_2)

//是否是IPHONE_6PLUS
#define IS_IPHONE_6PLUS (IPHONE_6PLUS_POW_2 == IPHONE_SCREEN_POW_2)

//以IPHONE_6为参照比例
#define kScreenWidthScale(args) (((args) * (kScreenWidth))/(640.0f))
#define kScreenHeightScale(args) (((args) * (kScreenHeight))/(1136.0f))

//获取自定义Bundle路径
#define kBundleFilePath(args) [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:args]

//用于BUG调试
#define kMethodMessage [NSString stringWithFormat:@"%s ON %lu LINES.",__func__,(unsigned long)__LINE__]




#define  kUserAccount @"UserAccount"//用户账号

#define kUserPassword @"UserPassword"//用户密码

#define kUserID @"UserID"//用户的实际ID用户的唯一标识
#define kUserHeaderPic @"HeaderPictureLink"//用户的实际ID用户的唯一标识

#define kUserVirtualID @"UserVirtualID"//用于登陆的ID

#define kUserNickName @"UserNickName"//用户昵称

#define kUserType @"UserType"//用户类型

#define kUserState @"UserState"//用户登录的状态

#define kUserIntegral @"UserIntegral"//用户积分

#define kUserKeyWord @"UserKeyWord"

#define kUserRemenberPSW @"UserRemenberPSW"

//ME ADD
#define KPersonCenterValue1   @"jumplink1"
#define KPersonCenterValue2   @"jumplink2"
#define KPersonCenterValue3   @"jumplink3"
#define KPersonCenterValue4   @"jumplink4"

//ME ADD FOR REMOTE NOTICIFICATION
#define KRemoteTitle   @"remoteTiTle"
#define KRemoteUrl   @"remoteUrL"





#define kHostAddress @"http://192.168.0.123:8081/appserver/user/"//登录地址
#define KUpLoadIconHost  @"http://192.168.0.123:8081/file/upload"

#define kHostAddressURL [NSURL URLWithString:kHostAddress]

#define kRelativeToAddress(args) [[NSURL URLWithString:args relativeToURL:kHostAddressURL] absoluteString]

#define kRelativeToURL(args) [NSURL URLWithString:args relativeToURL:kHostAddressURL]

#define kGetInfo kRelativeToAddress(@"Php/GetInfo.php")


//PH add

//登录
#define kGetLogin kRelativeToAddress(@"appLogin")

//注册
#define kGetRegister kRelativeToAddress(@"appRegister")
#define kGetRegistTelCode kRelativeToAddress(@"getTelRegistreCode")

//用户页面编辑
#define kGetUserEdit kRelativeToAddress(@"appUserEdit")

//邮箱绑定
#define kSendEmailCode kRelativeToAddress(@"appSendEmailVerificationCode")
#define kConfirmEmailCode kRelativeToAddress(@"appReconfirmEmailVerificationCode")


//手机绑定
#define kPhoneBindCode kRelativeToAddress(@"appSendTelephoneVerificationCode")
#define kConfirmPhoneCode kRelativeToAddress(@"appReconfirmEmailVerificationCode")

//修改密码
#define kModufyPSW kRelativeToAddress(@"appTelephoneModifyPassword")

//忘记密码
#define kForgetPSWOne kRelativeToAddress(@"appForgetPasswordOne")
#define kForgetPSWTwo kRelativeToAddress(@"appForgetPasswordTwo")

//退出登录
#define kLogOut kRelativeToAddress(@"appLogout")

//上传用户头像
#define kUpLoadIcon [NSURL URLWithString:KUpLoadIconHost];



#import "MyBaseController.h"

#endif /* Constants_h */
