//
//  ASHLoginViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/26.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHLoginViewController.h"
#import "Config.h"
#import "MOMNetWorking.h"
#import "ASHMainUser.h"

#import "MOMProgressHUD.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>


//#import <UMSocialCore/UMSocialCore.h>
#import "MOMNetWorking.h"

#import "MOMProgressHUD.h"

@interface ASHLoginViewController (){
    NSDate *beginTime;
    NSTimer *_timer;
    
}
//@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
//@property (weak, nonatomic) IBOutlet UITextField *codeTF;
//@property (weak, nonatomic) IBOutlet UIButton *codeBtn;


@end

@implementation ASHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (IBAction)sengdCode:(UIButton *)sender {
    //    NSString *code =  self.codeTF.text;
    NSString *phone =  self.phoneTF.text;
    //    NSString *inviteCode = self.inviteTF.text;
    //    if (code&&![@"" isEqualToString:code]&&phone&&![@"" isEqualToString:phone]) {
    
    if (!phone||[@"" isEqualToString:phone]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"请完整填写手机号码"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        sender.enabled = NO;
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCode:) userInfo:nil repeats:YES];
            //        [_timer fire];
            [_timer setFireDate:[NSDate date]];
            beginTime = [NSDate date];
        }
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone_num", nil];
        [MOMNetWorking asynRequestByMethod:@"validCode.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            //            NSDictionary *dic = result; // sms_code
            if (MOMResultSuccess==ret) {
                [MOMProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
            }else{
                [MOMProgressHUD showSuccessWithStatus:@"验证码发送失败"];
            }
        }];
        
    }
    
}


-(void)updateCode:(NSTimer *)sender
{
    //    NSLog(@"updateCode--------%ld",isec);
    //计算时间差
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSCalendarUnitSecond;//NSMinuteCalendarUnit;//NSHourCalendarUnit;//年、月、日、时、分、秒、周等等都可以
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:beginTime toDate:[NSDate date] options:0];
    NSInteger sec = [comps second];//时间差
    
    //            if (-1>=_sec) {
    if (-1>=(kWaitTime-sec)) {
        //             _sec=WaitTime;
        //        [[[UIAlertView alloc]initWithTitle:@"" message:MyLocalizedString(@"验证码等待超时") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        NSLog(@"period canel");
        //                dispatch_suspend(timer);
        [_timer setFireDate:[NSDate distantFuture]];
        _timer = nil;
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
    }else{
        NSLog(@"__________________________sec:%ld",sec);
        //                [_vetifyBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_sec--] forState:UIControlStateNormal];
        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)kWaitTime-sec] forState:UIControlStateNormal];
        
    }
    /*
     [_rightBtn setTitle:[NSString stringWithFormat:@"%ld",isec] forState:UIControlStateNormal];
     isec--;
     if (isec<0) {
     [_timer invalidate];
     _timer = nil;
     [_rightBtn setTitle:@"发送" forState:UIControlStateNormal];
     isec = kWaitTime;
     self.rightBtn.enabled = YES;
     }*/
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)checkNull:(NSString *)str
{
    if (str&&![@"" isEqualToString:str]) {
        return YES;
    }
    return NO;
}

- (IBAction)doLogin:(id)sender {
    [self savePhone:sender];
}

