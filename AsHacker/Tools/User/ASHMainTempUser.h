//
//  ASHMainUser.h
//  AsHacker
//
//  Created by 陈涛 on 2017/5/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
@interface ASHMainTempUser : NSObject
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

//年龄
+(void)setAge:(NSString *)age;
+(NSString *)age;

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
//+(void)setSex:(MOMUserSex)sex;
//+(MOMUserSex)sex;
+(void)setSex:(NSString *)sex;
+(NSString *)sex;

////电话号码
+(void)setPhoneNumber:(NSString *)phoneNumber;
+(NSString *)getPhoneNumber;

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

//所在公司
+(void)setCompany:(NSString *)company;
+(NSString *)company;

//承担职位
+(void)setPost:(NSString *)post;
+(NSString *)post;

+(void)setAreaName:(NSString *)areaName;
+(NSString *)areaName;
@end
