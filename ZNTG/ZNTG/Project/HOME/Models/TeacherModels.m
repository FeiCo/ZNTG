//
//  TeacherModels.m
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TeacherModels.h"

@implementation TeacherModels
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.descriptions = [dictionary objectForKey:@"description"];
        self.identifier = [dictionary objectForKey:@"id"];
        self.mobilePhone = [dictionary objectForKey:@"mobilePhone"];
        self.photoLocation = [dictionary objectForKey:@"photoLocation"];
        self.roomPrice = [dictionary objectForKey:@"roomPrice"];
        self.teacherId = [dictionary objectForKey:@"teacherId"];
        self.teacherName = [dictionary objectForKey:@"teacherName"];
        self.type = [dictionary objectForKey:@"type"];
        NSString *num = [dictionary objectForKey:@"userNumber"];
        self.userNumber = num == nil ? @"0" : num;
    }
    return self;
}

+ (instancetype)teacherModelsFromDictionary:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictionary];
}
@end
