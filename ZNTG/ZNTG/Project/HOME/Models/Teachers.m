//
//  Teachers.m
//  ZNTG
//
//  Created by FeiCao on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "Teachers.h"

@implementation Teachers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.descriptions = [dictionary objectForKey:@"description"];
        self.identifier = [dictionary objectForKey:@"id"];
        self.roomPrice = [dictionary objectForKey:@"roomPrice"];
        self.teacherId = [[dictionary objectForKey:@"teacherId"] integerValue];
        self.teacherName = [dictionary objectForKey:@"teacherName"];
        self.type = [dictionary objectForKey:@"type"];
        self.userNumber = [dictionary objectForKey:@"userNumber"] == nil ? @"0" : [dictionary objectForKey:@"userNumber"];
        self.mobilePhone = [dictionary objectForKey:@"mobilePhone"];
    }
    return self;
}

+ (instancetype)teachersFromDictionry:(NSDictionary *)dictionry {
    if (![dictionry isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictionry];
}
@end
