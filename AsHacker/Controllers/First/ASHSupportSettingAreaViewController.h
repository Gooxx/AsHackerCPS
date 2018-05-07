//
//  ASHSupportSettingAreaViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/11/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "MOMProgressHUD.h"
#import "MOMNetWorking.h"

@interface ASHSupportSettingAreaViewController : UIViewController
@property(nonatomic,strong)id delegate;

@property(nonatomic,strong)NSDictionary *dataDic;
@end
