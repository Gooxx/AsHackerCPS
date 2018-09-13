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
    
    _webView.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_detailId forKey:@"id"];
//    [params setObject:ASHMainUser.userId forKey:@"userId"];

    [MOMNetWorking asynRequestByMethod:@"mainBbsById.do" params:params publicParams:MOMNetPublicParamToken callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            ASHBBSModel *model = [ASHBBSModel ModelWithDict:dic];
            
           NSString *headHTMLStr = [NSString stringWithFormat:@"<h1>%@</h1><p style='red'><span style='color:gray;'>%@  %@</span></p><br>%@",model.bbs_title,model.user_nick,model.bbs_time,model.bbs_content];
            
            [_webView loadHTMLString:headHTMLStr baseURL:nil];
            
            _collectBtn.selected = model.is_store;
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

- (IBAction)doCollect:(UIButton *)sender {
    if (!sender.selected) {
//        flag    标识
//        1 点赞
//        2 收藏
//        bbs_id    文章id
//        user_id    用户id
//        token    传输token
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_detailId forKey:@"bbs_id"];
        [params setObject:@"2" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"insertDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                _collectBtn.selected = YES;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"收藏失败"];
            }
        }];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_detailId forKey:@"bbs_id"];
        [params setObject:@"2" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"delDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                _collectBtn.selected = NO;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"取消收藏失败"];
            }
        }];
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
