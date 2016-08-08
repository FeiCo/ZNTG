//
//  TeacherModels.h
//  ZNTG
//
//  Created by FeiCao on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModels : NSObject
/** 描述是否展开 Default:NO */
@property (nonatomic, assign) BOOL isSelected;
/** 描述高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 描述 */
@property (nonatomic, copy) NSString *descriptions;
/** 服务ID */
@property (nonatomic, copy) NSString *identifier;
/** 老师联系电话 */
@property (nonatomic, copy) NSString *mobilePhone;
/** 老师头像 */
@property (nonatomic, copy) NSString *photoLocation;
/** 服务价格 */
@property (nonatomic, copy) NSString *roomPrice;
/** 老师ID */
@property (nonatomic, copy) NSString *teacherId;
/** 老师姓名 */
@property (nonatomic, copy) NSString *teacherName;
/** 服务类型 */
@property (nonatomic, copy) NSString *type;
/** 购买人数 */
@property (nonatomic, copy) NSString *userNumber;

+ (instancetype)teacherModelsFromDictionary:(NSDictionary *)dictionary;
@end



