//
//  ASHTabBarController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/25.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHTabBarController.h"

@interface ASHTabBarController ()

@end

@implementation ASHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tabBar.tintColor = MOMDarkGrayColor;
//    UINavigationController *MAINNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTableNaviController"];
//
//    UINavigationController *DATANavi = [self.storyboard instantiateViewControllerWithIdentifier:@"activityTableController2"];
//
//    UINavigationController *USERNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavi"];
//
//    self.viewControllers = @[MAINNavi,DATANavi,USERNavi];
    
    
//    UINavigationController *cpsMainNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"cpsMainNavi"];
//    
//    UINavigationController *cpsServiceNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"cpsServiceNavi"];
//    
//    self.viewControllers =@[cpsMainNavi,cpsServiceNavi];

}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    NSLog(@"activityTableController2---%@----%@",item,tabBar);
//    if (![@"" isEqualToString:item.title]) {
//        <#statements#>
//    }
    if (item.tag!=@22) {
        UINavigationController *DATANavi = [self.storyboard instantiateViewControllerWithIdentifier:@"activityTableController2"];
        ASHActivityTableViewController *ctl =  DATANavi.topViewController;
        [ctl.playerView pause];
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
