//
//  TeacherModels.h
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModels : NSObject
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *mobilePhone;
@property (nonatomic, copy) NSString *photoLocation;
@property (nonatomic, copy) NSString *roomPrice;
@property (nonatomic, copy) NSString *teacherId;
@property (nonatomic, copy) NSString *teacherName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *userNumber;

+ (instancetype)teacherModelsFromDictionary:(NSDictionary *)dictionary;
@end



