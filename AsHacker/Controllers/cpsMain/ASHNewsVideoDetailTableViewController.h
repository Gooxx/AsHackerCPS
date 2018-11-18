//
//  ASHNewsVideoDetailTableViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "Config.h"
#import "ASHMainUser.h"
#import "MOMNetWorking.h"
#import "UIImageView+ASH.h"
#import "MOMProgressHUD.h"

#import "ASHBBSModel.h"
#import "MJRefresh.h"

#import "ZFPlayer.h"
#import "JWPlayer.h"

#import "ASHVideoTableViewCell.h"



#import "ASH1VCell.h"
#import "ASHBBS1PCell.h"
#import "ASH3PCell.h"
@interface ASHNewsVideoDetailTableViewController : UITableViewController
@property(nonatomic,strong)ASHBBSModel *lModel;

@property(nonatomic,strong)NSString *detailId;
@end
