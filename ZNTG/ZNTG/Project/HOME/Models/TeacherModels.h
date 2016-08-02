//
//  TeacherModels.h
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModels : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSMutableArray *roomPhoneList;

+ (instancetype)teacherModelsFromDictionary:(NSDictionary *)dictionary;
@end



