//
//  ASHMainUser.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMainTempUser.h"

@implementation ASHMainTempUser

//用户Id
+(void)setUserId:(NSString *)userId
{
    [MOMUserDefaults setObject:userId forKey:@"t_userId"];
}
+(NSString *)userId
{
    //    if (![MOMFilter filterLogin]) {
    //        NSLog(@"没登陆。。。。。。。。。。。不让用");
    //        return ;
    //    }
    if(![MOMUserDefaults objectForKey:@"t_userId"]){
        NSLog(@"【***********************不存在该userId************************】");
    }
    return [MOMUserDefaults objectForKey:@"t_userId"];
}


//session
+(void)setKey:(NSString *)key
{
    [MOMUserDefaults setObject:key forKey:@"t_key"];
}
+(NSString *)key
{
    return [MOMUserDefaults objectForKey:@"t_key"];
}
//用户名
+(void)setName:(NSString *)name
{
    
    [MOMUserDefaults setObject:name forKey:@"t_name"];
}
+(NSString *)name
{
    return [MOMUserDefaults objectForKey:@"t_name"];
}
+(void)setNick:(NSString *)nick
{
    [MOMUserDefaults setObject:nick forKey:@"t_nick"];
}
+(NSString *)nick
{
    return [MOMUserDefaults objectForKey:@"t_nick"];
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
//密码
+(void)setPassword:(NSString *)password
{
    [MOMUserDefaults setObject:password forKey:@"t_password"];
}
+(NSString *)password
{
    return [MOMUserDefaults objectForKey:@"t_password"];
}

//头像
+(void)setHead:(NSString *)head
{
    [MOMUserDefaults setObject:head forKey:@"t_head"];
}

+(NSString *)head
{
    return [MOMUserDefaults objectForKey:@"t_head"];
}

//头像
+(void)setLocalHead:(NSString *)head
{
    [MOMUserDefaults setObject:head forKey:@"t_localHead"];
}

+(NSString *)localHead
{
    return [MOMUserDefaults objectForKey:@"t_localHead"];
}
//性别
//+(void)setSex:(MOMUserSex)sex
//{
//    [MOMUserDefaults setObject:[NSNumber numberWithInteger:sex] forKey:@"t_sex"];
//}
//+(MOMUserSex)sex
//{
//    return [[MOMUserDefaults objectForKey:@"t_sex"] integerValue];
//}

//性别
+(void)setSex:(NSString *)sex
{
    [MOMUserDefaults setObject:sex forKey:@"t_sex"];
}
+(NSString *)sex
{
    return [MOMUserDefaults objectForKey:@"t_sex"];
}

////电话号码
+(void)setPhoneNumber:(NSString *)phoneNumber
{
    [MOMUserDefaults setObject:phoneNumber forKey:@"t_phoneNumber"];
}
+(NSString *)getPhoneNumber
{
     return [MOMUserDefaults objectForKey:@"t_phoneNumber"];
}

//所属小区
//+(void)setArea:(MOMArea *)area
//{
//    [MOMUserDefaults setObject:area.areaId forKey:@"t_areaId"];
//    [MOMUserDefaults setObject:area.areaName forKey:@"t_areaName"];
//}
//
//
//
//+(MOMArea *)getArea
//{
////     return [MOMUserDefaults objectForKey:@"t_area"];
//    NSString *areaId = [MOMUserDefaults objectForKey:@"t_areaId"];
//    NSString *areaName = [MOMUserDefaults objectForKey:@"t_areaName"];
//    if (areaId&&areaName) {
//        return  [MOMArea objectWithDictinary:@{@"areaId":areaId,@"areaName":areaName}];
//    }
//    return  nil;
//
//}

+(void)setAreaId:(NSString *)areaId
{
    [MOMUserDefaults setObject:areaId forKey:@"t_areaId"];
}
+(NSString *)areaId
{
    return [MOMUserDefaults objectForKey:@"t_areaId"]?[MOMUserDefaults objectForKey:@"t_areaId"]:@"";
}

+(void)setObserveAreaId:(NSString *)areaId
{
    [MOMUserDefaults setObject:areaId forKey:@"t_observeAreaId"];
}
+(NSString *)observeAreaId
{
    return [MOMUserDefaults objectForKey:@"t_observeAreaId"]?[MOMUserDefaults objectForKey:@"t_observeAreaId"]:@"1";
}

+(void)setObserveAreaName:(NSString *)areaName
{
    [MOMUserDefaults setObject:areaName forKey:@"t_observeAreaName"];
}
+(NSString *)observeAreaName
{
    return [MOMUserDefaults objectForKey:@"t_observeAreaName"]?[MOMUserDefaults objectForKey:@"t_observeAreaName"]:@"";
}

+(void)setAreaName:(NSString *)areaName
{
    [MOMUserDefaults setObject:areaName forKey:@"t_areaName"];
}

+(NSString *)areaName
{
    NSString *areaName =  [MOMUserDefaults objectForKey:@"t_areaName"];
    if (!areaName||[@"" isEqualToString:areaName]) {
        areaName = @"";
    }
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
    if (!areaName||[@"" isEqualToString:areaName]) {
        areaName = @"";
    }
    return areaName;
}

//承担职位
+(void)setPost:(NSString *)post
{
    [MOMUserDefaults setObject:post forKey:@"t_post"];
}
+(NSString *)post
{
    {
        NSString *areaName =  [MOMUserDefaults objectForKey:@"t_post"];
        if (!areaName||[@"" isEqualToString:areaName]) {
            areaName = @"";
        }
        return areaName;
    }
}
@end
