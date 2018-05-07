//
//  ASHFirstDetailDetailViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstDetailDetailViewController.h"

@interface ASHFirstDetailDetailViewController ()

@end

@implementation ASHFirstDetailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setMainImage:(UIImage *)image
{
    //    float h1 = image.frame.size.height;
    //        UIImage *image = imageView.image;
    self.mainIV.image = image;
    float h = (image.size.height*SCREEN_WIDTH)/image.size.width;
    CGRect rect =  self.view.frame;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = h;
    //    rect.origin.y = 57;
    self.view.frame = rect;
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
