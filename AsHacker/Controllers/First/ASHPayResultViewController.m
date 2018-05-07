//
//  ASHPayResultViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/12.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHPayResultViewController.h"

@interface ASHPayResultViewController ()

@end

@implementation ASHPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton= YES;
}
- (IBAction)showDetal:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ASHFirstDetailTableViewController class]]) {
            ASHFirstDetailTableViewController *ctl =(ASHFirstDetailTableViewController *)controller;
            ctl.dataDic = self.dataDic;
            [self.navigationController popToViewController:ctl animated:NO];
        }else if ([controller isKindOfClass:[ASHMineChouViewController class]]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
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