- (IBAction)loginWeiXin:(id)sender {
//    [self getAuthWithUserInfoFromWechat];
    
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"cps";
    //第三方向微信终端发送一个SendAuthReq消息结构
    BOOL b = [WXApi sendReq:req];
    NSLog(@"-------------;%@",b?@"yes":@"no");
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示结果的
-(void) onResp:(BaseResp*)resp
{
    SendAuthResp *res = (SendAuthResp *)resp;
    NSString *code = res.code;
    NSLog(@"微信SDK自带的方法------------------：%@",res.code);
    [MOMNetWorking checkWXTokenWithCode:code callback:^(id result, NSError *error) {
        NSLog(@"result :%@",result);
//        openId
//        accesstoken
//        {
//            "access_token":"ACCESS_TOKEN",
//            "expires_in":7200,
//            "refresh_token":"REFRESH_TOKEN",
//            "openid":"OPENID",
//            "scope":"SCOPE",
//            "unionid":"o6_bmasdasdsad6_2sgVt7hMZOPfL"
//        }
        NSString *openId = [result objectForKey:@"openid"];
        NSString *accesstoken = [result objectForKey:@"access_token"];
        if (accesstoken) {
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:openId,@"openId",accesstoken,@"accesstoken", nil];
            [MOMNetWorking asynRequestByMethod:@"wxLogin.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
                NSInteger ret = [[result objectForKey:@"ret"] integerValue];
                NSDictionary *dic = result;
                if (MOMResultSuccess==ret) {
                    
                     [ASHMainUser updateUserInfo:dic];
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                    NSString *token =[dic objectForKey:@"token"];
//                    NSString *userId =[dic objectForKey:@"openid"];
////                    NSString *phoneNum =[dic objectForKey:@"phone_num"];
//                    [ASHMainUser setToken:token];
//
//                    [ASHMainUser setUserId:userId];
////                    [ASHMainUser setPhoneNumber:phoneNum];
//
//                    [ASHMainUser setNick:[dic objectForKey:@"userInfo"]];
//                    [ASHMainUser setHead:[dic objectForKey:@"headimgurl"]];
//                    [ASHMainUser setBbsCount:[dic objectForKey:@"bbsCount"]];
//                    [ASHMainUser setFollowCount:[dic objectForKey:@"followCount"]];
//                    [ASHMainUser setFansCount:[dic objectForKey:@"fansCount"]];
                    
                    
                    //判断是否已经绑定过手机号码
//                    if (<#condition#>) {
                        id ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHLoginVerifyViewController"];
                        [self.navigationController pushViewController:ctl animated:YES];
                    //                    }else{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
                   
                }else{
                    [MOMProgressHUD showSuccessWithStatus:@"微信登录失败"];
                }
                
            }];
        }else{
            [MOMProgressHUD showErrorWithStatus:@"请重新登录"];
        }
        
        
    }];
    
}

-(void)doCheckToken
{
    
}





- (IBAction)savePhone:(id)sender {
    NSString *code =  self.codeTF.text;
    NSString *phone =  self.phoneTF.text;
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
        请求http://localhost:8080/cps/app/cps/login.do
        名称    描述    类型
        phone_num    用户号码    String
        sms_code    用户验证码    String
        响应
        名称    描述    类型
        ret    返回值：
        1成功获取用户
        2不是合法的手机号码
        3验证码有误
        0注册失败    String
        open_id    微信id    String
        user_token    传输token    String
        phone_num    用户号码    String
         user_head    用户头像    String
         user_minhead    用户缩略头像    String
         user_nick    用户昵称    String
         user_info    用户信息    String
         bbsCount    动态数量    String
         followCount    关注数量    String
         fansCount    粉丝数量    String
         
        */
        
        
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone_num",code,@"sms_code", nil];
            [MOMNetWorking asynRequestByMethod:@"login.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
                NSInteger ret = [[result objectForKey:@"ret"] integerValue];
                NSDictionary *dic = result;
                if (MOMResultSuccess==ret) {
                    
                    [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
                    
                    [ASHMainUser loginUserInfo:dic];

                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    
                }else{
                    [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
                }
                
            }];
    }
    
}
- (IBAction)doStop:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//
//-(void)updateUserInfo:(NSDictionary *)dic
//{
//    NSString *token =[dic objectForKey:@"user_token"];
//    NSString *userId =[dic objectForKey:@"user_id"];
//    NSString *phoneNum =[dic objectForKey:@"phone_num"];
//    NSString *isfirstlogin =[dic objectForKey:@"is_first_login"];
//    [ASHMainUser setToken:token];
//    [ASHMainUser setUserId:userId];
//    [ASHMainUser setPhoneNumber:phoneNum];
//    [ASHMainUser setFirstLogin:isfirstlogin];
//
//    [ASHMainUser setNick:[dic objectForKey:@"user_nick"]];
//    [ASHMainUser setHead:[dic objectForKey:@"user_head"]];
//    [ASHMainUser setBbsCount:[dic objectForKey:@"bbsCount"]];
//    [ASHMainUser setFollowCount:[dic objectForKey:@"followCount"]];
//    [ASHMainUser setFansCount:[dic objectForKey:@"fansCount"]];
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
