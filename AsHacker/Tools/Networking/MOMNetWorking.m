
//
//  MOMNetWorking.m
//  LivingArea
//
//  Created by goooo on 15/9/21.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import "MOMNetWorking.h"
#import <AFNetworking/AFNetworking.h>
static AFHTTPSessionManager *manager;
@interface MOMNetWorking(){
//    static AFHTTPSessionManager *manager;
}

@end

@implementation MOMNetWorking

//异步
+(void)asynRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback
{
//    NSString *methodName=@"m";

    NSMutableDictionary *allParams = [self createPublicParams:publicParams];
    [allParams addEntriesFromDictionary:params];
    NSString *URLStr = [NSString stringWithFormat:@"%@%@%@",HTTPURL,MainMethodName,method];
    
    
    /**/
    NSMutableDictionary *dic = allParams;//[allParams addEntriesFromDictionary:params];
    NSMutableString *mParams =  [NSMutableString string];
     NSEnumerator *enumerator = dic.keyEnumerator;
     NSString *temp=[enumerator nextObject];
     while (temp) {
         [mParams appendFormat:@"%@=%@&",temp,dic[temp]];
         temp=[enumerator nextObject];
     }
    
//    [mParams appendFormat:@"method=%@",method];
    
//    [allParams setObject:method forKey:@"method"];
//     [mParams appendString:params?params:@""];
    NSSLog(@"URLStr:%@?%@--%@",URLStr,mParams,allParams);
    
    if (LOCAL_DATA) {
        //下面是本地假数据
        [self simulateData:method params:mParams callback:callback];
    }else{
//         [MOMProgressHUD show];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
//        manager.requestSerializer = [self createPOSTRequestWithURL:URLStr params:mParams];
//        [manager.requestSerializer setValue:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IlVTRVJfSUQiOjgsIlBIT05FX05PIjoiMTg1MDIyNzcwNzgiLCJMT0dJTl9JRCI6Im81Rms5d3F3dk8tRVJSS2ZPTEF6NEVETUZsRFkiLCJQQVNTV09SRCI6ImUzY2ViNTg4MWEwYTFmZGFhZDAxMjk2ZDc1NTQ4NjhkIiwiUkVBTF9OQU1FIjoiQ2hlblRhbyIsIlNFWCI6IueUtyIsIkFHRSI6IjYw5ZCOIiwiUFJPVklOQ0UiOiLlpKnmtKXluIIiLCJDSVRZIjoi5aSp5rSl5biCIiwiQVZBVEFSX0hSRUYiOiLpobnnm67lm75fMjAxNzA5MTMxMTA3MTAudGh1bWIucG5nIiwiSUZfT1JHQU5JWkVSIjozLCJGQUlMX1JFQVNPTiI6bnVsbCwiT1JHQU5JWkFUSU9OX0lEIjoxLCJPUkdBTklaQVRJT05fTkFNRSI6IkFzaGFja2VyIiwiQ0FURUdPUlkiOiLkvZPogrIiLCJPUkdBTklaQVRJT05fUFJPVklOQ0UiOiLmsrPljJfnnIEiLCJPUkdBTklaQVRJT05fQ0lUWSI6IuWUkOWxseW4giIsIkxPR09fSFJFRiI6IjEuSDXpobXpnaLpppbpobVfMjAxNzA5MTcxODE0NDcudGh1bWIucG5nIiwiRU1BSUwiOiJjaGVudGFvX2JkeXpAb3V0bG9vay5jb20iLCJUWVBFIjozLCJEVVRZX05BTUUiOiJjaGVuZnV6ZSIsIkxBV19OQU1FIjoiY2hlbnNoYW5neWUiLCJDQVJEX05PIjoiMTIwMjIyMjIyMjIyIiwiQ0FSRF9IUkVGXzEiOiLmiqXlkI3lj4LkuI5fMjAxNzA5MjExNTM5MjkucG5nIiwiQ0FSRF9IUkVGXzIiOiLmkq3mlL5fMjAxNzA5MjExNTM5MzUucG5nIiwiTElDRU5TRV9IUkVGIjoi6aG555uu5Zu-XzIwMTcwOTI1MjExMTU1LnBuZyIsIkRVVFlfU0VYIjoi5aWzIiwiRFVUWV9BR0UiOiIwMOWQjiIsIlRFQU1fTkFNRSI6ImFzaGFja2VyIiwiVklERU9fSFJFRiI6IjIwMTctNy0yOOeJp-mHjuKAlOKAlOOAiuaRh-aRh-aZg-aZg-eahOS6uumXtOOAi-iwg-iJsl8xX3gyNjRfMjAxNzA5MTcxODE4MDMubXA0IiwiUEhPVE9fSFJFRiI6IkdXMDAzXzIwMTcwOTE3MTgxOTIzLmpwZyIsIlRFQU1fSU5UUk8iOiLmioDmnK_mlK_mjIHpg6jpl6giLCJURUFNX0NBVEVHT1JZIjoi5L2T6IKyIiwiVEVBTV9QUk9WSU5DRSI6IuWGheiSmeWPpOiHquayu-WMuiIsIlRFQU1fQ0lUWSI6IuWRvOWSjOa1qeeJueW4giIsIkxPR0lOX1RJTUUiOiIyMDE3LTEwLTA3IDE2OjAyOjI0IiwiUkVNT1RFX0FERFJFU1MiOiI2MC4yNS4xMy45MyIsIkxPR09VVF9USU1FIjoiMjAxNy0xMC0wNiAxODowMToxNCIsIklGX1VTSU5HIjoxLCJUT19CRV9VTklURUQiOjEsIlBST0pFQ1RfSUQiOjAsIklOVklURV9DT0RFIjpudWxsfSwiaWF0IjoxNTA3MzYzMzQ0fQ.OizSnPmf1QE0HC9y39ndzrldg0WNUHd5qkS4u6d588U" forHTTPHeaderField:@"authorization"];
        
        if ([ASHMainUser authorization]&&publicParams!=MOMNetPublicParamNone) {
            [manager.requestSerializer setValue:[ASHMainUser authorization] forHTTPHeaderField:@"authorization"];
            
        }
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//         [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[ASHMainUser authorization]]];
//        [{"key":"Content-Type","value":"application/x-www-form-urlencoded","description":""}]
//        authorization
        //    NSURLSessionDataTask *task = [manager GET:URLStr parameters:allParams success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSError *error=nil;
        //        //成功 cb是对方传递过来的对象 这里是直接调用
        //        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        //        NSLog(@"obj------------:%@",obj);
        //        callback(obj,error);
        //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        //失败
        //    }];
        
        //    NSURLSessionDataTask *task =
        [manager POST:URLStr parameters:allParams progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [MOMProgressHUD dismiss];
            NSError *error=nil;
            //成功 cb是对方传递过来的对象 这里是直接调用
//            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"\"\"\"" withString:@"\""];
//            string = [string stringByReplacingOccurrencesOfString:@"0\"\"" withString:@""];
            
            NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
             NSSLog(@"URLStr:%@?%@--%@------obj:%@",URLStr,mParams,allParams,obj);
//            NSSLog(@"obj------------:%@",obj);
            
            callback(obj,error);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [MOMProgressHUD dismiss];
            NSSLog(@"failure-----------网络请求失败了");
            callback(nil,error);
        }];
        //下面是真的网络请求
//        NSMutableURLRequest *request = [self createPOSTRequestWithURL:URLStr params:mParams];
//        [self synchronous:request callback:callback];
    }
    
    
}

