//
//  ASHMineUserSimpleViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/11/8.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "ASHMainTempUser.h"
#import "MOMProgressHUD.h"

#import <UMSocialCore/UMSocialCore.h>
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "MOMProgressHUD.h"
#import "ASHMineUserInfoController.h"
@interface ASHMineUserSimpleViewController : UIViewController
@property(nonatomic,strong)id delegate;

@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,strong)NSString *projectId;

@end
