//
//  MSCollectionViewFlowLayout.h
//  MyNote
//
//  Created by 林雷 on 15/12/22.
//  Copyright © 2015年 SayingLin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSCollectionViewFlowLayout;
@protocol MSWaterFlowDelegate  <NSObject>
-(CGFloat)MSWaterFlow:(MSCollectionViewFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;
@end

@interface MSCollectionViewFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,assign) UIEdgeInsets sectionOfInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property(nonatomic,weak)id<MSWaterFlowDelegate> degelate;
@end
