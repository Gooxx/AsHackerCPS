//
//  UILabel+border.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/22.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIButton (border)
//注意:加上IBInspectable就可以可视化显示相关的属性
/**
 * 可视化设置边框宽度
 */
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;

/**
 * 可视化设置边框颜色
 */
@property (nonatomic,strong)IBInspectable UIColor *borderColor;

/**
 * 可视化设置圆角
 */
@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;
@end
