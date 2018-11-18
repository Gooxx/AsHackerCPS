//
//  ASHNCCodeViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/25.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHNCCodeViewController.h"

@interface ASHNCCodeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mapView;
@end

@implementation ASHNCCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc]init];
    webview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSString *urlString =[NSString stringWithFormat:@"http://39.105.46.149:8080/cps/html/carSecond.html"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
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
