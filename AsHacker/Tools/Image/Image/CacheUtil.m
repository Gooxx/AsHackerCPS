//
//  CacheUtil.m
//  Talents3
//
//  Created by chen on 15/4/28.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "CacheUtil.h"
//#import "Constant.h"

@implementation CacheUtil
+(void)loadImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc
{
    [self loadImage:imgName placeholderImage:@"icon" completion:fuc];
}

+(void)loadImage:(NSString *)_imgName placeholderImage:(NSString *)placeholderImageName completion:(void (^)(UIImage *img))fuc
{
    
    
    //    dispatch_queue_t headQueue = dispatch_queue_create("com.js.Tanlents3", NULL);
//    NSString *txPath = [[NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",[[_imgName stringByReplacingOccurrencesOfString:@"//" withString:@"="] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSString *cachePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString *txPath = [[NSString stringWithFormat:@"%@/%@",cachePath,[[_imgName stringByReplacingOccurrencesOfString:@"//" withString:@"="] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]] stringByReplacingOccurrencesOfString:@"," withString:@""];
//     NSString *txPath = [[NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Cache",[[_imgName stringByReplacingOccurrencesOfString:@"//" withString:@"="] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    UIImage *txImage = [UIImage imageWithContentsOfFile:txPath];
    if (txImage) {
        NSLog(@"本地有这个图片！地址：%@",txPath);
        fuc(txImage);
    }else{
        fuc([UIImage imageNamed:placeholderImageName]);
        dispatch_async(headQueue, ^{
            NSString *imgName = [_imgName stringByReplacingOccurrencesOfString:@"," withString:@""];
//            imgName = [[imgName copy] stringByReplacingOccurrencesOfString:@"," withString:@""];
            //            UIImage *headImage =  [UIImage imageNamed:imgName];
            //            if ([imgName containsString:@"/"]) {
            if (imgName&&![imgName isEqualToString:@""]) {
                if ([imgName rangeOfString:@"/"].location!= NSNotFound) {
                    
                    if (LOCAL_DATA) {
                        NSString *imgName2=  [imgName substringFromIndex:[imgName rangeOfString:@"/" options:NSBackwardsSearch].location+1];
                        UIImage *headImage =  [UIImage imageNamed:imgName2];
                        
                        //本地的转换方式
                        NSData *headData = UIImagePNGRepresentation(headImage);
                        
                        if (headImage) {
                            fuc(headImage);
                            [headData writeToFile:txPath atomically:NO];
                        }

                    }else{
                        NSString *imgURLName =  [NSString stringWithFormat:@"%@%@",HTTPURL_IMG,imgName];
                        NSData *headData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURLName]];
                        UIImage *headImage = [UIImage imageWithData:headData];
                        if (headImage) {
                            fuc(headImage);
                            [headData writeToFile:txPath atomically:NO];
                        }else{
                            NSLog(@"没请求到图片！地址：%@",imgURLName);
                        }
                        
                    }
                    
                    
                    
                }
            }
            
            
            
            //网络请求的转换方式
            /*
             //            NSString *headStr = [NSString stringWithFormat:@"%@%@",@"",[imgName stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
             NSData *headData =  [NSData dataWithContentsOfURL:[NSURL URLWithString:imgName]];
             if(headData){
             UIImage *headImage =  [UIImage imageWithData:headData];
             fuc(headImage);
             [headData writeToFile:txPath atomically:NO];
             }else{
             fuc([UIImage imageNamed:@"icon"]);
             }
             */
        });
    }
    
}

+(void)loadNativeImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc
{
    //    dispatch_queue_t headQueue = dispatch_queue_create("com.js.Tanlents3", NULL);
    NSString *txPath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",[imgName stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
    UIImage *txImage = [UIImage imageWithContentsOfFile:txPath];
    if (txImage) {
        fuc(txImage);
    }else{
        
//        dispatch_async(headQueue, ^{
//            NSString *headStr = [NSString stringWithFormat:@"%@%@",HTTPURL,[imgName stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
//            NSData *headData =  [NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]];
//            if(headData){
//                UIImage *headImage =  [UIImage imageWithData:headData];
//                fuc(headImage);
//                [headData writeToFile:txPath atomically:NO];
//            }else{
                fuc([UIImage imageNamed:@"moren"]);
//            }
//        });
    }
    
}

+(void)loadNetImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc
{
    //    dispatch_queue_t headQueue = dispatch_queue_create("com.js.Tanlents3", NULL);
    NSString *txPath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",[imgName stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
//    UIImage *txImage = [UIImage imageWithContentsOfFile:txPath];
//    if (txImage) {
//        fuc(txImage);
//    }else{
    
                dispatch_async(headQueue, ^{
//                    NSString *headStr = [NSString stringWithFormat:@"%@%@",@"",[imgName stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
                    NSData *headData =  [NSData dataWithContentsOfURL:[NSURL URLWithString:imgName]];
                    if(headData){
                        UIImage *headImage =  [UIImage imageWithData:headData];
                        fuc(headImage);
                        [headData writeToFile:txPath atomically:NO];
                    }else{
        fuc([UIImage imageNamed:@"moren"]);
                    }
                });
//    }
    
}
@end
