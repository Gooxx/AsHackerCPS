//
//  AppDelegate.h
//  AsHacker
//
//  Created by 陈涛 on 2017/3/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
//#import "UIImageView+WebCache.h"
#import "JSVideoViewController.h"

////微信SDK头文件
#import "WXApi.h"
#import "WXApiManager.h"


#import "MOMNetWorking.h"

#import "ASHSupportPrePayTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

