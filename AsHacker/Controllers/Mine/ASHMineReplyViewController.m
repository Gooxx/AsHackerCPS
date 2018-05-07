//
//  ASHMineReplyViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/6/6.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineReplyViewController.h"

@interface ASHMineReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet YHJTextView *detailTV;
@end

@implementation ASHMineReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YHJTextView *textView=[[YHJTextView alloc]initWithFrame:_textView.frame];
    [self.view addSubview:textView];
    _detailTV = textView;
    //1.设置提醒文字
    textView.myPlaceholder=@"我们非常重视您的声音";
    
    //2.设置提醒文字颜色
    textView.myPlaceholderColor=[UIColor lightGrayColor];
}
- (IBAction)doSave:(id)sender {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[MOMCurrentUser name] forKey:@"username"];
//    [params setObject:_dataDic[@"galleryId"] forKey:@"galleryId"];
    //    [params setObject:_dataDic[@"pictureNo"] forKey:@"pictureNo"];
//    method=feedback
//    userId=用户ID
//    content=内容
//    contact=邮箱或微信
    NSString *content = _detailTV.text;
//    NSString *email = _emailTF.text;
    if (content&&![@"" isEqualToString:content]) {
//        [MOMProgressHUD showWithDuration:2.0 animations:^{
//            
//        } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MOMProgressHUD showSuccessWithStatus:@"反馈成功"];
        });
//            [MOMProgressHUD showSuccessWithStatus:@"反馈成功"];
            
//        }];
        
        //    [params setObject:self.detailTV.text forKey:@"ping"];
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        
//        if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
//           
//            [params setObject:content forKey:@"content"];
//            [params setObject:[ASHMainUser userId] forKey:@"userId"];
//            [params setObject:email forKey:@"contact"];
//            [MOMNetWorking asynRequestByMethod:@"feedback" params:params publicParams:MOMNetPublicParamAreaId callback:^(id result, NSError *error) {
//                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                //        NSString *allDataList = [result objectForKey:@"id"];
//                //        NSString *pingId =  [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
//                //        _pId = pingId;
//                
//                if (MOMResultSuccess==ret) {
//                    [MOMProgressHUD showSuccessWithStatus:@"反馈成功"];
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else{
//                    [MOMProgressHUD showSuccessWithStatus:@"反馈失败"];
//                }
//            }];
//        }else{
//            ASHUserLoginViewController *userLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"userLoginViewController"];
//            //    [self.navigationController pushViewController:userLoginViewController animated:YES];
//            
//            [self presentViewController:userLoginViewController animated:YES completion:^{
//                
//            }];
//        }
        
       
    }else{
         [[[UIAlertView alloc]initWithTitle:@"" message:@"请填写内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
