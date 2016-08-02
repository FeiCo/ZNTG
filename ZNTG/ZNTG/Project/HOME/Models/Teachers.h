//
//  Teachers.h
//  ZNTG
//
//  Created by FeiCao on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teachers : NSObject

@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *teacherName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *roomPrice;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) NSInteger teacherId;
@property (nonatomic, copy) NSString *userNumber;
@property (nonatomic, copy) NSString *mobilePhone;

+ (instancetype)teachersFromDictionry:(NSDictionary *)dictionry;
@end
