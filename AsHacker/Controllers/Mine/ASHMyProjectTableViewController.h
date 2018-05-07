//
//  ASHMyProjectTableViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ASHAlertView.h"
#import "MOMProgressHUD.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "UIImageView+ASH.h"
#import "MJRefresh.h"

#import "ASHMainTableViewCell.h"

#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerateVC.h"
#import "SGQRCodeScanningVC.h"

#import "ASHFirstDetailTableViewCell.h"
@interface ASHMyProjectTableViewController : UITableViewController
@property(nonatomic,strong)NSDictionary *dataDic;
@end
