//
//  ASHMineViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/4/24.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ASHMainUser.h"
#import "MOMNetWorking.h"
#import "UIImageView+ASH.h"
#import "ASHMineUserInfoController.h"



@interface ASHMineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *nickView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@end
