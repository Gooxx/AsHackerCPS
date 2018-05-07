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
    
//    NSArray *arr =  self.childViewControllers;
//    UIViewController *c1 = arr[2];
//    UIImage *image = [UIImage imageNamed:@"主页"];
//    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIImage *image2 = [UIImage imageNamed:@"主页_press"];
//    [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    c1.tabBarItem.image = image;
//    c1.tabBarItem.selectedImage = image2;
//    
    
    self.tabBar.tintColor = MOMDarkGrayColor;
    UINavigationController *MAINNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTableNaviController"];
//    MAINNavi.tabBarItem.image = image;
//    MAINNavi.tabBarItem.selectedImage = image2;
//    NSMutableDictionary *textAttrs = [NSMutableDictionarymdictionary];
//    textAttrs[NSForegroundColorAttributeName] =HWColor(123,123, 123);
//    
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionarymdictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColororangeColor];
//    
//    [childVc.tabBarItemsetTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [childVc.tabBarItemsetTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    UINavigationController *DATANavi = [self.storyboard instantiateViewControllerWithIdentifier:@"activityTableController2"];
    
    UINavigationController *USERNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavi"];
    
    
    self.viewControllers = @[MAINNavi,DATANavi,USERNavi];

//    self.
//    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
