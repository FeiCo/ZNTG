//
//  XiaoXiHuiFu.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "XiaoXiHuiFu.h"
#import "XiaoXiHuiFudata.h"
// 昵称的字体
#define PHNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define PHTextFont [UIFont systemFontOfSize:15]



// 回答正文的字体
#define PHHuiDaTextFont [UIFont systemFontOfSize:14]


@implementation XiaoXiHuiFu


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


-(void)setXxHF:(XiaoXiHuiFudata *)xxHF {
    _xxHF = xxHF;
    CGRect screenR = [UIScreen mainScreen].bounds;
    
    CGSize textSize = [self sizeWithText:self.xxHF.wenContent font:PHTextFont maxSize:CGSizeMake(screenR.size.width-36, MAXFLOAT)];
    CGSize textSize2 = [self sizeWithText:[self.xxHF.huiDaContent stringByAppendingString:self.xxHF.huiDaZhe] font:PHHuiDaTextFont maxSize:CGSizeMake(screenR.size.width-50, MAXFLOAT)];
    
    _shijianF = CGRectMake((screenR.size.width-100)/2, 10, 100, 20);
    _askContentF = CGRectMake((screenR.size.width-textSize.width)/2, 40, textSize.width, textSize.height);
    
    _auswerContentF = CGRectMake((screenR.size.width - textSize2.width)/2, CGRectGetMaxY(_askContentF) + 15, textSize2.width, textSize2.height);
    _subBeiJingTuF = CGRectMake(CGRectGetMinX(_askContentF) , CGRectGetMaxY(_askContentF) + 10, textSize.width, textSize2.height + 10);
    _beiJingTuF = CGRectMake(_askContentF.origin.x -10, _askContentF.origin.y-10, _askContentF.size.width+20, CGRectGetMaxY(_subBeiJingTuF) - 15);
    
    _cellHeight = CGRectGetMaxY(_beiJingTuF) + 10;

}





@end
