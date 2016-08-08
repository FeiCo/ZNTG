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
        self.userNumber = num == nil ? @"0" : [NSString stringWithFormat:@"%@",num];
        
        self.cellHeight = [self sizeWithFont:[UIFont systemFontOfSize:14]
                                     maxSize:CGSizeMake(kScreenWidth - kScreenWidthScale(20), MAXFLOAT)
                                      string:self.descriptions].height;
        _isSelected = NO;
    }
    return self;
}

+ (instancetype)teacherModelsFromDictionary:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictionary];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string {
    NSDictionary *attributes = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attributes
                                context:nil].size;
}

@end
