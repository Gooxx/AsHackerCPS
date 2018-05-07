//
//  MOMUser.m
//  LivingArea
//
//  Created by goooo on 15/9/21.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import "MOMCurrentUser.h"

@implementation MOMCurrentUser
//+(instancetype)objectWithDictinary:(NSDictionary *)dic
//{
//    id ob = [super objectWithDictinary:dic];
//    if ([dic isKindOfClass:[NSDictionary class]]) {
//        [self setUserId:[dic objectForKey:@"userId"]];
//        [self setKey:[dic objectForKey:@"key"]];
//        [self setName:[dic objectForKey:@"name"]];
//        [self setNick:[dic objectForKey:@"nick"]];
//        //    [self setPassword:nil];
//        //    [self setPhoneNumber:[dic objectForKey:@"phone"]];
//        [self setHead:[dic objectForKey:@"head"]];
//        [self setSex:[[dic objectForKey:@"sex"] integerValue]];
//        //    [self setArea:[dic objectForKey:@"area"]];
//        
//        [self setAreaId:[dic objectForKey:@"area_id"]];
//        [self setAreaName:[dic objectForKey:@"area_name"]];
//        
//        [self setObserveAreaId:[dic objectForKey:@"area_id"]];
//        [self setObserveAreaName:[dic objectForKey:@"area_name"]];
//        
//        //    [MOMUserDefaults setObject:[dic objectForKey:@"area_id"] forKey:@"areaId"];
//        //    [MOMUserDefaults setObject:[dic objectForKey:@"area_name"] forKey:@"areaName"];
//        
//        //    [MOMUserDefaults setObject:[dic objectForKey:@"area_id"] forKey:@"observeAreaId"];
//        //    [MOMUserDefaults setObject:[dic objectForKey:@"area_name"] forKey:@"observeAreaName"];
//        
//    }
//    NSLog(@"user:%@",ob);
//    return ob;
//}


//+(instancetype)user
//{
////    MOMUser objectWithDictinary:<#(NSDictionary *)#>
////    [self getAreaId];
//    return self;
//    
//}
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
    return [MOMUserDefaults objectForKey:@"userId"];
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
    return [MOMUserDefaults objectForKey:@"nick"];
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

//头像
+(void)setHead:(NSString *)head
{
    [MOMUserDefaults setObject:head forKey:@"head"];
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
+(void)setSex:(MOMUserSex)sex
{
    [MOMUserDefaults setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
}
+(MOMUserSex)sex
{
     return [[MOMUserDefaults objectForKey:@"sex"] integerValue];
}

////电话号码
//+(void)setPhoneNumber:(NSString *)phoneNumber
//{
//    [MOMUserDefaults setObject:phoneNumber forKey:@"phoneNumber"];
//}
//+(NSString *)getPhoneNumber
//{
//     return [MOMUserDefaults objectForKey:@"phoneNumber"];
//}

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
    if (!areaName||[@"" isEqualToString:areaName]) {
        areaName = @"";
    }
    return areaName;
}

+(void)setGalleryType:(MOMGalleryType)galleryType
{
    [MOMUserDefaults setObject:[NSNumber numberWithInteger:galleryType] forKey:@"galleryType"];

}
+(MOMGalleryType)galleryType
{
    return [MOMUserDefaults integerForKey:@"galleryType"];
}


+(void)setBgImage:(NSString *)bgImage{
    [MOMUserDefaults setObject:bgImage forKey:@"bgImage"];
}

+(NSString *)bgImage
{
    NSString *areaName =  [MOMUserDefaults objectForKey:@"bgImage"];
    if (!areaName||[@"" isEqualToString:areaName]) {
        areaName = @"pp1";
    }
    return areaName;
}


+(void)cleanCurrentUser
{
//    [self objectWithDictinary:@{}];
}
@end