//异步
+(void)asynGETRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback
{
    //    NSString *methodName=@"m";
    
    NSMutableDictionary *allParams = [self createPublicParams:publicParams];
    [allParams addEntriesFromDictionary:params];
    NSString *URLStr = [NSString stringWithFormat:@"%@%@%@",HTTPURL,MainMethodName,method];
    
    
    /**/
    NSMutableDictionary *dic = allParams;//[allParams addEntriesFromDictionary:params];
    NSMutableString *mParams =  [NSMutableString string];
    NSEnumerator *enumerator = dic.keyEnumerator;
    NSString *temp=[enumerator nextObject];
    while (temp) {
        [mParams appendFormat:@"%@=%@&",temp,dic[temp]];
        temp=[enumerator nextObject];
    }
    
    //    [mParams appendFormat:@"method=%@",method];
    
    //    [allParams setObject:method forKey:@"method"];
    //     [mParams appendString:params?params:@""];
    NSSLog(@"URLStr:%@?%@--%@",URLStr,mParams,allParams);
    
    if (LOCAL_DATA) {
        //下面是本地假数据
        [self simulateData:method params:mParams callback:callback];
    }else{
        //         [MOMProgressHUD show];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    
        if ([ASHMainUser authorization]&&publicParams!=MOMNetPublicParamNone) {
            [manager.requestSerializer setValue:[ASHMainUser authorization] forHTTPHeaderField:@"authorization"];
            
        }
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //         [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[ASHMainUser authorization]]];
        //        [{"key":"Content-Type","value":"application/x-www-form-urlencoded","description":""}]
        //        authorization
        //    NSURLSessionDataTask *task = [manager GET:URLStr parameters:allParams success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSError *error=nil;
        //        //成功 cb是对方传递过来的对象 这里是直接调用
        //        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        //        NSLog(@"obj------------:%@",obj);
        //        callback(obj,error);
        //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        //失败
        //    }];
        
        //    NSURLSessionDataTask *task =
        [manager GET:URLStr parameters:allParams progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            [MOMProgressHUD dismiss];
            NSError *error=nil;
            //成功 cb是对方传递过来的对象 这里是直接调用
            //            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"\"\"\"" withString:@"\""];
            //            string = [string stringByReplacingOccurrencesOfString:@"0\"\"" withString:@""];
            
            NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            NSSLog(@"URLStr:%@?%@--%@------obj:%@",URLStr,mParams,allParams,obj);
            //            NSSLog(@"obj------------:%@",obj);
            
            callback(obj,error);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            [MOMProgressHUD dismiss];
            NSSLog(@"failure-----------网络请求失败了");
            callback(nil,error);
        }];
        //下面是真的网络请求
        //        NSMutableURLRequest *request = [self createPOSTRequestWithURL:URLStr params:mParams];
        //        [self synchronous:request callback:callback];
    }
    
    
}

    //异步  支付
