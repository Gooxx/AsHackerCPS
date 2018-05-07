//
//  MOMProgressHUD.m
//  LivingArea
//
//  Created by goooo on 15/11/16.
//  Copyright © 2015年 mom. All rights reserved.
//

#import "MOMProgressHUD.h"

@implementation MOMProgressHUD

+(void)showWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration animations:^{
        [MOMProgressHUD show];
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
        [MOMProgressHUD dismiss];
    }];
}

+ (void)showWithStatus:(NSString*)status {
    [super showWithStatus:status];
    [super dismissWithDelay:1.5];
}

+ (void)showSuccessWithStatus:(NSString*)status
{
    [super showSuccessWithStatus:status];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:MOMWhiteGrayColor];
    [super dismissWithDelay:1.5];
}
@end
