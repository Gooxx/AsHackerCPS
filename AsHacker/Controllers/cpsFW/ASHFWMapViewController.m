//
//  ASHFWMapViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHFWMapViewController.h"

@interface ASHFWMapViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mapView;

@end

@implementation ASHFWMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _mapView.delegate = self;
//    [_mapView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.map.baidu.com/place/search?query=充电桩&radius=1000&region=天津&output=html&src=webapp.baidu.openAPIdemo"]]];
    
    
    UIWebView *webview = [[UIWebView alloc]init];
//    webview.backgroundColor = [UIColor redColor];
    webview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    double latitude =45.748737;
//    double longitude =126.699791;
//    NSString *urlString =[NSString stringWithFormat:@"http://map.baidu.com"];
//    NSString *urlString =[NSString stringWithFormat:@"http://api.map.baidu.com/place/search?query=充电桩&location=39.12,171.20&radius=1000&region=天津&output=html&src=webapp.baidu.openAPIdemo"];
     NSString *urlString =[NSString stringWithFormat:@"https://www.powerlife.com.cn/h5bitauto/pile.html"];
//    NSString *urlString =[NSString stringWithFormat:@"http://uri.amap.com/search?keyword=充电桩&center=171.20,39.12&city=300000&view=map&src=mypage&coordinate=gaode&callnative=0"];
//    URL: //uri.amap.com/search?keyword=美食&center=121.515601,31.233456&city=310000&view=map&src=mypage&coordinate=gaode&callnative=0
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
