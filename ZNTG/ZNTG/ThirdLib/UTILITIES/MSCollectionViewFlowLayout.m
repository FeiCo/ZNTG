//
//  MSCollectionViewFlowLayout.m
//  MyNote
//
//  Created by 林雷 on 15/12/22.
//  Copyright © 2015年 SayingLin. All rights reserved.
//

#import "MSCollectionViewFlowLayout.h"

@interface MSCollectionViewFlowLayout ()
@property(nonatomic,retain)NSMutableDictionary * maxYdic;
@end

@implementation MSCollectionViewFlowLayout

-(NSMutableDictionary *)maxYdic{
    if (!_maxYdic) {
        self.maxYdic = [[NSMutableDictionary alloc] init];
    }
    return _maxYdic;
}

- (instancetype)init{
    if (self=[super init]) {
        self.colMagrin = 10;
        self.rowMagrin = 10;
        self.sectionOfInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.colCount = 3;
    }
    return self;
}


-(void)prepareLayout{
    [super prepareLayout];
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)){
        return YES;
    }
    return NO;
}


/**
 *  指定contentsize的总大小
 *
 *  @return
 */
-(CGSize)collectionViewContentSize{
    
    __block NSString * maxCol = @"0";
    
    //找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue]>[self.maxYdic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    return CGSizeMake(0, [self.maxYdic[maxCol] floatValue]);
}


/**
 *  返回每个cell的布局属性
 *
 *  @param indexPath
 *
 *  @return
 */

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block NSString * minCol = @"0";
    //找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYdic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    
    
    //计算宽度
    CGFloat width = (self.collectionView.frame.size.width-self.sectionOfInset.left-self.sectionOfInset.right-(self.colCount-1)*self.colMagrin)/self.colCount;
        
    //计算高度
    CGFloat hight = [self.degelate MSWaterFlow:self heightForWidth:width atIndexPath:indexPath];
    
    CGFloat x = self.sectionOfInset.left + (width+ self.colMagrin)* [minCol intValue];
    CGFloat y =[self.maxYdic[minCol] floatValue]+self.rowMagrin;
    //跟新最大的y值
    self.maxYdic[minCol] = @(y+hight);
    
    // 计算位置
    UICollectionViewLayoutAttributes * attri =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, width, hight);
    return attri;
    
    
    
}

/**
 *  返回所有cell的布局属性
 *
 *  @param rect
 *
 *  @return
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    for(int i = 0;i<self.colCount;i++){
        NSString * col = [NSString stringWithFormat:@"%d",i];
        self.maxYdic[col] = @0;
    }
    
    NSMutableArray * array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return  array;
}
@end
