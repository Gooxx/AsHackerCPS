//
//  ASHMinePhoneViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/11.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMinePhoneViewController.h"
#define kWaitTime 60
@interface ASHMinePhoneViewController (){
    NSDate *beginTime;
    NSTimer *_timer;
    //    NSInteger isec;
//    NSString *_yzm;//
    
    NSInteger _loginType; //0 验证码  1 密码
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

//@property (weak, nonatomic) IBOutlet UITextField *nameTF;
//@property (weak, nonatomic) IBOutlet UITextField *areaTF;
//@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
//@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;
@property (weak, nonatomic) IBOutlet UIButton *mmBtn;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property(nonatomic,assign)NSInteger selectCellNum;

@end

@implementation ASHMinePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一种
    
//    UIColor *color = MOMRGBColor(109, 109, 109);
//    _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: color}];
//    
////    color = [UIColor whiteColor];
//    _codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: color}];
    
    //第二种
//    [_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

//- (IBAction)showYZMLogin:(UIButton *)sender {
////    if(1==_loginType){
////        _codeBtn.hidden = YES;
////    }else{
//        _codeBtn.hidden = NO;
////    }
//    sender.selected = NO;
//    _mmBtn.selected = YES;
//    CGPoint centerP =  _lineLabel.center;
//    centerP.x = sender.center.x;
//    _lineLabel.center = centerP;
//    _selectCellNum = 0;
//}
//
//- (IBAction)showMMLogin:(UIButton *)sender {
//    _codeBtn.hidden = YES;
//    sender.selected = NO;
//    _yzmBtn.selected = YES;
//    CGPoint centerP =  _lineLabel.center;
//    centerP.x = sender.center.x;
//    _lineLabel.center = centerP;
//    _selectCellNum = 1;
//}
//
//- (IBAction)sengdCode:(UIButton *)sender {
////    NSString *code =  self.codeTF.text;
//    NSString *phone =  self.phoneTF.text;
////    NSString *inviteCode = self.inviteTF.text;
//    //    if (code&&![@"" isEqualToString:code]&&phone&&![@"" isEqualToString:phone]) {
//    
//    if (!phone||[@"" isEqualToString:phone]) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                        message:@"请完整填写手机号码"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//    }else{
//        sender.enabled = NO;
//        if (!_timer) {
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCode:) userInfo:nil repeats:YES];
//            //        [_timer fire];
//            [_timer setFireDate:[NSDate date]];
//            beginTime = [NSDate date];
//        }
//        
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo", nil];
//        [MOMNetWorking asynRequestByMethod:@"getauthcode" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
////            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret) {
//                 [MOMProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
//            }else{
//                 [MOMProgressHUD showSuccessWithStatus:@"验证码发送失败"];
//            }
//        }];
//
//    }
//    
//}
//
//- (IBAction)savePhone:(id)sender {
//    NSString *code =  self.codeTF.text;
//    NSString *phone =  self.phoneTF.text;
//    if (!code||[@"" isEqualToString:code]) {
//        
//        if (1==_selectCellNum) {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"请填写密码"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        }else{
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"请填写验证码"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        }
//       
//    }else{
////        [ASHMainTempUser setPhoneNumber:phone];
////        _cell.detailTextLabel.text = phone;
////        [self.navigationController popViewControllerAnimated:YES];
//        
//        if (1==_selectCellNum) {
////            9. 手机号密码登陆
////            入口：/m/api/login
////            请求头：Content-Type: application/x-www-form-urlencoded
////            请求方法：post
////            上传参数：phoneNo=手机号 & password=密码
//            
//            NSString *md5Code = [self md5:code];
//            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",md5Code,@"password", nil];
//            [MOMNetWorking asynRequestByMethod:@"login" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                NSDictionary *dic = result;
//                if (MOMResultSuccess==ret) {
//            
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                    NSString *token =[dic objectForKey:@"token"];
//                    
//                    [ASHMainUser setAuthorization:token];
//                    
//                    
//                    //获取个人资料
//                    //                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",code,@"authCode", nil];
//                    [MOMNetWorking asynGETRequestByMethod:@"myinfo2" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//                        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                        NSDictionary *dic = result;
//                        if (MOMResultSuccess==ret) {
//                            //                [_timer setFireDate:[NSDate distantFuture]];
//                            //                _timer = nil;
//                            //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                            //                self.codeBtn.enabled = YES;
//                            //                        [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                            NSDictionary *dict =[dic objectForKey:@"user"];
////                            [ASHMainUser setPhoneNumber:[dict objectForKey:@"PHONE_NO"]];
////                            [ASHMainUser setNick:[dict objectForKey:@"REAL_NAME"]];
//////                            [ASHMainUser setNick:[dict objectForKey:@"NAME"]];
////                            [ASHMainUser setAreaName:[dict objectForKey:@"ADDRESS"]];
////                            [ASHMainUser setAge:[dict objectForKey:@"AGE"]];
////                            [ASHMainUser setSex:[dict objectForKey:@"SEX"]];
////
////                            [ASHMainUser setHead:[dict objectForKey:@"AVATAR_HREF"]];
////                            [self dismissViewControllerAnimated:YES completion:^{
////
////                            }];
//
//                        }else{
//                            [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                        }
//                    }];
//
//                }else{
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                }
//              
//            }];
//            
//            
//
//        }else if(0==_selectCellNum){
//            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",code,@"authCode", nil];
//            [MOMNetWorking asynRequestByMethod:@"register" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                NSDictionary *dic = result;
//                if (MOMResultSuccess==ret) {
//                    //                [_timer setFireDate:[NSDate distantFuture]];
//                    //                _timer = nil;
//                    //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                    //                self.codeBtn.enabled = YES;
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                    NSString *token =[dic objectForKey:@"token"];
//                    
//                    [ASHMainUser setAuthorization:token];
//                    
//                    
//                    //获取个人资料
//                    //                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",code,@"authCode", nil];
//                    [MOMNetWorking asynGETRequestByMethod:@"myinfo2" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//                        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                        NSDictionary *dic = result;
//                        if (MOMResultSuccess==ret) {
//                            //                [_timer setFireDate:[NSDate distantFuture]];
//                            //                _timer = nil;
//                            //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                            //                self.codeBtn.enabled = YES;
//                            //                        [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                            NSDictionary *dict =[dic objectForKey:@"user"];
//                            [ASHMainUser setPhoneNumber:[dict objectForKey:@"PHONE_NO"]];
//                            [ASHMainUser setNick:[dict objectForKey:@"REAL_NAME"]];
////                            [ASHMainUser setNick:[dict objectForKey:@"NAME"]];
//                            [ASHMainUser setAreaName:[dict objectForKey:@"ADDRESS"]];
//                            [ASHMainUser setAge:[dict objectForKey:@"AGE"]];
//                            [ASHMainUser setSex:[dict objectForKey:@"SEX"]];
//                            
//                            [ASHMainUser setHead:[dict objectForKey:@"AVATAR_HREF"]];
//                            [self dismissViewControllerAnimated:YES completion:^{
//                                
//                            }];
//                           
//                        }else{
//                            [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                        }
//                    }];
//                    
//                    //                _dataArr = [dic objectForKey:@"data"];
//                    //                [self.collectionView reloadData];
//                }else{
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                }
//                //            [self dismissViewControllerAnimated:YES completion:^{
//                //                
//                //            }];
//                //             [self.navigationController popViewControllerAnimated:YES];
//            }];
//            
//            [ASHMainTempUser setPhoneNumber:phone];
//            _cell.detailTextLabel.text = phone;
//            _cell.detailTextLabel.textColor = ![self checkNull:phone]?MOMRGBColor(73, 73, 73):MOMRGBColor(197, 197, 197);
//            [_cell.accessoryView removeFromSuperview];
//            _cell.accessoryView = nil;
//            _cell.accessoryType =UITableViewCellAccessoryNone;
//        }
//        
//       
//    }
//
//}
////上面那个改成登录了，cacacacac   这个是保存电话号码的，风险提示，改了号码，就是新号会和之前的已经存在的电话号码合并成一个，数据为新号码的
//- (IBAction)savePhone2:(id)sender {
//    NSString *code =  self.codeTF.text;
//    NSString *phone =  self.phoneTF.text;
//    if (!code||[@"" isEqualToString:code]) {
//        
//        if (1==_selectCellNum) {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"请填写密码"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        }else{
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"请填写验证码"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        
//    }else{
//        
//        NSString *name = [ASHMainUser nick];
//        NSString *address = [ASHMainUser areaName];
//        NSString *age = [ASHMainUser age];
//        NSString *sex = [ASHMainUser sex];
//        
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",
//                                code,@"authCode",
//                                name,@"NAME",
//                                name,@"REAL_NAME",
//                                address,@"ADDRESS",
//                                age,@"AGE",
//                                sex,@"SEX", nil];
//        
//            [MOMNetWorking asynRequestByMethod:@"saveMyInfo" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret) {
//                [self.navigationController popViewControllerAnimated:YES];
//                _cell.detailTextLabel.text = phone;
////                _cell.detailTextLabel.textColor = ![self checkNull:phone]?MOMRGBColor(73, 73, 73):MOMRGBColor(197, 197, 197);
////                [_cell.accessoryView removeFromSuperview];
////                _cell.accessoryView = nil;
////                _cell.accessoryType =UITableViewCellAccessoryNone;
//            }else{
//                [MOMProgressHUD showSuccessWithStatus:@"修改失败"];
//            }
//        }];
//    }
//}
//
//
//-(void)updateCode:(NSTimer *)sender
//{
//    //    NSLog(@"updateCode--------%ld",isec);
//    //计算时间差
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    unsigned int unitFlags = NSCalendarUnitSecond;//NSMinuteCalendarUnit;//NSHourCalendarUnit;//年、月、日、时、分、秒、周等等都可以
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:beginTime toDate:[NSDate date] options:0];
//    NSInteger sec = [comps second];//时间差
//    
//    //            if (-1>=_sec) {
//    if (-1>=(kWaitTime-sec)) {
//        //             _sec=WaitTime;
//        //        [[[UIAlertView alloc]initWithTitle:@"" message:MyLocalizedString(@"验证码等待超时") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//        NSLog(@"period canel");
//        //                dispatch_suspend(timer);
//        [_timer setFireDate:[NSDate distantFuture]];
//        _timer = nil;
//        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.codeBtn.enabled = YES;
//    }else{
//        NSLog(@"__________________________sec:%ld",sec);
//        //                [_vetifyBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_sec--] forState:UIControlStateNormal];
//        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)kWaitTime-sec] forState:UIControlStateNormal];
//        
//    }
//    /*
//     [_rightBtn setTitle:[NSString stringWithFormat:@"%ld",isec] forState:UIControlStateNormal];
//     isec--;
//     if (isec<0) {
//     [_timer invalidate];
//     _timer = nil;
//     [_rightBtn setTitle:@"发送" forState:UIControlStateNormal];
//     isec = kWaitTime;
//     self.rightBtn.enabled = YES;
//     }*/
//}
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
//
//-(BOOL)checkNull:(NSString *)str
//{
//    if (str&&![@"" isEqualToString:str]) {
//        return YES;
//    }
//    return NO;
//}
//
//
//
//- (IBAction)loginSina:(id)sender {
//    [self getAuthWithUserInfoFromSina];
//}
//- (IBAction)loginWeiXin:(id)sender {
//    [self getAuthWithUserInfoFromWechat];
//}
//- (IBAction)loginQQ:(id)sender {
//    [self getAuthWithUserInfoFromQQ];
//}
//- (void)getAuthWithUserInfoFromSina
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            
//            // 授权信息
//            NSLog(@"Sina uid: %@", resp.uid);//2007034183
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.gender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
//            
//            
//            [self doLoginWithParams:resp];
//        }
//    }];
//}
//
//- (void)getAuthWithUserInfoFromQQ
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            
//            // 授权信息
//            NSLog(@"QQ uid: %@", resp.uid);
//            NSLog(@"QQ openid: %@", resp.openid);
//            NSLog(@"QQ accessToken: %@", resp.accessToken);
//            NSLog(@"QQ expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"QQ name: %@", resp.name);
//            NSLog(@"QQ iconurl: %@", resp.iconurl);
//            NSLog(@"QQ gender: %@", resp.gender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
//            
//            [self doLoginWithParams:resp];
//        }
//    }];
//}
//
//- (void)getAuthWithUserInfoFromWechat
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            
//            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.gender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
//            [self doLoginWithParams:resp];
//        }
//    }];
//}
//-(void)doLoginWithParams:(UMSocialUserInfoResponse *)resp
//{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:resp.uid,@"loginId",resp.iconurl,@"avatarHref",@1,@"sex",resp.name,@"realName", nil];
////    NSString *uid = resp.uid;
////    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"11122",@"loginId",@"logo",@"avatarHref",@1,@"sex",@"cc",@"realName", nil];
//    
////    oginId=第三方ID号 & avatarHref=头像完整URL & sex=性别（1：男，0：女） & realName=姓名
//    [MOMProgressHUD show];
//    
//    [MOMNetWorking asynRequestByMethod:@"login2" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        [MOMProgressHUD dismiss];
//        if (MOMResultSuccess==ret) {
////            BOOL isCollected= [[dic objectForKey:@"data"]boolValue];//"data":false  //false：用户未曾登陆过，接下来显示个人资料。true：用户以前登陆过。
//            NSString *nick = resp.name;
//            
//            
//            [ASHMainUser cleanInfo];
//            [ASHMainUser setUserId:resp.uid];
//            [ASHMainUser setNick:nick];
//            [ASHMainUser setSex:resp.unionGender];
//            [ASHMainUser setHead:resp.iconurl];
//            NSString *token =[dic objectForKey:@"token"];
//            
//            [ASHMainUser setAuthorization:token];
//            
//            //获取个人资料
//            //                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",code,@"authCode", nil];
//            [MOMNetWorking asynGETRequestByMethod:@"myinfo2" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                NSDictionary *dic = result;
//                if (MOMResultSuccess==ret) {
//                    //                [_timer setFireDate:[NSDate distantFuture]];
//                    //                _timer = nil;
//                    //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                    //                self.codeBtn.enabled = YES;
//                    //                        [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                    NSDictionary *dict =[dic objectForKey:@"user"];
//                    [ASHMainUser setPhoneNumber:[dict objectForKey:@"PHONE_NO"]];
//                    [ASHMainUser setNick:[dict objectForKey:@"REAL_NAME"]];
////                    [ASHMainUser setNick:[dict objectForKey:@"NAME"]];
//                    [ASHMainUser setAreaName:[dict objectForKey:@"ADDRESS"]];
//                    [ASHMainUser setAge:[dict objectForKey:@"AGE"]];
//                    [ASHMainUser setSex:[dict objectForKey:@"SEX"]];
//                    
////                    [ASHMainUser setHead:[dict objectForKey:@"AVATAR_HREF"]];
//                    [self dismissViewControllerAnimated:YES completion:^{
//                        
//                    }];
//                    //                        {
//                    //                            "PROJECT_ID" = "";
//                    //                            statusCode = 0;
//                    //                            user =     {
//                    //                                ADDRESS = 44;
//                    //                                AGE = "60\U540e";
//                    //                                NAME = 33;
//                    //                                "PHONE_NO" = 18502277078;
//                    //                                "REAL_NAME" = "ChenTao\U9648";
//                    //                                SEX = "\U7537";
//                    //                            };
//                    //                        }
//                }else{
//                    [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                }
//            }];
////            [self dismissViewControllerAnimated:YES completion:^{
////                
////            }];
////            NSDictionary *dict =[dic objectForKey:@"user"];
////            [ASHMainUser setPhoneNumber:[dict objectForKey:@"PHONE_NO"]];
////            [ASHMainUser setNick:[dict objectForKey:@"REAL_NAME"]];
////            [ASHMainUser setAreaName:[dict objectForKey:@"ADDRESS"]];
////            [ASHMainUser setAge:[dict objectForKey:@"AGE"]];
////            [ASHMainUser setSex:[dict objectForKey:@"SEX"]];
////            
////            [ASHMainUser setHead:[dict objectForKey:@"AVATAR_HREF"]];
//            
////            if (0==_states) {
////                [self dismissViewControllerAnimated:YES completion:^{
////
////                }];
////            }else{
////                ASHMineUserInfoController *mineUserInfoController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineUserInfoController"];
////
////                //                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mineUserInfoController];
////                //                        navi.navigationBar.hidden = YES;
////                //        [self presentViewController:navi animated:YES completion:^{
////                //
////                //        }];
////                [self.navigationController pushViewController:mineUserInfoController animated:YES];
////            }
//            
//        }
//    }];
//}
//
//-(void)userInfo{
//    NSDictionary *params = @{@"userId":[ASHMainUser userId]};
//    [MOMNetWorking asynRequestByMethod:@"user_detail" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
//            NSInteger watchNum =  [[result objectForKey:@"watched"]integerValue];
//            
//            [ASHMainUser setWatchedNum:watchNum];
//            
//            [ASHMainUser setPhoneNumber:[dic objectForKey:@"PHONE"]];
//            [ASHMainUser setAge:[dic objectForKey:@"BIRTHDATE"]];
//            [ASHMainUser setAreaName:[dic objectForKey:@"CITY"]];
//            [ASHMainUser setCompany:[dic objectForKey:@"COMPANY"]];
//            [ASHMainUser setPost:[dic objectForKey:@"COMPANY"]];
//            //            "USER_ID":"123",
//            //            "REAL_NAME":"李刚",
//            //            "PHONE":"18622567903",
//            //            "GENDER":"男",
//            //            "BIRTHDATE":"1980-05-12",
//            //            "CITY":"上海",
//            //            "COMPANY":"国贸大厦",
//            //            "TITLE":"销售总监",
//            //            "AVATAR_HREF":"http://ip:80/avatar/123.jpg",  // 头像URL
//            //            "LOGIN_TIME":"2017-04-23 21:37:57",
//            //            "REMOTE_ADDRESS":"127.0.0.1",
//            //            "LOGOUT_TIME":"2017-04-23 21:38:50",
//            //            "IF_USING":"否"
//            
//            //            _dataArr = [dic objectForKey:@"data"];
//            //            [self.tableView reloadData];
//            //            [self dismissViewControllerAnimated:YES completion:^{
//            //
//            //            }];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//}
//- (IBAction)goBack:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
//
//-(void)doSave
//{
//    
//    NSDictionary *params = @{@"userId":[ASHMainUser userId],
//                             @"realName":[ASHMainTempUser nick],
//                             @"phone":[ASHMainTempUser getPhoneNumber],
//                             @"gender":[ASHMainTempUser sex],
//                             @"birthdate":[ASHMainTempUser age],
//                             @"city":[ASHMainTempUser areaName],
//                             @"company":[ASHMainTempUser company],
//                             @"title":[ASHMainTempUser post]};
//    //    method=update_user_detail
//    //    userId=用户ID
//    //    realName=昵称（可以是汉字）
//    //    phone=电话号码
//    //    gender=性别（汉字，男或女）
//    //    birthdate=出生日期（格式：yyyy-MM-dd）
//    //    city=城市（可以是汉字）
//    //    company=公司（可以是汉字）
//    //    title=职位（可以是汉字）
//    
//    [MOMNetWorking asynRequestByMethod:@"update_user_detail" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
//            //            _dataArr = [dic objectForKey:@"data"];
//            //            [self.tableView reloadData];
//            //            [self dismissViewControllerAnimated:YES completion:^{
//            //
//            //            }];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//}
//
//- (NSString *)md5:(NSString *)key {
//    const char *str = [key UTF8String];
//    if (str == NULL) {
//        str = "";
//    }
//    unsigned char r[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, (CC_LONG)strlen(str), r);
//    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
//                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
//                          r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];
//    
//    return filename;
//}
//- (IBAction)tyxy:(id)sender {
//    
//}
//- (IBAction)fwxy:(id)sender {
//    
//    
//    
//    UIViewController *ctl = [[UIViewController alloc]init];
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:MOMScreenBounds];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chouduck.com/%E7%AD%B9%E5%B0%8F%E9%B8%AD-%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE.htm"]]];
//    
//    [ctl.view addSubview:webView];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:ctl];
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(doDismiss)];
//    ctl.navigationItem.leftBarButtonItem = backBtn;
//    [self presentViewController:navi animated:YES completion:^{
//        
//    }];
//}
//- (IBAction)ysxy:(id)sender {
//    UIViewController *ctl = [[UIViewController alloc]init];
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:MOMScreenBounds];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chouduck.com/%E7%AD%B9%E5%B0%8F%E9%B8%AD-%E9%9A%90%E7%A7%81%E6%9D%A1%E6%AC%BE.htm"]]];
//    
//    [ctl.view addSubview:webView];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:ctl];
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(doDismiss)];
//    ctl.navigationItem.leftBarButtonItem = backBtn;
//    [self presentViewController:navi animated:YES completion:^{
//        
//    }];
//}
//
//-(void)doDismiss
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
