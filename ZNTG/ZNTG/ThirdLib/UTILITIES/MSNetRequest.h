//
//  MSNetRequest.h
//  MyNote
//
//  Created by 林雷 on 15/12/31.
//  Copyright © 2015年 SayingLin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

//定义返回请求数据的block类型
typedef void (^SuccessBlock) (id responseObject);
typedef void (^FailureBlock)(NSString *err);


@interface MSNetRequest : NSObject

@property (copy, nonatomic) SuccessBlock successBlock;
@property (copy, nonatomic) FailureBlock failureBlock;

+ (void)requestTarget:(UIViewController *)target parameters:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+(void)requestMethodsWithGET:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+(void)requestMethodsWithPOST:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+(void)requestMethodsWithUpload:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
                                            