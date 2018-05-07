//
//  MOMNetWorking.h
//  LivingArea
//
//  Created by goooo on 15/9/21.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AFNetworking/AFNetworking.h>
//#import "AFNetworking.h"
//#import "MOMProgressHUD.h"
//#import "MOMCurrentUser.h"
#import "ASHMainUser.h"
#import "Config.h"
//#import "MOMFilter.h"
//#import "MOMTest.h"

@interface MOMNetWorking : NSObject
/**
 *  HTTP POST 查询 异步
 *
 *  @param method  方法名
 *  @param params  参数
 *  @param succes  成功回调
 *  @param failure 失败回调
 */
+(void)asynRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback;

/**
 *  HTTP GET 查询 异步
 *
 *  @param method  方法名
 *  @param params  参数
 *  @param succes  成功回调
 *  @param failure 失败回调
 */
+(void)asynGETRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback;
    
    
    +(void)asynGETPayRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback;
/**
 *  HTTP POST 查询 同步
 *
 *  @param method  方法名
 *  @param params  参数
 *  @param succes  成功回调
 *  @param failure 失败回调
 */
+(void)requestByMethod:(NSString *)method params:(NSString *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback;


/**
 *  HTTP POST 图片上传
 *
 *  @param method  方法名
 *  @param params  参数
 *  @param succes  成功回调
 *  @param failure 失败回调
 */
+(void)requestPictureByMethod:(NSString *)method fileURL:(NSString *)fileURL params:(NSString *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback;


//+(void)requestByMethod:(NSString *)method params:(NSString *)params callback:(void(^)(id result,NSError *error))callback;

//+(void)requestByMethod:(NSString *)method params:(NSString *)params success:(void(^)(id result))succes failure:(void(^)(NSError *error))failure;


#pragma mark 结构化工具
+(NSString *)buildParamWithMethod:(NSString *)method andParams:(NSString *)first,...NS_REQUIRES_NIL_TERMINATION;
@end
