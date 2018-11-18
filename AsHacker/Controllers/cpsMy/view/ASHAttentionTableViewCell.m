//
//  ASHAttentionTableViewCell.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/21.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHAttentionTableViewCell.h"

@implementation ASHAttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)doObserve:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
