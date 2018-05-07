//
//  ASHSupportPrePayTableViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/11/5.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "MOMProgressHUD.h"
#import "UIImageView+ASH.h"
#import "ASHAlertView.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "MJRefresh.h"
#import "ASHMainTableViewCell.h"


#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "ASHPayResultViewController.h"
#import "ASHSupportSettingAreaViewController.h"


@interface ASHSupportPrePayTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;


@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *comment;
@end
