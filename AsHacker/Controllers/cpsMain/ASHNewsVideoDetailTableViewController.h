//
//  ASHNewsVideoDetailTableViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHBBSModel.h"
@interface ASHNewsVideoDetailTableViewController : UITableViewController
@property(nonatomic,strong)ASHBBSModel *lModel;

@property(nonatomic,strong)NSString *detailId;
@end
