//
//  XiaoXiHuiFu.h
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XiaoXiHuiFudata;
@interface XiaoXiHuiFu : NSObject

@property (nonatomic,strong) XiaoXiHuiFudata *xxHF;

@property (nonatomic, assign, readonly) CGRect shijianF;
@property (nonatomic, assign, readonly) CGRect askContentF;

@property (nonatomic, assign, readonly) CGRect auswerContentF;
@property (nonatomic, assign, readonly) CGRect subBeiJingTuF;
@property (nonatomic, assign, readonly) CGRect beiJingTuF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
