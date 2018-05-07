//
//  MOMSecurityHelper.h
//  LivingArea
//
//  Created by goooo on 15/9/22.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOMSecurityHelper : NSObject
//MD5加密
+(NSString *)md5:(NSString *)str;

//MD5加密 加盐加密
+(NSString *)md5:(NSString *)str salt:(NSString *)salt;
@end
