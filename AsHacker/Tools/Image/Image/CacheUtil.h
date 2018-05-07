//
//  CacheUtil.h
//  Talents3
//
//  Created by chen on 15/4/28.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"
//#define headQueue  dispatch_queue_create("com.js.Tanlents3", NULL)
#define headQueue  dispatch_queue_create("com.mom.LivingArea", NULL)
//#definsw dispatch_queue_t headQueue = dispatch_queue_create("com.js.Tanlents3", NULL);
@interface CacheUtil : NSObject
//TODO: 我不是针对这个类，我的意思是，这就是个垃圾
//自动依次检索缓存区的图片进行加载
+(void)loadImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc;
+(void)loadImage:(NSString *)imgName placeholderImage:(NSString *)placeholderImageName completion:(void (^)(UIImage *img))fuc;
//只加载本地图片
+(void)loadNativeImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc;
//只加载网路图片
+(void)loadNetImage:(NSString *)imgName completion:(void (^)(UIImage *img))fuc;
@end
