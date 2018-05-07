//
//  ASHActivityWebViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/4/10.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ASHMainUser.h"
#import "MOMNetWorking.h"
#import "ASHUserLoginViewController.h"

#import "MOMProgressHUD.h"
#import "AshShareUM.h"
@interface ASHActivityWebViewController : UIViewController
@property(nonatomic,strong)NSString *webUrl;
@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSDictionary *dataDic;
@end
