//
//  ASHTextLabel.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHTextLabel.h"

@implementation ASHTextLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 2, 0, 2))];
}

@end
