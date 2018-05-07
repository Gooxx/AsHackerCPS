//
//  ASHFirstDetailTableViewCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/22.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHMainTableViewCell.h"

//项目详情的头
@interface ASHFirstDetailTableViewCell : ASHMainTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *mySupportBtn;
@property (weak, nonatomic) IBOutlet UIButton *publisherBtn;
@property (weak, nonatomic) IBOutlet UIButton *supporterBtn;

@property (strong, nonatomic)  UISegmentedControl *segmentedControl;

@property(nonatomic,assign)NSInteger selectCellNum;
@end
