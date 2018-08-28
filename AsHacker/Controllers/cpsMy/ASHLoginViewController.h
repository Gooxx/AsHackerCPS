//
//  ASHLoginViewController.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/26.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiManager.h"
@interface ASHLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@end
