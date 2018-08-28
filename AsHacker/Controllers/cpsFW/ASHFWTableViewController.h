//
//  ASHFWTableViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "MOMProgressHUD.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "UIImageView+ASH.h"
#import "MJRefresh.h"

#import "ASHBBSModel.h"

#import "ASH1VCell.h"
#import "ASHBBS1PCell.h"
#import "ASH3PCell.h"

#import "ASHNewsTWDetailViewController.h"
#import "ASHNewsVideoDetailTableViewController.h"

@interface ASHFWTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
