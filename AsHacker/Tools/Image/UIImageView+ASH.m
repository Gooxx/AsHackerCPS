//
//  UIImageView+ASH.m
//  LivingArea
//
//  Created by goooo on 16/5/4.
//  Copyright © 2016年 mom. All rights reserved.
//

#import "UIImageView+ASH.h"

@implementation UIImageView(ASH)

- (void)ash_setImageWithURL:(NSString *)strURL
{
    [self ash_setImageWithURL:strURL placeholderImage:nil completed:nil];
}

- (void)ash_setImageWithURL:(NSString *)strURL placeholderImage:(NSString *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    NSString *imgURLName =  strURL;//[NSString stringWithFormat:@"%@%@",HTTPURL_IMG,strURL];
    NSURL *imgURL;//[NSURL URLWithString:imgURLName];
    if ([imgURLName containsString:@"http:"]||[imgURLName containsString:@"https:"]||!imgURLName||[@"" isEqualToString:imgURLName]) {
        imgURL=[NSURL URLWithString:imgURLName];
        [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"logo"] completed:completedBlock];
    }else{
        NSString *imgURLStrT = [NSString stringWithFormat:@"%@%@",HTTPURLCDN,imgURLName];
        NSString *imgURLStrT2 = [imgURLStrT stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        imgURL=[NSURL URLWithString:imgURLStrT2];
        [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"logo"] completed:completedBlock];
    }
//    if ([imgURLName containsString:@"http:"]||[imgURLName containsString:@"https:"]||!imgURLName||[@"" isEqualToString:imgURLName]) {
//        imgURL=[NSURL URLWithString:imgURLName];
//          [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"icon"] completed:completedBlock];
//    }else if ([imgURLName containsString:@"/projects/"]||[imgURLName containsString:@"/organizers/"]){
//        NSString *imgURLStrT = [NSString stringWithFormat:@"%@%@",HTTPURL,imgURLName];
//        NSString *imgURLStrT2 = [imgURLStrT stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//
//        imgURL=[NSURL URLWithString:imgURLStrT2];
//        [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"icon"] completed:completedBlock];
//    }else{
////        imgURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPURL_IMG,imgURLName]];
//        
//        self.image = [UIImage imageWithContentsOfFile:imgURLName];
//        
//    }
//    NSURL *imgURL = [NSURL URLWithString:imgURLName];
//    [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"icon"] completed:completedBlock];
}

@end
