//
//  ASHMainUser.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMainUser.h"

@implementation ASHMainUser
//用户Id
+(void)setUserId:(NSString *)userId
{
    [MOMUserDefaults setObject:userId forKey:@"userId"];
}
+(NSString *)userId
{
    //    if (![MOMFilter filterLogin]) {
    //        NSLog(@"没登陆。。。。。。。。。。。不让用");
    //        return ;
    //    }
    if(![MOMUserDefaults objectForKey:@"userId"]){
        NSLog(@"【***********************不存在该userId************************】");
        return @"";
    }
    return [MOMUserDefaults objectForKey:@"userId"];
}

//authorization
+(void)setAuthorization:(NSString *)authorization
{
//    NSString *tauthorization =  [NSString stringWithFormat:@"Bearer %@",authorization];
//    [MOMUserDefaults setObject:tauthorization forKey:@"authorization"];
    
    
    [MOMUserDefaults setObject:authorization forKey:@"authorization"];
}
+(NSString *)authorization
{
//    return [MOMUserDefaults objectForKey:@"authorization"];
    NSString *auth = [MOMUserDefaults objectForKey:@"authorization"];
    if (auth) {
       return  [NSString stringWithFormat:@"Bearer %@",[MOMUserDefaults objectForKey:@"authorization"]];
    }
    return nil;
//     NSString *tauthorization =  [NSString stringWithFormat:@"Bearer %@",[MOMUserDefaults objectForKey:@"authorization"]];
//    return tauthorization;
    
}

//session
+(void)setKey:(NSString *)key
{
    [MOMUserDefaults setObject:key forKey:@"key"];
}
+(NSString *)key
{
    return [MOMUserDefaults objectForKey:@"key"];
}
//用户名
+(void)setName:(NSString *)name
{
    
    [MOMUserDefaults setObject:name forKey:@"name"];
}
+(NSString *)name
{
    return [MOMUserDefaults objectForKey:@"name"];
}
+(void)setNick:(NSString *)nick
{
    [MOMUserDefaults setObject:nick forKey:@"nick"];
}
+(NSString *)nick
{
    NSString *nick =  [MOMUserDefaults objectForKey:@"nick"];
    if (nick&&![@"" isEqualToString:nick]) {
        return  [MOMUserDefaults objectForKey:@"nick"];
    }else{
        return @"筹小鸭";
    }
//    return [MOMUserDefaults objectForKey:@"nick"];
}
//密码
+(void)setPassword:(NSString *)password
{
    [MOMUserDefaults setObject:password forKey:@"password"];
}
+(NSString *)password
{
    return [MOMUserDefaults objectForKey:@"password"];
}
//已经观看的食品数量
+(void)setWatchedNum:(NSInteger )num
{
    [MOMUserDefaults setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"watchedNum"];
}
+(NSInteger )watchedNum
{
    return [[MOMUserDefaults objectForKey:@"watchedNum"]integerValue];
}

//是否允许非WiFi下载
+(void)setEnableWIFIDownload:(BOOL )enable
{
     [MOMUserDefaults setObject:[NSString stringWithFormat:@"%@",enable?@"YES":@"No"] forKey:@"isEnableWIFIDownload"];
}
+(BOOL)isEnableWIFIDownload
{
    if ([MOMUserDefaults objectForKey:@"isEnableWIFIDownload"]) {
         return [[MOMUserDefaults objectForKey:@"isEnableWIFIDownload"]boolValue];
    }else{
        return YES;
    }
   
}
//已经缓存的视频们
+(void)setDownloadVideos:(NSArray *)downloadVideos
{
     [MOMUserDefaults setObject:downloadVideos forKey:@"downloadVideos"];
}
+(NSArray *)downloadVideos
{
    return [MOMUserDefaults objectForKey:@"downloadVideos"];
}

//头像
+(void)setHead:(NSString *)head
{
//    if (![head isEqualToString:@"http://47.92.114.252:80/assets/avatars/avatar.png"]) {
        [MOMUserDefaults setObject:head forKey:@"head"];
//    }
    
}

+(NSString *)head
{
    return [MOMUserDefaults objectForKey:@"head"];
}

//头像
+(void)setLocalHead:(NSString *)head
{
    [MOMUserDefaults setObject:head forKey:@"localHead"];
}

+(NSString *)localHead
{
    return [MOMUserDefaults objectForKey:@"localHead"];
}
//性别
//+(void)setSex:(MOMUserSex)sex
//{
//    [MOMUserDefaults setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
//}
//+(MOMUserSex)sex
//{
//    return [[MOMUserDefaults objectForKey:@"sex"] integerValue];
//}

