//
//  XiaoXiHuiFudata.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "XiaoXiHuiFudata.h"

@implementation XiaoXiHuiFudata


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)XiaoXiHuiFuWithDictionary:(NSDictionary *) dict;
{
    return [[self alloc] initWithDictionary:dict];
}


@end
