//
//  MSNetRequest.m
//  MyNote
//
//  Created by 林雷 on 15/12/31.
//  Copyright © 2015年 SayingLin. All rights reserved.
//

#import "MSNetRequest.h"
#import "MSNoNetView.h"
#import "AFNetworking.h"
#import "UIViewController+MSNetController.h"

@implementation MSNetRequest


+(BOOL)verifyNetWork{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0;
}

+ (AFHTTPSessionManager *)defaultNetRequest{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:15];
    return manager;
}


/**
 *  网络控制器请求
 *
 *  @param target       指定的视图控制器
 *  @param parameter    请求参数
 *  @param url          请求地址
 *  @param successBlock 请求成功返回的数据
 *  @param failureBlock 请求失败返回的数据
 */
+ (void)requestTarget:(UIViewController *)target parameters:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    //网络存在
    if([self verifyNetWork]){
        [target hiddenNoNetWork];
        [self requestMethodsWithPOST:parameter url:url successBlock:successBlock failureBlock:failureBlock];
    }else{
        [target showNoNetWork];
    }
    
}

/**
 *  发送GET请求
 *
 *  @param parameter    请求参数
 *  @param url          请求地址
 *  @param successBlock 请求成功返回的数据
 *  @param failureBlock 请求失败返回的数据
 */
+(void)requestMethodsWithGET:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self defaultNetRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:parameter progress:^(NSProgress *downloadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failureBlock(errorStr);
    }];
}


/**
 *  发送POST请求
 *
 *  @param parameter    请求参数
 *  @param url          请求地址
 *  @param successBlock 请求成功返回的数据
 *  @param failureBlock 请求失败返回的数据
 */
+(void)requestMethodsWithPOST:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self defaultNetRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:parameter progress:^(NSProgress *uploadProgress) {
    } success:^(NSURLSessionDataTask *task, id  responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failureBlock(errorStr);
    }];
}



+(void)requestMethodsWithUpload:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self defaultNetRequest];
    NSString *urlStr=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        for (int i = 0; i < [images count]; i++) {
             NSData *imageData= UIImageJPEGRepresentation(images[i-1], 1.0);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i] fileName:@"image" mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress *uploadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        failureBlock(errorStr);
    }];
}
@end
