//
//  MJProvince.h
//  03-UIPickerView02-城市选择
//
//  Created by apple on 13-12-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

// 英文字母、数字、_
#define kInitH(name) \
- (id)initWithDict:(NSDictionary *)dict; \
+ (id)name##WithDict:(NSDictionary *)dict;

#define kInitM(name) \
+ (id)name##WithDict:(NSDictionary *)dict \
{ \
return [[self alloc] initWithDict:dict]; \
}

@interface MJProvince : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *cities;

kInitH(province)
@end
