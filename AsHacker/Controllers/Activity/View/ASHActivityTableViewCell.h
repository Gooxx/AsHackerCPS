//
//  ASHActivityTableViewCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/4/7.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHMainTableViewCell.h"
@interface ASHActivityTableViewCell : ASHMainTableViewCell
@property (strong, nonatomic)  UIImageView *mainIV;


@property (weak, nonatomic) IBOutlet UIButton *observeBtn;

//@property (strong, nonatomic)  UILabel *lookLabel;
//@property (strong, nonatomic)  UIButton *shareBtn;
//@property (strong, nonatomic)  UIButton *downloadBtn;
@end
