//
//  ASHTableViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/21.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ASHAlertView.h"
#import "MOMProgressHUD.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "UIImageView+ASH.h"
#import "MJRefresh.h"

@interface ASHTableViewController : UITableViewController
@property (nonatomic,assign)BOOL ifAutoSizeCell;

@property(nonatomic,strong)NSArray *dataArr;
@end
