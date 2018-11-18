//
//  ASHMineUserEditController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/5/9.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ASHMainTempUser.h"
@interface ASHMineUserEditController : UIViewController
@property(nonatomic,strong)NSString *detailValue;

//传入cell数据
@property (nonatomic ,strong) UITableViewCell *cell;
@property (nonatomic ,weak) id delegate;
@end
