//
//  ASHPayResultViewController.h
//  AsHacker
//
//  Created by 陈涛 on 2017/11/12.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHFirstDetailTableViewController.h"
#import "ASHMineChouViewController.h"
@interface ASHPayResultViewController : UIViewController
    @property (weak, nonatomic) IBOutlet UILabel *infoLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *typeIV;
    @property (weak, nonatomic) IBOutlet UIButton *showBtn;
    @property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property(nonatomic,strong)NSDictionary *dataDic;

//@property (nonatomic,strong)

@end
