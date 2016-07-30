//
//  xiaoxiXQdata.h
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xiaoxiXQdata : NSObject

@property (nonatomic, copy) NSString *xiaoxiContent;
@property (nonatomic, copy) NSString *shijian;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)initWithDictionary:(NSDictionary *) dict;
+ (id)xiaoxiXQWithDictionary:(NSDictionary *) dict;

@end
