//
//  AshShareUM.h
//  AsHacker
//
//  Created by 陈涛 on 2017/6/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
@interface AshShareUM : UIViewController
+(void)doShare;

+(void)doShareWithTitle:(NSString *)title img:(NSString *)img detail:(NSString *)detail web:(NSString *)web;

@end
