//
//  ASHNewsTWDetailViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHNewsTWDetailViewController.h"

@interface ASHNewsTWDetailViewController ()
@property(strong,nonatomic)NSArray *dataArr;


@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end



@implementation ASHNewsTWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_detailId forKey:@"id"];
//    [params setObject:ASHMainUser.userId forKey:@"userId"];

    [MOMNetWorking asynRequestByMethod:@"mainBbsById.do" params:params publicParams:MOMNetPublicParamToken callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
            //            _logoArr = [ASHLogoModel ModelsWithArray:[dic objectForKey:@"list"]];
            //            [self.tableView reloadData];
        }
    }];
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:_detailId forKey:@"id"];
//    [params setObject:ASHMainUser.userId forKey:@"userId"];
//    
//    [MOMNetWorking asynRequestByMethod:@"mainBbsById.do" params:@{@"flag":@1} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
//            //            _dataArr = [dic objectForKey:@"list"];
//            //            _logoArr = [ASHLogoModel ModelsWithArray:[dic objectForKey:@"list"]];
//            //            [self.tableView reloadData];
//        }
//    }];
}

- (IBAction)doCollect:(id)sender {
    
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
