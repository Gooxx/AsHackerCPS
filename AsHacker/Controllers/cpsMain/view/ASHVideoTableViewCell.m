//
//  ASHVideoTableViewCell.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/19.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHVideoTableViewCell.h"

@implementation ASHVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
