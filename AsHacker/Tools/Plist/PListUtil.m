//
//  PListUtil.m
//  SKYMTJ
//
//  Created by 陈涛 on 14-12-10.
//  Copyright (c) 2014年 陈涛. All rights reserved.
//

#import "PListUtil.h"
static NSString *const PEOPLE_INFOS = @"PeopleInfos.plist";
static NSString *const SUBSCRIBE_PLIST = @"Subscribe";
static NSString *const MESSAGE_PLIST = @"Message.plist";
static NSString *const JOIN_PLIST = @"Join.plist";
static NSString *const COLLECT_PLIST = @"Collect.plist";
static NSString *const PLIST = @"plist";
static NSInteger const INFO_COUNT = 100;
@implementation PListUtil

//读取订阅信息
+(id)plistSubscribe
{
    //加入用户过滤，只查询到该用户的浏览记录
    
    //////////////////////////
    
    //plist路径
    NSString *path = [[NSBundle mainBundle]pathForResource:SUBSCRIBE_PLIST ofType:PLIST];
    //lplist内容
    NSArray *subscribeArr = [NSArray arrayWithContentsOfFile:path];
    //
    return subscribeArr;
}

//写入订阅信息
+(BOOL)plistSubscribe:(NSArray *)subscribeArr
{
    //加入用户过滤，只查询到该用户的浏览记录
    
    //////////////////////////
    //plist路径
    NSString *path = [[NSBundle mainBundle]pathForResource:SUBSCRIBE_PLIST ofType:PLIST];
     NSLog(@"plist path:%@",path);
    //写入plist内容
    BOOL b= [subscribeArr writeToFile:path atomically:NO];
    return b;
}

/**
 读取预存数据
 */
+(NSArray *)arrayByName:(NSString *)name{
    //plist路径
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:PLIST];
    //lplist内容
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    //
    return arr;
}

+(NSDictionary *)dicByName:(NSString *)name{
    //plist路径
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:PLIST];
    //lplist内容
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    //
    return dic;
}

/**
 读取我的列表
 */
+(NSArray *)plistMyMenus{
   return  [self arrayByName:@"MyMenus"];
}

+(id)plistArrayByName:(NSString *)name
{
    NSString *path1 = [[NSBundle mainBundle] pathForResource:name ofType:PLIST];
     NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    
    NSLog(@"plist path:%@---path1:%@",path,path1);
//    if (!path) {
//         [imageData writeToFile:fullPathDoc atomically:NO];
//    }
    return [[NSMutableArray alloc] initWithContentsOfFile:path];
}

+(BOOL)plistArrayByName:(NSString *)name withArray:(NSMutableArray *)array
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    NSLog(@"plist:%@ cout:%ld",name,(unsigned long)array.count);
//    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:PLIST];
    return  [array writeToFile:path atomically:NO];

}           

+(BOOL)plistArrayByName:(NSString *)name appendArray:(NSMutableArray *)array
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:PLIST];
//    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:path];

    
   
    if (arr) {
        [arr addObjectsFromArray:array];
    }
    
    if (arr.count>INFO_COUNT) {
        [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(INFO_COUNT, arr.count-INFO_COUNT)]];
    }
    return  [arr writeToFile:path atomically:NO];
    
    
}

+(id)plistDictionaryByName:(NSString *)name
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:PLIST];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    return [[NSMutableDictionary alloc] initWithContentsOfFile:path];
}
/*
+(BOOL)plistDictionaryByName:(NSString *)name withDictionary:(NSMutableArray *)dic
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    return  [dic writeToFile:path atomically:NO];
}

+(BOOL)plistDictionaryByName:(NSString *)name appendDictionary:(NSMutableArray *)dic
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
    NSMutableDictionary *dicOld = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [dicOld addEntriesFromDictionary:dic];
    return  [dicOld writeToFile:path atomically:NO];
}
*/
@end
