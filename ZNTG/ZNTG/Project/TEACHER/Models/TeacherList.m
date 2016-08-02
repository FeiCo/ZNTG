//
//  TeacherList.m
//  ZNTG
//
//  Created by FeiCao on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TeacherList.h"

@implementation TeacherList

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.certificateNo = [dictionary objectForKey:@"certificateNo"];
        self.descriptions = [dictionary objectForKey:@"description"];
        self.identifier = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
        self.photoLocation = [dictionary objectForKey:@"photoLocation"];
        self.position = [dictionary objectForKey:@"position"];
        self.userId = [dictionary objectForKey:@"userId"];
    }
    return self;
}

+ (instancetype)teacherListFromDictionry:(NSDictionary *)dictionry {
    if (![dictionry isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictionry];
}

@end
