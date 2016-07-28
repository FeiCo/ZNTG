//
//  NSString+Message.h
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-10.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (HandleString)

/**
 *  去掉字符串中首尾的空格
 *
 *  @return
 */
- (NSString *)stringByTrimingWhitespace;

/**
 *  返回字符串按照\n换行后的航数目
 *
 *  @return 行数
 */
- (NSInteger)numberOfLines;

/**
 *  过滤掉字符串中的HTML
 *
 *  @return
 */
-(NSString *)filterHTML;


/**
 *  mad5加密
 *
 *  @return
 */
- (NSString *)md5HexDigest;

/**
 *  urlEncode
 *
 *  @return
 */
- (NSString *)stringEncode;

/**
 *  urlDecode
 *
 *  @return
 */
- (NSString *)stringDecode;

/**
 *  字体大小
 *
 *  @param size 预设字体的大小
 *  @param font 字体
 *
 *  @return 字体的大小
 */
- (CGSize)boundingRectWithSize:(CGSize)size withTextFont:(UIFont *)font;

/**
 *  过滤掉" ' {} ,
 *
 *  @param isSend 如果是YES,则表示要将特殊字符转化成特定格式
 *
 *  @return
 */
- (NSString *)filterSpecialChar:(BOOL)isSend;


/**
 *  验证手机号码
 *
 *  @return
 */
- (BOOL)verifyIsPhoneNumber;

/**
 *  验证邮箱
 *
 *  @return
 */
- (BOOL)verifyIsEmail;

/**
 *  验证中文
 *
 *  @return
 */
- (BOOL)verifyIsHanZi;

/**
 *  验证双字节
 *
 *  @return
 */
- (BOOL)verifyIsDoubleByte;

/**
 *  验证HTML
 *
 *  @return
 */
- (BOOL)verifyIsHTML;


/**
 *  验证URL
 *
 *  @return
 */
- (BOOL)verifyIsURL;

/**
 *  验证QQ
 *
 *  @return
 */
- (BOOL)verifyIsQQ;

/**
 *  验证IP
 *
 *  @return
 */
- (BOOL)verifyIsIP;

/**
 *  验证中国邮政编码
 *
 *  @return
 */
- (BOOL)verifyIsChinaPostcode;

/**
 *  验证中国身份证号码
 *
 *  @return
 */
- (BOOL)verifyIsChinaID;
@end
