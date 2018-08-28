//
//  ASH1VCell.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHBBS1PCell.h"
@interface ASH1VCell : ASHBBS1PCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIView *videoView;

@end
