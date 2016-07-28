//
//  NSString+Message.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-10.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import "NSString+HandleString.h"
@implementation NSString (HandleString)
/**
 *  去掉字符串中首尾的空格
 *
 *  @return
 */
- (NSString *)stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


/**
 *  返回字符串按照\n换行后的航数目
 *
 *  @return 行数
 */
- (NSInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

/**
 *  过滤掉字符串中的HTML
 *
 *  @return
 */
-(NSString *)filterHTML{
    NSString *tempString = [self copy];
    NSScanner *scanner = [NSScanner scannerWithString:tempString];
    NSString *text = nil;
    while ([scanner isAtEnd] == NO) {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&text];
        tempString = [tempString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //去掉字符串头和尾的空格
    [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return tempString;
}

/**
 *  MD5加密
 *
 *  @return
 */
- (NSString *)md5HexDigest{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i< CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

/**
 *  urlEncode
 *
 *  @return
 */
- (NSString *)stringEncode {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  urlDecode
 *
 *  @return
 */
- (NSString *)stringDecode {
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}


/**
 *  字体大小
 *
 *  @param size 预设字体的大小
 *  @param font 字体
 *
 *  @return 字体的大小
 */
- (CGSize)boundingRectWithSize:(CGSize)size withTextFont:(UIFont *)font {
    if ([self isEqualToString:@""]) {
        return CGSizeZero;
    }
    NSDictionary *dict = @{NSFontAttributeName:font};
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize sizeString = [self boundingRectWithSize:size options:option attributes:dict context:nil].size;
    return  CGSizeMake(ceil(sizeString.width), ceil(sizeString.height));
}



- (NSString *)filterSpecialChar:(BOOL)isSend{
    NSString *replaceStr = self;
    NSArray *specialChars = @[@"\"",@"\'",@"{",@"}",@","];
    NSArray *specialStrs= @[@"&quot",@"&apos",@"&lt",@"&gt",@"&dagger"];
    NSInteger startIndex = 0,endIndex = [specialChars count];
    
    for (startIndex = 0; startIndex < endIndex; startIndex++) {
        if(isSend){
          replaceStr = [replaceStr stringByReplacingOccurrencesOfString:[specialChars objectAtIndex:startIndex] withString:[specialStrs objectAtIndex:startIndex]];
        }else{
         replaceStr = [replaceStr stringByReplacingOccurrencesOfString:[specialStrs objectAtIndex:startIndex] withString:[specialChars objectAtIndex:startIndex]];
        }
    }
    return replaceStr;
}




/**
 *  验证手机号码
 *
 *  @return
 */
- (BOOL)verifyIsPhoneNumber{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    //手机号码
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
    
    //中国移动
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    //中国联通
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    //中国电信
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    if (res1 || res2 || res3 || res4 ){
        return YES;
    }else{
        return NO;
    }
}

/**
 *  验证邮箱
 *
 *  @return
 */
- (BOOL)verifyIsEmail{
    NSString *filterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证中文
 *
 *  @return
 */
- (BOOL)verifyIsHanZi{
    NSString *filterString = @"[\u4e00-\u9fa5]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}


/**
 *  验证双字节
 *
 *  @return
 */
- (BOOL)verifyIsDoubleByte{
    NSString *filterString = @"[^x00-xff]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证HTML
 *
 *  @return
 */
- (BOOL)verifyIsHTML{
    NSString *filterString = @"<(S*?)[^>]*>.*?|<.*? />";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}


/**
 *  验证URL
 *
 *  @return
 */
- (BOOL)verifyIsURL{
    NSString *filterString = @"[a-zA-z]+://[^s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证QQ
 *
 *  @return
 */
- (BOOL)verifyIsQQ{
    NSString *filterString = @"[1-9][0-9]{4,}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证IP
 *
 *  @return
 */
- (BOOL)verifyIsIP{
    NSString *filterString = @"d+.d+.d+.d+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证中国邮政编码
 *
 *  @return
 */
- (BOOL)verifyIsChinaPostcode{
    NSString *filterString = @"[1-9]d{5}(?!d)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];
}

/**
 *  验证中国身份证号码
 *
 *  @return
 */
- (BOOL)verifyIsChinaID{
    NSString *filterString = @"d{15}|d{18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filterString];
    return [predicate evaluateWithObject:self];

}
@end
