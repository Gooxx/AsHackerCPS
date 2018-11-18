//
//  ASHGCarTableViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/26.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "config.h"
#import "MOMNetWorking.h"

#import <AFNetworking/AFNetworking.h>
#import "UIImageView+ASH.h"
#import "ASHCarInfoModel.h"
#import "ASHCarModel.h"

#import "PListUtil.h"
#import "ChineseString.h"

#import "ASHBandTableViewCell.h"

//#import "ASHGCMainTableViewController.h"
#import "ASHMainViewController.h"


@interface ASHGCarTableViewController : UITableViewController
@property(nonatomic,strong)NSString *bandId;
@end
