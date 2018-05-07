//
//  MOMSecurityHelper.m
//  LivingArea
//
//  Created by goooo on 15/9/22.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import "MOMSecurityHelper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MOMSecurityHelper

+(NSString *)md5:(NSString *)str
{
    if (!str) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)md5:(NSString *)str salt:(NSString *)salt
{
    return  [self md5:[NSString stringWithFormat:@"%@{%@}",str,salt]];
    
}

@end
