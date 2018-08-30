//
//  ASHLoginVerifyViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/24.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHLoginVerifyViewController.h"

@interface ASHLoginVerifyViewController ()

@end

@implementation ASHLoginVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)doVerity:(id)sender {
    NSString *code =  super.codeTF.text;
    NSString *phone =  super.phoneTF.text;
    if (!code||[@"" isEqualToString:code]) {
        
        if (!phone||[@"" isEqualToString:phone]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"请填写密码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }else if (!code||[@"" isEqualToString:code]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"请填写验证码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else{
        /*
         phone_num    用户手机号    String
         openid    微信id    String
         sms_code    用户验证码    String
         token    uuid32    String
         
         ret    返回值：
         1绑定成功
         2绑定失败
         3不是合法的手机号码
         4验证码不正确
         5该openId绑定的用户不存在
         0系统异常    String
         openid    微信id    String
         token    传输token    String
         
         */
        NSString *openId = [ASHMainUser userId];
        NSString *token = [ASHMainUser token];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone_num",code,@"sms_code",openId,@"openid",token,@"token", nil];
        [MOMNetWorking asynRequestByMethod:@"bindPhone.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                
                [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
                NSString *token =[dic objectForKey:@"token"];
                NSString *userId =[dic objectForKey:@"openid"];
                NSString *phoneNum = phone;//[dic objectForKey:@"phone_num"];
                [ASHMainUser setToken:token];
                [ASHMainUser setUserId:userId];
                [ASHMainUser setPhoneNumber:phoneNum];
                
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if (MOMResultWrongCode==ret){
                [MOMProgressHUD showErrorWithStatus:@"验证码错误"];
            }else if (MOMResultWrongPhone==ret){
                [MOMProgressHUD showErrorWithStatus:@"手机号有误"];
            }else if (MOMResultWrongWXOpenId==ret){
                [MOMProgressHUD showErrorWithStatus:@"微信授权失败"];
            }else{
                [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
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
