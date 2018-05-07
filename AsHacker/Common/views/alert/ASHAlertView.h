//
//  ASHAlertView.h
//  AsHacker
//
//  Created by 陈涛 on 2017/5/19.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHMainUser.h"
#import "ASHQRCodeHelper.h"
@interface ASHAlertView : UIView

@property(nonatomic,strong)id delegate;
@property (weak, nonatomic) IBOutlet UIImageView *mainIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

+(instancetype)alterMainMenuView;
+(instancetype)alterDetailMenuView;

+(instancetype)alterMainMenuViewIn:(UIView *)view;


+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                            image:(NSString *)image;

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content;


+(instancetype)alterQRCodeViewWithCode:(NSString *)code;
@end
