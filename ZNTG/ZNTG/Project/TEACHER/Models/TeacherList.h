//
//  TeacherList.h
//  ZNTG
//
//  Created by FeiCao on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherList : NSObject

@property (nonatomic, copy) NSString *certificateNo;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photoLocation;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *userId;

+ (instancetype)teacherListFromDictionry:(NSDictionary *)dictionry;
@end