+(void)asynGETPayRequestByMethod:(NSString *)method params:(NSDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback
    {
        //    NSString *methodName=@"m";
        
        NSMutableDictionary *allParams = [self createPublicParams:publicParams];
        [allParams addEntriesFromDictionary:params];
        NSString *URLStr = [NSString stringWithFormat:@"%@",method];
        NSSLog(@"URLStr:%@ ",URLStr);
        
        if (LOCAL_DATA) {
            //下面是本地假数据
//            [self simulateData:method params:mParams callback:callback];
        }else{
            //         [MOMProgressHUD show];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager GET:URLStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //            [MOMProgressHUD dismiss];
                NSError *error=nil;
                //成功 cb是对方传递过来的对象 这里是直接调用
                //            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
//                string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
//                string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
//                string = [string stringByReplacingOccurrencesOfString:@"\"\"\"" withString:@"\""];
                //            string = [string stringByReplacingOccurrencesOfString:@"0\"\"" withString:@""];
                
                NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                NSSLog(@"URLStr:%@------obj:%@",URLStr,obj);
                //            NSSLog(@"obj------------:%@",obj);
                
                callback(obj,error);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //            [MOMProgressHUD dismiss];
                NSSLog(@"failure-----------网络请求失败了");
                callback(nil,error);
            }];
            //下面是真的网络请求
            //        NSMutableURLRequest *request = [self createPOSTRequestWithURL:URLStr params:mParams];
            //        [self synchronous:request callback:callback];
        }
        
        
    }
//同步
+(void)requestByMethod:(NSString *)method params:(NSString *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback
{
    NSMutableDictionary *dic = [self createPublicParams:publicParams];
    NSMutableString *mParams =  [NSMutableString string];
    
    NSEnumerator *enumerator = dic.keyEnumerator;
    NSString *temp=[enumerator nextObject];
    while (temp) {
        [mParams appendFormat:@"%@=%@&",temp,dic[temp]];
        temp=[enumerator nextObject];
    }
    [mParams appendString:params?params:@""];
    NSString *URLStr = [NSString stringWithFormat:@"%@%@.do",HTTPURL,method];
    NSLog(@"URLStr:%@?%@",URLStr,mParams);
    
//    [MOMProgressHUD showWithDuration:0.1 animations:^{
//        
//    } completion:^(BOOL finished) {
        if (LOCAL_DATA) {
            //下面是本地假数据
            [self simulateData:method params:mParams callback:callback];
        }else{
            //下面是真的网络请求
            NSMutableURLRequest *request = [self createPOSTRequestWithURL:URLStr params:mParams];
            [self synchronous:request callback:callback];
        }
//    }];
}

//图片
+(void)requestPictureByMethod:(NSString *)method fileURL:(NSString *)fileURL params:(NSMutableDictionary *)params publicParams:(MOMNetPublicParam)publicParams callback:(void(^)(id result,NSError *error))callback
{
   
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }

    NSString *methodName=@"m/api/uploadAvatar";

    NSMutableDictionary *allParams = [self createPublicParams:publicParams];
    [allParams addEntriesFromDictionary:params];
    NSString *URLStr = [NSString stringWithFormat:@"%@%@",HTTPURL,methodName];
    
    
    /**/
    NSMutableDictionary *dic = allParams;//[allParams addEntriesFromDictionary:params];
    NSMutableString *mParams =  [NSMutableString string];
    NSEnumerator *enumerator = dic.keyEnumerator;
    NSString *temp=[enumerator nextObject];
    while (temp) {
        [mParams appendFormat:@"%@=%@&",temp,dic[temp]];
        temp=[enumerator nextObject];
    }
    
    [mParams appendFormat:@"method=%@",method];
    
    [allParams setObject:method forKey:@"method"];
    //     [mParams appendString:params?params:@""];
    NSLog(@"---URLStr:%@?%@--%@",URLStr,mParams,allParams);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLStr parameters:allParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileURL] name:@"file" fileName:@"filename.png" mimeType:@"image/png" error:nil];
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileURL] name:@"file-input" fileName:@"filename.png" mimeType:@"multipart/form-data" error:nil];
//        if ([ASHMainUser authorization]&&publicParams!=MOMNetPublicParamNone) {
//            [manager.requestSerializer setValue:[ASHMainUser authorization] forHTTPHeaderField:@"authorization"];
//            
//        }
//        formData appendPartWithHeaders:<#(nullable NSDictionary<NSString *,NSString *> *)#> body:<#(nonnull NSData *)#>
        
        
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileURL] name:@"file" fileName:@"filename.png" mimeType:@"image/png" error:nil];
    } error:nil];
    [request setValue:[ASHMainUser authorization] forHTTPHeaderField:@"authorization"];

