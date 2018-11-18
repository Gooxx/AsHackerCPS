//
//  ASHMainUser.h
//  AsHacker
//
//  Created by 陈涛 on 2017/5/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
@interface ASHMainUser : NSObject
//用户Id 
+(void)setUserId:(NSString *)userId;
+(NSString *)userId;
//authorization  token
//+(void)setAuthorization:(NSString *)authorization;
//+(NSString *)authorization;

+(void)setToken:(NSString *)token;
+(NSString *)token;


//用户昵称
+(void)setNick:(NSString *)nick;
+(NSString *)nick;

//用户简介
+(void)setShowInfo:(NSString *)info;
+(NSString *)showInfo;

////电话号码
+(void)setPhoneNumber:(NSString *)phoneNumber;
+(NSString *)getPhoneNumber;

//头像
+(void)setHead:(NSString *)head;
+(NSString *)head;


//session
+(void)setKey:(NSString *)key;
+(NSString *)key;

//密码
+(void)setPassword:(NSString *)password;
+(NSString *)password;
//本地头像
+(void)setLocalHead:(NSString *)head;
+(NSString *)localHead;

//bbsCount    动态数量    String
+(void)setBbsCount:(NSString *)count;
+(NSString *)bbsCount;

//followCount    关注数量    String
+(void)setFollowCount:(NSString *)count;
+(NSString *)followCount;
//fansCount    粉丝数量    String
+(void)setFansCount:(NSString *)count;
+(NSString *)fansCount;


// 是否已经绑定电话号码 is_first_login    因为不需要绑定只会返回1
+(void)setFirstLogin:(NSString *)enable;
+(BOOL)isFirstLogin;
/*
//性别
//+(void)setSex:(MOMUserSex)sex;
//+(MOMUserSex)sex;
+(void)setSex:(NSString *)sex;
+(NSString *)sex;
//年龄
+(void)setAge:(NSString *)age;
+(NSString *)age;
 
 
 
 +(void)setAreaName:(NSString *)areaName;
 +(NSString *)areaName;
 
 //所在公司
 +(void)setCompany:(NSString *)company;
 +(NSString *)company;
 
 //承担职位
 +(void)setPost:(NSString *)post;
 +(NSString *)post;
 
 
 //已经观看的食品数量
 +(void)setWatchedNum:(NSInteger )num;
 +(NSInteger )watchedNum;
 
 //是否允许非WiFi下载
 +(void)setEnableWIFIDownload:(BOOL )enable;
 +(BOOL)isEnableWIFIDownload;
 
 //已经缓存的视频们
 +(void)setDownloadVideos:(NSArray *)downloadVideos;
 +(NSArray *)downloadVideos;
 
 
 //展示提示吗 首页
 +(void)setShowTip:(BOOL)ifShow;
 +(BOOL)ifShow;
 
 +(void)setShowTip60:(BOOL)ifShow;
 +(BOOL)ifShow60;
 
 //首页流
 +(void)setGIFData:(NSData *)data index:(NSInteger )index;
 +(NSData *)GIFDataindex:(NSInteger)index;
*/




//用户名
//+(void)setName:(NSString *)name;
//+(NSString *)name;
//所属小区
//+(void)setArea:(MOMArea *)area;
//+(MOMArea *)getArea;

//+(void)setAreaId:(NSString *)areaId;
//+(NSString *)areaId;


//所关注 观察小区
//+(void)setObserveAreaId:(NSString *)areaId;
//+(NSString *)observeAreaId;
//
//+(void)setObserveAreaName:(NSString *)areaName;
//+(NSString *)observeAreaName;
+(void)loginUserInfo:(NSDictionary *)dic;
//更新用户信息
+(void)updateUserInfo:(NSDictionary *)dic;
//清除信息
+(void)cleanInfo;
@end
