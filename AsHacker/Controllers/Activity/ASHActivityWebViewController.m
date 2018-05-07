//
//  ASHActivityWebViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/10.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHActivityWebViewController.h"

@interface ASHActivityWebViewController ()
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
//@property(nonatomic,strong)UIWebView *webView;
//@property(nonatomic,strong)UIButton *applyBtn;
@end

@implementation ASHActivityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(doShare)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    self.navigationItem.title = self.title;
    _applyBtn.backgroundColor =  MOMRGBColor(38, 232, 169);//MOMRGBColor(77, 130, 277);
    [_applyBtn setTitle:@"报名" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_applyBtn addTarget:self action:@selector(doApply) forControlEvents:UIControlEventTouchUpInside];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    
}
-(void)doApply{
    
    NSDictionary *params = [NSDictionary dictionary];
    if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",[_dataDic objectForKey:@"EVENT_ID"],@"eventId",nil];
        [MOMNetWorking asynRequestByMethod:@"enroll_volunteer_event" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                [MOMProgressHUD showSuccessWithStatus:@"报名成功"];
            }
        }];
        
    }else{
        
        UINavigationController *navi =  [self.storyboard instantiateViewControllerWithIdentifier:@"userLoginNaviController"];
        navi.navigationBar.translucent = YES;
        ASHUserLoginViewController *userLoginViewController = navi.topViewController;
        userLoginViewController.states = 1;
        //        [userLoginViewController setState:1];
        [self presentViewController:navi animated:YES completion:^{
            
        }];

    }

//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",@"",@"eventId", nil];
  
}
-(void)doShare{
    [AshShareUM doShare];
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
