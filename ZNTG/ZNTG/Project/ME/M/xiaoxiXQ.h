//
//  xiaoxiXQ.h
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class xiaoxiXQdata;
@interface xiaoxiXQ : NSObject



@property (nonatomic,strong) xiaoxiXQdata *xxXQ;

@property (nonatomic, assign, readonly) CGRect shijianF;
@property (nonatomic, assign, readonly) CGRect contentF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign, readonly) CGRect beijingtu;

@end
