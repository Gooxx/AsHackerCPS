//
//  ASHCommentTableViewCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/4/12.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOMNetWorking.h"
#import "ASHOImageView.h"
@interface ASHCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ASHOImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *znumLabel;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;


@property(nonatomic,strong)NSString *pingId;
@end
