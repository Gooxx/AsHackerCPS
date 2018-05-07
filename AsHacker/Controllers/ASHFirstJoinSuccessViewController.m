//
//  ASHFirstJoinSuccessViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/8.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstJoinSuccessViewController.h"

@interface ASHFirstJoinSuccessViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ASHFirstJoinSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    _imageView =imageView;
    _imageView.hidden = YES;
}

- (IBAction)showCode:(UIButton *)sender {
    //    {"statusCode":0,"entercode":"11022151","qrcodeurl":"/img/qrcode/11022151.png"}
    UIImage *qrCode = [ASHQRCodeHelper qrImageForString: [_dataDic objectForKey:@"entercode"] imageSize:180 logoImageSize:180];

    _imageView.image = qrCode;
    _imageView.hidden = NO;

     CGRect rect = _imageView.frame;
    rect.origin.y = sender.frame.origin.y+sender.frame.size.height+20;
    _imageView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
