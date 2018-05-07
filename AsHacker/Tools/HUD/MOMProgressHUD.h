//
//  MOMProgressHUD.h
//  LivingArea
//
//  Created by goooo on 15/11/16.
//  Copyright © 2015年 mom. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Config.h"

//#import <SVProgressHUD/SVProgressHUD.h>

@interface MOMProgressHUD : SVProgressHUD
+(void)showWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)showWithStatus:(NSString*)status;

+ (void)showSuccessWithStatus:(NSString*)status;
@end
