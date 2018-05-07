//
//  UIImageView+ASH.h
//  LivingArea
//
//  Created by goooo on 16/5/4.
//  Copyright © 2016年 mom. All rights reserved.
//

//#import <UIKit/UIKit.h>
//#import <UIImageView+WebCache.h>//哪天心情不好就干掉他
#import "UIImageView+WebCache.h"
#import "Config.h"
@interface UIImageView(ASH)
//设置图片
- (void)ash_setImageWithURL:(NSString *)strURL;
//设置图片
- (void)ash_setImageWithURL:(NSString *)strURL placeholderImage:(NSString *)placeholder completed:(SDExternalCompletionBlock)completedBlock;


@end
