//
//  TeacherModels.m
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TeacherModels.h"
#import "Teachers.h"

@implementation TeacherModels

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identifier = [[dictionary objectForKey:@"id"] integerValue];
        self.userId = [[dictionary objectForKey:@"userId"] integerValue];
        NSMutableArray *tempArray = [dictionary objectForKey:@"roomPhoneList"];
        self.roomPhoneList = [NSMutableArray array];
        for (NSDictionary *dict in tempArray) {
           [self.roomPhoneList addObject:[Teachers teachersFromDictionry:dict]];
        }
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
