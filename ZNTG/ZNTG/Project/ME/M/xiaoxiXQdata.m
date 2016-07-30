//
//  xiaoxiXQdata.m
//  RCTZ客户端
//
//  Created by peter on 16/3/9.
//  Copyright © 2016年 ph. All rights reserved.
//

#import "xiaoxiXQdata.h"

@implementation xiaoxiXQdata


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
       [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)xiaoxiXQWithDictionary:(NSDictionary *) dict;
{
return [[self alloc] initWithDictionary:dict];
}

@end
