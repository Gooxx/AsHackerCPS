//
//  ASHNewsTWDetailViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "MOMNetWorking.h"
#import "UIImageView+ASH.h"
#import "MOMProgressHUD.h"

#import "ASHBBSModel.h"
@interface ASHNewsTWDetailViewController : UIViewController
@property(nonatomic,strong)NSString *detailId;

@property(nonatomic,strong)ASHBBSModel *lModel;
@end