//    NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
////    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[paramData length]] forHTTPHeaderField:@"Content-Length"];

//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Accept"];
//    [[AFHTTPResponseSerializer serializer] setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
//    manager.responseSerializer
    
//                if ([ASHMainUser authorization]&&publicParams!=MOMNetPublicParamNone) {
//                    [manager.requestSerializer setValue:[ASHMainUser authorization] forHTTPHeaderField:@"authorization"];
//    
//                }
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                          NSSLog(@"uploadProgress.fractionCompleted:%f",uploadProgress.fractionCompleted);
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          
                          NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          
                          string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
                          string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
                          string = [string stringByReplacingOccurrencesOfString:@"\"\"\"" withString:@"\""];
                          //            string = [string stringByReplacingOccurrencesOfString:@"0\"\"" withString:@""];
                          
                          NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
                          NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                      }
                      
                      
                      callback(responseObject,error);
                  }];
    
    [uploadTask resume];
}

/**
 *  同步查询
 *
 *  @param requestURL
 *  @param success
 *  @param failure
 */
+(void)synchronous:(NSURLRequest *)requestURL callback:(void(^)(id result,NSError *error))callback{
    NSError *error=nil;
    NSData *data =[NSURLConnection sendSynchronousRequest:requestURL returningResponse:nil error:&error];
//TODO 转成 NSURLSession
    //GBK 转换
    //NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //result =[[NSString alloc] initWithData:data encoding:gbkEncoding];
    //UTF-8 转换
    NSString *tempStr =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *tempData = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:&error];
//    MOMTest *result2 = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingAllowFragments error:&error];
    
    if (result&&[result objectForKey:@"ret"]) {
        NSInteger ret = [[result objectForKey:@"ret"]integerValue];
//        if (MOMResultNOLogin==ret) {
//            [MOMCurrentUser cleanCurrentUser];
//        }
    }
    NSLog(@"synchronous-------------result:%@",result);
    callback(result,error);
}


#pragma mark xxxxxxxxxxxxxxxxxx
//异步查询
+(void)getAsynchronous:(NSURLRequest *)requestURL  responseWith:(NSString *)goal{
    NSLog(@"异步查询 getAsynchronous");
    //    //    NSMutableData* buf = [[NSMutableData alloc] initWithLength:0];
    //
    //    ConnectionController  *connectionController =[[ConnectionController alloc]init];
    //    NSMutableURLRequest *mrequestURL = [requestURL mutableCopy];
    //    //    [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),MAP_TPK]];
    //    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //    if ([ud objectForKey:OFFLINEMAP_SCALE]&&![[ud objectForKey:OFFLINEMAP_SCALE] isEqualToString:ALL]) {
    //        NSString *bytes = [NSString stringWithFormat:@"bytes=%@-",[ud objectForKey:OFFLINEMAP_SCALE]];
    //        [mrequestURL setValue:bytes forHTTPHeaderField:@"Range"];
    //        [mrequestURL setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //        NSLog(@"bytes:%@",bytes);
    //
    //    }
    //    //    [mrequestURL setValue:@"bytes=   " forHTTPHeaderField:@"Range"];
    //    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:mrequestURL delegate:connectionController];
    //
    //    if (connection == nil) {
    //        // 创建失败
    //
    ////        NSLog(@"data:%@",connection);
    ////        NSLog(@"connection =NULL:%@",connection);
    //    }
    ////    NSLog(@"connection:%@",connection);
}

