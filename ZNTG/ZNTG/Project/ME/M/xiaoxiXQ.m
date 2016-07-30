//
//  xiaoxiXQ.m
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//

#import "xiaoxiXQ.h"
#import "xiaoxiXQdata.h"

// 昵称的字体
#define PHNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define PHTextFont [UIFont systemFontOfSize:15]
@implementation xiaoxiXQ


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



-(void)setXxXQ:(xiaoxiXQdata *)xxXQ
{
    
    _xxXQ = xxXQ;
    
    CGRect screenR = [UIScreen mainScreen].bounds;
    
    CGSize textSize = [self sizeWithText:self.xxXQ.xiaoxiContent font:PHTextFont maxSize:CGSizeMake(screenR.size.width-36, MAXFLOAT)];
    
    _shijianF = CGRectMake((screenR.size.width-100)/2, 10, 100, 20);
    _contentF = CGRectMake((screenR.size.width-textSize.width)/2, 40, textSize.width, textSize.height);
    _beijingtu = CGRectMake(_contentF.origin.x -10, _contentF.origin.y-10, _contentF.size.width+20, _contentF.size.height+20);
    
    _cellHeight = CGRectGetMaxY(_contentF) + 10;
    
}


@end