//性别
+(void)setSex:(NSString *)sex
{
    [MOMUserDefaults setObject:sex forKey:@"sex"];
}
+(NSString *)sex
{
    return [MOMUserDefaults objectForKey:@"sex"];
}
//年龄
+(void)setAge:(NSString *)age
{
    [MOMUserDefaults setObject:age forKey:@"t_age"];
}
+(NSString *)age
{
    return [MOMUserDefaults objectForKey:@"t_age"];
}
////电话号码
+(void)setPhoneNumber:(NSString *)phoneNumber
{
    [MOMUserDefaults setObject:phoneNumber forKey:@"phoneNumber"];
}
+(NSString *)getPhoneNumber
{
     return [MOMUserDefaults objectForKey:@"phoneNumber"];
}

//所属小区
//+(void)setArea:(MOMArea *)area
//{
//    [MOMUserDefaults setObject:area.areaId forKey:@"areaId"];
//    [MOMUserDefaults setObject:area.areaName forKey:@"areaName"];
//}
//
//
//
//+(MOMArea *)getArea
//{
////     return [MOMUserDefaults objectForKey:@"area"];
//    NSString *areaId = [MOMUserDefaults objectForKey:@"areaId"];
//    NSString *areaName = [MOMUserDefaults objectForKey:@"areaName"];
//    if (areaId&&areaName) {
//        return  [MOMArea objectWithDictinary:@{@"areaId":areaId,@"areaName":areaName}];
//    }
//    return  nil;
//
//}

+(void)setAreaId:(NSString *)areaId
{
    [MOMUserDefaults setObject:areaId forKey:@"areaId"];
}
+(NSString *)areaId
{
    return [MOMUserDefaults objectForKey:@"areaId"]?[MOMUserDefaults objectForKey:@"areaId"]:@"";
}

+(void)setObserveAreaId:(NSString *)areaId
{
    [MOMUserDefaults setObject:areaId forKey:@"observeAreaId"];
}
+(NSString *)observeAreaId
{
    return [MOMUserDefaults objectForKey:@"observeAreaId"]?[MOMUserDefaults objectForKey:@"observeAreaId"]:@"1";
}

+(void)setObserveAreaName:(NSString *)areaName
{
    [MOMUserDefaults setObject:areaName forKey:@"observeAreaName"];
}
+(NSString *)observeAreaName
{
    return [MOMUserDefaults objectForKey:@"observeAreaName"]?[MOMUserDefaults objectForKey:@"observeAreaName"]:@"";
}

+(void)setAreaName:(NSString *)areaName
{
    [MOMUserDefaults setObject:areaName forKey:@"areaName"];
}

+(NSString *)areaName
{
    NSString *areaName =  [MOMUserDefaults objectForKey:@"areaName"];
//    if (!areaName||[@"" isEqualToString:areaName]) {
//        areaName = @"";
//    }
    return areaName;
}

//所在公司
+(void)setCompany:(NSString *)company
{
    [MOMUserDefaults setObject:company forKey:@"t_company"];
}
+(NSString *)company
{
    NSString *areaName =  [MOMUserDefaults objectForKey:@"t_company"];
//    if (!areaName||[@"" isEqualToString:areaName]) {
//        areaName = @"";
//    }
    return areaName;
}

//承担职位
+(void)setPost:(NSString *)post
{
    [MOMUserDefaults setObject:post forKey:@"t_post"];
}
+(NSString *)post
{
    
        NSString *areaName =  [MOMUserDefaults objectForKey:@"t_post"];
//        if (!areaName||[@"" isEqualToString:areaName]) {
//            areaName = @"";
//        }
        return areaName;
    
}


+(void)setShowTip:(BOOL)ifShow
{
     [MOMUserDefaults setObject:[NSNumber numberWithBool:ifShow] forKey:@"ifShow"];
}
+(BOOL)ifShow
{
    if (![MOMUserDefaults objectForKey:@"ifShow"]) {
        return YES;
    }
    return  [[MOMUserDefaults objectForKey:@"ifShow"]boolValue];
}

+(void)setShowTip60:(BOOL)ifShow
{
    [MOMUserDefaults setObject:[NSNumber numberWithBool:ifShow] forKey:@"ifShow60"];
}
+(BOOL)ifShow60
{
    return  [[MOMUserDefaults objectForKey:@"ifShow60"]boolValue];
}

+(void)cleanInfo
{
    [ASHMainUser setAuthorization:nil];
        [ASHMainUser setUserId:nil];
        [ASHMainUser setNick:nil];
        [ASHMainUser setSex:nil];
        [ASHMainUser setHead:nil];
    
     [ASHMainUser setPhoneNumber:nil];
     [ASHMainUser setAge:nil];
     [ASHMainUser setPost:nil];
     [ASHMainUser setCompany:nil];
    [ASHMainUser setAreaName:nil];
    
    [ASHMainUser setWatchedNum:0];
    
    
}
@end