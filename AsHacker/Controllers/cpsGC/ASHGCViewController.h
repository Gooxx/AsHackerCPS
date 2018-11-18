//
//  ASHGCViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/22.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "config.h"
#import "MOMNetWorking.h"

#import <AFNetworking/AFNetworking.h>
#import "UIImageView+ASH.h"
#import "ASHCarInfoModel.h"

#import "PListUtil.h"
#import "ChineseString.h"

#import "ASHBandTableViewCell.h"
#import "ASHGCTopTableViewCell.h"
#import "ASHGCTopCollectionViewCell.h"

#import "ASHGCarTableViewController.h"



@interface ASHGCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
