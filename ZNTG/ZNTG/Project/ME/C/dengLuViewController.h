//
//  dengLuViewController.h
//  XinLanDe
//
//  Created by Peter on 6/8/16.
//  Copyright © 2016 Sai. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <TencentOpenAPI/TencentOAuth.h>
//#import "WXApi.h"
//#import "TLSSDK/TLSRefreshTicketListener.h"
//#import "TLSSDK/TLSOpenLoginListener.h"


typedef NS_ENUM(NSInteger, DengLuLoginMode) {
    DengLuLoginModedBoth = 0,
    DengLuLoginModedIgnoreChat,
};


@interface dengLuViewController : MyBaseController


-(instancetype)initWithLoginMode:(DengLuLoginMode)mode;

@end
