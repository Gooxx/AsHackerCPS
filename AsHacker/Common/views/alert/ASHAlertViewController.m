//
//  ASHAlertViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/19.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHAlertViewController.h"

@interface ASHAlertViewController ()

@end

@implementation ASHAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//+ (instancetype)alertControllerWithImage:(NSString *)img title:(NSString *)title description:(NSString *)description cancel:(NSString *)cancel button:(NSString *)button action:(void (^)())buttonAction
+ (instancetype)alertControllerWithImage:(NSString *)img title:(NSString *)title description:(NSString *)description
{
//    NSAssert(title.length > 0 || description.length > 0 , @"title和description不能同时为空");
    
//    KTAlertController *alert = [[KTAlertController alloc] init];
//    alert.modalPresentationStyle = UIModalPresentationCustom;
//    alert.titleText = title;
//    alert.descriptionText = description;
//    alert.cancelText = cancel ? cancel : @"取消";
//    alert.buttonText = button;
//    alert.buttonAction = buttonAction;
   ASHAlertViewController *alert = [[ASHAlertViewController alloc]initWithNibName:@"ASHAlertViewController" bundle:nil];
    
    alert.title = @"1111";
    if (alert) {
        
    }
    
    return alert;
}
//- (instancetype)init
//{
//    if (self = [super init]) {
////        [self configureController];
//        self.title=@"init";
//    }
//    return self;
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
////        [self configureController];
//    }
//    return self;
//}
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibNameOrNil];
//    if (self) {
//        
//    }
//    
//    return self;
//}
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
