//
//  ASHQRCodeHelper.h
//  AsHacker
//
//  Created by 陈涛 on 2017/11/8.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASHQRCodeHelper : NSObject
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;
@end
