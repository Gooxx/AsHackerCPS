//
//  MOMTimeHelper.h
//  LivingArea
//
//  Created by goooo on 16/1/19.
//  Copyright © 2016年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOMTimeHelper : NSObject
//最后进行比较，将现在的时间与指定时间比较，如果没达到指定日期，返回-1，刚好是这一时间，返回0，否则返回1
+(int)comparetoDay:(NSString *)anotherDay;
+(NSString *) change:(NSString*)time;
//格式化时间为 xxx小时前
+(NSString *) compareCurrentTime:(NSString *)compareStr;
//+(NSString *)resultSinceTime:(NSString *)time;

///根据月 日 转换为星座
+(NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d;

///通过年月日，计算年龄
+(NSNumber*)fromDateToAge:(NSDate*)date;



/**
 *  判断当前时间是否处于某个时间段内
 *
 *  @param startTime        开始时间
 *  @param expireTime       结束时间
 */

+ (BOOL)validateWithStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime;
@end
