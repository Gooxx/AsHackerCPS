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
        return @"1";
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

+(void)setToken:(NSString *)token
{
    [MOMUserDefaults setObject:token forKey:@"token"];
}
+(NSString *)token
{
    NSString *token = [MOMUserDefaults objectForKey:@"token"]?[MOMUserDefaults objectForKey:@"token"]:@"";
    return token;
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

// 是否已经绑定电话号码 is_first_login    因为不需要绑定只会返回1
+(void)setFirstLogin:(NSString *)need
{
    [MOMUserDefaults setObject:need forKey:@"is_first_login"];
}
+(BOOL)isFirstLogin
{
    NSString *need =  [MOMUserDefaults objectForKey:@"is_first_login"]?[MOMUserDefaults objectForKey:@"is_first_login"]:@"0";
    if ([@"1" isEqualToString:need]) {
        return NO;
    }
    return  YES;
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



//bbsCount    动态数量    String
+(void)setBbsCount:(NSString *)count{
     [MOMUserDefaults setObject:count forKey:@"bbs_count"];
}
+(NSString *)bbsCount
{
    return  [MOMUserDefaults objectForKey:@"bbs_count"]?[MOMUserDefaults objectForKey:@"bbs_count"]:@"0";
    
}

//followCount    关注数量    String
+(void)setFollowCount:(NSString *)count
{
    [MOMUserDefaults setObject:count forKey:@"follow_count"];
}
+(NSString *)followCount
{
    return  [MOMUserDefaults objectForKey:@"follow_count"]?[MOMUserDefaults objectForKey:@"follow_count"]:@"0";
    
}
//fansCount    粉丝数量    String
+(void)setFansCount:(NSString *)count
{
    [MOMUserDefaults setObject:count forKey:@"fans_count"];
}
+(NSString *)fansCount
{
    return  [MOMUserDefaults objectForKey:@"fans_count"]?[MOMUserDefaults objectForKey:@"fans_count"]:@"0";
    
}

//用户简介
+(void)setShowInfo:(NSString *)info
{
     [MOMUserDefaults setObject:info forKey:@"user_info"];
}
+(NSString *)showInfo
{
    return  [MOMUserDefaults objectForKey:@"user_info"]?[MOMUserDefaults objectForKey:@"user_info"]:@"";
}
+(void)loginUserInfo:(NSDictionary *)dic
{
    NSString *token =[dic objectForKey:@"user_token"];
    NSString *userId =[dic objectForKey:@"user_id"];
    NSString *phoneNum =[dic objectForKey:@"phone_num"];
    NSString *isfirstlogin =[dic objectForKey:@"is_first_login"];
    [ASHMainUser setToken:token];
    [ASHMainUser setUserId:userId];
    [ASHMainUser setPhoneNumber:phoneNum];
    [ASHMainUser setFirstLogin:isfirstlogin];
    
    [ASHMainUser setNick:[dic objectForKey:@"user_nick"]];
    [ASHMainUser setShowInfo:[dic objectForKey:@"user_info"]];
    [ASHMainUser setHead:[dic objectForKey:@"user_head"]];
    [ASHMainUser setBbsCount:[dic objectForKey:@"bbs_count"]];
    [ASHMainUser setFollowCount:[dic objectForKey:@"follow_count"]];
    [ASHMainUser setFansCount:[dic objectForKey:@"fans_count"]];
    
    [MOMUserDefaults setObject:dic forKey:@"userInfo"];
}
+(void)updateUserInfo:(NSDictionary *)dic
{
//    NSString *token =[dic objectForKey:@"user_token"];
    NSString *userId =[dic objectForKey:@"id"];
    NSString *phoneNum =[dic objectForKey:@"phone_num"];
//    NSString *isfirstlogin =[dic objectForKey:@"is_first_login"];
//    [ASHMainUser setToken:token];
    [ASHMainUser setUserId:userId];
    [ASHMainUser setPhoneNumber:phoneNum];
//    [ASHMainUser setFirstLogin:isfirstlogin];
    
    [ASHMainUser setNick:[dic objectForKey:@"user_nick"]];
    [ASHMainUser setShowInfo:[dic objectForKey:@"user_info"]];
    [ASHMainUser setHead:[dic objectForKey:@"user_head"]];
    [ASHMainUser setBbsCount:[dic objectForKey:@"bbs_count"]];
    [ASHMainUser setFollowCount:[dic objectForKey:@"follow_count"]];
    [ASHMainUser setFansCount:[dic objectForKey:@"fans_count"]];
    
    [MOMUserDefaults setObject:dic forKey:@"userInfo"];
}

+(void)cleanInfo
{
    [ASHMainUser setToken:nil];
    [ASHMainUser setUserId:nil];
    [ASHMainUser setPhoneNumber:nil];
    [ASHMainUser setFirstLogin:nil];
    
    [ASHMainUser setNick:nil];
    [ASHMainUser setShowInfo:nil];
    [ASHMainUser setHead:nil];
    [ASHMainUser setBbsCount:nil];
    [ASHMainUser setFollowCount:nil];
    [ASHMainUser setFansCount:nil];
//    [ASHMainUser setAuthorization:nil];
//
//        [ASHMainUser setUserId:nil];
//        [ASHMainUser setNick:nil];
//        [ASHMainUser setSex:nil];
//        [ASHMainUser setHead:nil];
//
//     [ASHMainUser setPhoneNumber:nil];
//     [ASHMainUser setAge:nil];
//     [ASHMainUser setPost:nil];
//     [ASHMainUser setCompany:nil];
//    [ASHMainUser setAreaName:nil];
    
    [ASHMainUser setWatchedNum:0];
    
    
}
@end
