//
//  ASHMineChouViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/4.
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


#import "ASHMyJoinTableViewController.h"
#import "ASHMySupportTableViewController.h"
#import "ASHMyAttentionTableViewController.h"
#import "ASHMyProjectTableViewController.h"

#import "ASHMinePhoneViewController.h"
#import "ASHMineUserSimpleViewController.h"
#import "ASHMineSettingTableViewController.h"

@interface ASHMineChouViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
