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

-(void)limitImage:(NSString *)name withSize:(CGSize)size{
    UIImage * icon = [UIImage imageNamed:name];
    CGSize itemSize = size ;// CGSizeMake(36, 36);//固定图片大小为36*36
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    self.image = UIGraphicsGetImageFromCurrentImageContext();//*2
//    self sd_
//    [self sd_setImageWithURL:UIGraphicsGetImageFromCurrentImageContext() placeholderImage:[UIImage imageNamed:@"icon"] completed:nil];
    UIGraphicsEndImageContext();
    
//   [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:placeholder?placeholder:@"icon"] completed:completedBlock];
}

@end
