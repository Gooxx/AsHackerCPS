//
//  ASHOImageView.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/30.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHOImageView.h"

@implementation ASHOImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.masksToBounds =YES;
        self.layer.cornerRadius = self.bounds.size.width/2;
    }
    return self;
}


@end