#pragma mark 结构化工具
+(NSString *)buildParamWithMethod:(NSString *)method andParams:(NSString *)first,...
{
//    [NSArray arrayWithObjects:@"", nil];
    va_list args;
    va_start(args, first);
    
    NSMutableString *allStr = [[NSMutableString alloc] init];
    [allStr appendString:@"{"];
    [allStr appendFormat:@"\"method\":\"%@\",",method];
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    NSString *username;
//    NSString *password;
//    BOOL isRememberUserInfo=[ud boolForKey:@"icac_rememberPwd"];
//    if (isRememberUserInfo) {
//        //        userId=[ud valueForKey:@"icac_UserId"];
//        username=[ud valueForKey:@"icac_UserName"];
//        password=[ud valueForKey:@"icac_UserPassword"];
//        
//    }else{
//        //        userId=[ud valueForKey:@"icac_UserId"];
//        username=[ud valueForKey:@"currentName"];
//        password=[ud valueForKey:@"currentPassword"];
//    }
//    [allStr appendFormat:@"\"username\":\"%@\",",username==nil?@"":username];
//    [allStr appendFormat:@"\"password\":\"%@\"",password==nil?@"":password];
    //    [dic addEntriesFromDictionary:params];

//    NSInteger i=1;
//    for (NSString *str = first; str != nil||(i%2==0); str = va_arg(args,NSString *)) {
//        if (i%2==1) {
//            [allStr appendFormat:@",\"%@\"",str==nil?@"":str];
//        }else{
//            [allStr appendFormat:@":\"%@\"",str==nil?@"":str];
//        }
//        i++;
//    }
//    [allStr appendString:@"}"];
    for (NSString *str = first; str != nil; str = va_arg(args,NSString *)) {
        [allStr appendFormat:@",\"%@\"",str==nil?@"":str];
    }
    va_end(args);
    return allStr;
}


#pragma mark tools URL
/**
 *  创建HTTP POST 请求
 *
 *  @param urlStr
 *  @param params
 *
 *  @return
 */
+(NSMutableURLRequest *)createPOSTRequestWithURL:(NSString *)urlStr params:(NSString *)params
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *paramData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[paramData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:paramData];
    return request;
}
#pragma mark tools 参数
//拼接公共参数
+(NSMutableDictionary *)createPublicParams:(MOMNetPublicParam)publicParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSString *userId = [MOMCurrentUser userId];
//    if (userId&&![@"" isEqualToString:userId]) {
//        [params setObject:userId forKey:@"id"];
//    }
    /*
    if (publicParams&MOMNetPublicParamUserId) {
        if ([MOMFilter filterLogin]) {
        
            NSString *userId = [MOMCurrentUser userId];
            [params setObject:userId forKey:@"userId"];
        }else
        {
            NSLog(@"没登陆。。。。。。。。。。。不让用");
        }
//        [params setObject:@"1" forKey:@"userId"];
        
    }
    
    
    
    if (publicParams&MOMNetPublicParamAreaId) {
        if (![MOMFilter filterArea]) {
            NSLog(@"没小区。。。。。。。。。。。不让用");
        }
        NSString *areaId = [MOMCurrentUser observeAreaId];
        [params setObject:areaId forKey:@"areaId"];
    }
    
    
    if (publicParams&MOMNetPublicParamKey) {
        NSString *key = [MOMCurrentUser key];
        [params setObject:key?key:@"" forKey:@"key"];
    }else{
        NSString *key = [MOMCurrentUser key];
        if (key) {
            [params setObject:key forKey:@"key"];
            
        }
    }
    
    */

    
    return params;
}


#pragma mark tools 假数据
//造假
+(void)simulateData:(NSString *)pathname params:(NSString *)params callback:(void(^)(id result,NSError *error))callback
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:pathname ofType:@"plist"];
    if (plistPath) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        //    NSString *resultstr = [data objectForKey:@"result"];
        NSString *resultstr = [data objectForKey:params];
        if (!resultstr) {
            resultstr = [data objectForKey:@"result"];
        }
        
        //    NSString *tempStr =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *tempData = [resultstr dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result:%@",result);
        
//        if (![MOMFilter filterResult:result]) {
//            callback(result,nil);
//        }
        
    }else{
        callback(@{@"ret":@1},nil);
    }
    
}
@end
