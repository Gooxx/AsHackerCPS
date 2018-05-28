//
//  PListUtil.h
//  SKYMTJ
//
//  Created by 陈涛 on 14-12-10.
//  Copyright (c) 2014年 陈涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListUtil : NSObject


//读取订阅信息
+(id)plistSubscribe;

//写入订阅信息
+(BOOL)plistSubscribe:(NSArray *)subscribeArr;

/**
 读取预存数据
 */
+(NSArray *)arrayByName:(NSString *)name;

+(NSDictionary *)dicByName:(NSString *)name;

/**
 读取我的列表
 */
+(NSArray *)plistMyMenus;

/**
 临时数据
 */
+(id)plistArrayByName:(NSString *)name;
+(BOOL)plistArrayByName:(NSString *)name withArray:(NSMutableArray *)array;
+(BOOL)plistArrayByName:(NSString *)name appendArray:(NSArray *)array;

+(id)plistDictionaryByName:(NSString *)name;
+(BOOL)plistDictionaryByName:(NSString *)name withDictionary:(NSMutableArray *)dic;
+(BOOL)plistDictionaryByName:(NSString *)name appendDictionary:(NSMutableArray *)dic;
@end
