//
//  ASHFirstDetailTableViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/22.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "UIImageView+ASH.h"
#import "ASHAlertView.h"
#import "MOMProgressHUD.h"
#import "ASHFirstDetailTableViewCell.h"
#import "ZFPlayer.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"
#import "MJRefresh.h"
#import "AshShareUM.h"

#import "MOMTimeHelper.h"

#import "ASHMainCollectionViewCell.h"
#import "ASHFirstDetailSupportTableViewCell.h"
#import "ASHPublisherMainTableViewCell.h"
#import "ASHFirstDetailCollectTableViewCell.h"
#import "ASHSupportTableViewController.h"
#import "ASHMinePhoneViewController.h"

#import "ASHFirstJoinSuccessViewController.h"


#import "ASHMineUserSimpleViewController.h"

@interface ASHFirstDetailTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,strong)NSDictionary *projectData;
//NSDictionary *_projectData;//头
@end
