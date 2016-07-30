//
//  XiaoXiHuiFudata.h
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiaoXiHuiFudata : NSObject


@property (nonatomic, copy) NSString *wenContent;
@property (nonatomic, copy) NSString *huiDaZhe;
@property (nonatomic, copy) NSString *huiDaContent;

@property (nonatomic, copy) NSString *shijian;


-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (id)initWithDictionary:(NSDictionary *) dict;
+ (id)XiaoXiHuiFuWithDictionary:(NSDictionary *) dict;

@end
