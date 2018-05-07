//
//  UILabel+border.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/22.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "UIView+border.h"

@implementation UIView (border)
/**
 * 设置边框宽度
 *
 */
- (void)setBorderWidth:(CGFloat)borderWidth
{
    if(borderWidth <0) return;
    self.layer.borderWidth = borderWidth;
}

/**
 * 设置边框颜色
 */
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius >0;
}
@end
