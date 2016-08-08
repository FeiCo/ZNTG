//
//  PlateView.h
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlateViewBlock)(UIButton *sender);
@interface PlateView : UIView

@property (nonatomic, copy) PlateViewBlock plateViewBlock;

- (void)plateViewBlock:(PlateViewBlock)aBlock;
@end
