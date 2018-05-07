//
//  MOMUser.h
//  LivingArea
//
//  Created by goooo on 15/9/21.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MOMObject.h"
//#import "MOMUser.h"
//#import "MOMArea.h"
#import "Config.h"
//@class MOMArea;

@interface MOMCurrentUser : NSObject

//+(instancetype)user;

//用户Id
+(void)setUserId:(NSString *)userId;
+(NSString *)userId;

//session
+(void)setKey:(NSString *)key;
+(NSString *)key;

//用户名
+(void)setName:(NSString *)name;
+(NSString *)name;

//用户昵称
+(void)setNick:(NSString *)nick;
+(NSString *)nick;

//密码
+(void)setPassword:(NSString *)password;
+(NSString *)password;

//头像
+(void)setHead:(NSString *)head;
+(NSString *)head;

//本地头像
+(void)setLocalHead:(NSString *)head;

+(NSString *)localHead;

//性别
+(void)setSex:(MOMUserSex)sex;
+(MOMUserSex)sex;

////电话号码
//+(void)setPhoneNumber:(NSString *)phoneNumber;
//+(NSString *)getPhoneNumber;

//所属小区
//+(void)setArea:(MOMArea *)area;
//+(MOMArea *)getArea;

+(void)setAreaId:(NSString *)areaId;
+(NSString *)areaId;


//所关注 观察小区
+(void)setObserveAreaId:(NSString *)areaId;
+(NSString *)observeAreaId;

+(void)setObserveAreaName:(NSString *)areaName;
+(NSString *)observeAreaName;


+(void)setAreaName:(NSString *)areaName;
+(NSString *)areaName;

+(void)setGalleryType:(MOMGalleryType)galleryType;
+(MOMGalleryType)galleryType;

+(void)setBgImage:(NSString *)bgImage;
+(NSString *)bgImage;

//清理当前用户信息
//+(void)cleanCurrentUser;


@end
