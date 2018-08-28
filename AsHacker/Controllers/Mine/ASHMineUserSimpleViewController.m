//
//  ASHMineUserSimpleViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/8.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineUserSimpleViewController.h"
#define kWaitTime 60
@interface ASHMineUserSimpleViewController (){
    NSDate *beginTime;
    NSTimer *_timer;
    //    NSInteger isec;
    NSString *_yzm;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@end

@implementation ASHMineUserSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *dic = _dataDic;
//    if (_dataDic) {
//        _phoneTF.text = [ASHMainUser getPhoneNumber];
//        _nameTF.text = [ASHMainUser nick];
//        _areaTF.text = [ASHMainUser areaName];
////        [_ageBtn setTitle:[ASHMainUser age] forState:UIControlStateNormal];
////        [_sexBtn setTitle:[ASHMainUser sex] forState:UIControlStateNormal];
//        
//    }
}

//- (IBAction)savePhone:(id)sender {
//    
//   
//    NSString *code =  self.codeTF.text;
//    NSString *phone =  self.phoneTF.text;
//    
//    NSString *name =  self.nameTF.text;
//    NSString *address =  self.areaTF.text;
//    
//    NSString *age =  self.ageBtn.titleLabel.text;
//    NSString *sex =  self.sexBtn.titleLabel.text;
//    
//    //    NSString *inviteCode = self.inviteTF.text;
//    //    if (code&&![@"" isEqualToString:code]&&phone&&![@"" isEqualToString:phone]) {
//    //
//    //            [ASHMainTempUser setPhoneNumber:phone];
//    //            _cell.detailTextLabel.text = phone;
//    //            _cell.detailTextLabel.textColor = ![self checkNull:_detailTF.text]?MOMRGBColor(73, 73, 73):MOMRGBColor(197, 197, 197);
//    //            [_cell.accessoryView removeFromSuperview];
//    //            _cell.accessoryView = nil;
//    //            _cell.accessoryType =UITableViewCellAccessoryNone;
//    //            [self.navigationController popViewControllerAnimated:YES];
//    
//    
//    if (!code||[@"" isEqualToString:code]) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                        message:@"请填写验证码"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
////    }else if ([self checkNull:phone]&&[self checkNull:name]&&[self checkNull:address]&&[self checkNull:age]&&[self checkNull:sex]&&![@"年龄" isEqualToString:age]&&![@"性别" isEqualToString:sex]){
//        }else if ([self checkNull:phone]&&[self checkNull:age]&&[self checkNull:sex]&&![@"年龄" isEqualToString:age]&&![@"性别" isEqualToString:sex]){
//        
////        20. 保存用户个人资料
////        入口：/m/api/saveMyInfo
////        请求头：Content-Type: application/x-www-form-urlencoded
////        authorization，同4
////        请求方法：post
////        上传参数：phoneNo=手机号 & authCode=短信验证码 & NAME=姓名 & ADDRESS=收货地址 & AGE=年龄 & SEX=性别 & PROJECT_ID=项目ID（项目ID用于成为志愿者时，上送要成为哪个项目的志愿者，如果不带这个参数，表示单纯修改个人资料）
////http://www.chouduck.com/m/api/saveMyInfo?AGE=80后&NAME=as hacker&ADDRESS=theysss 淡淡的&phoneNo=18502277078&SEX=女&authCode=4742
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",
//                                code,@"authCode",
//                                name,@"NAME",
//                                address,@"ADDRESS",
//                                age,@"AGE",
//                                sex,@"SEX", nil];
//        
//        if (_projectId&&![@"" isEqualToString:_projectId]) {
//            params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",
//                                    code,@"authCode",
//                                    name,@"NAME",
//                                    address,@"ADDRESS",
//                                    age,@"AGE",
//                                    sex,@"SEX",
//                                    _projectId,@"PROJECT_ID",nil];
//        }
//        [MOMNetWorking asynRequestByMethod:@"saveMyInfo" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret||3==ret) {
//                //                [_timer setFireDate:[NSDate distantFuture]];
//                //                _timer = nil;
//                //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                //                self.codeBtn.enabled = YES;
//                [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                NSString *token =[dic objectForKey:@"token"];
//                if([self checkNull:token]){
//                    [ASHMainUser setAuthorization:token];
//                }
//                
//                
//                
//                //获取个人资料
//                //                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",code,@"authCode", nil];
//                [MOMNetWorking asynGETRequestByMethod:@"myinfo2" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//                    NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                    NSDictionary *dic = result;
//                    if (MOMResultSuccess==ret) {
//                        //                [_timer setFireDate:[NSDate distantFuture]];
//                        //                _timer = nil;
//                        //                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                        //                self.codeBtn.enabled = YES;
//                        //                        [MOMProgressHUD showSuccessWithStatus:@"登陆成功"];
//                        NSDictionary *dict =[dic objectForKey:@"user"];
//                        [ASHMainUser setPhoneNumber:[dict objectForKey:@"PHONE_NO"]];
//                        [ASHMainUser setNick:[dict objectForKey:@"REAL_NAME"]];
////                        [ASHMainUser setNick:[dict objectForKey:@"NAME"]];
//                        [ASHMainUser setAreaName:[dict objectForKey:@"ADDRESS"]];
//                        [ASHMainUser setAge:[dict objectForKey:@"AGE"]];
//                        [ASHMainUser setSex:[dict objectForKey:@"SEX"]];
//                        
//                        [ASHMainUser setHead:[dict objectForKey:@"AVATAR_HREF"]];
//                        [self dismissViewControllerAnimated:YES completion:^{
//                            if ([_delegate respondsToSelector:@selector(doJoin:)]) {
//                                [_delegate performSelector:@selector(doJoin:) withObject:nil];
//                            }
//                            
//                        }];
////                        [self.navigationController popViewControllerAnimated:YES];
//                    }else{
//                        [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//                    }
//                }];
//            }else{
//                [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
//            }
//        }];
//        
////        [ASHMainTempUser setPhoneNumber:phone]; 
//    }else{
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
//                                                        message:@"请完整填写个人信息"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    
//    
//    
//
//    
//}
//
//- (IBAction)showAge:(UIButton *)sender {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"年龄" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    
//    //增加确定按钮；
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"00后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//       
//        [sender setTitle:action.title forState:UIControlStateNormal];
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"90后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [sender setTitle:action.title forState:UIControlStateNormal];
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"80后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [sender setTitle:action.title forState:UIControlStateNormal];
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"70后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [sender setTitle:action.title forState:UIControlStateNormal];
//        
//    }]];
//    //增加取消按钮；
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    
//    [self presentViewController:alertController animated:true completion:nil];
//    
//
//    
//}
//
//- (IBAction)showSex:(UIButton *)sender {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    
//    //增加确定按钮；
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [sender setTitle:action.title forState:UIControlStateNormal];
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [sender setTitle:action.title forState:UIControlStateNormal];
//        
//    }]];
//    //增加取消按钮；
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [self presentViewController:alertController animated:true completion:nil];
//    
//
//}
//
//
//- (IBAction)sengdCode:(UIButton *)sender {
////    NSString *code =  self.codeTF.text;
//    NSString *phone =  self.phoneTF.text;
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
//            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret) {
//                [MOMProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
//            }else{
//                [MOMProgressHUD showSuccessWithStatus:@"验证码发送失败"];
//            }
//        }];
//        
//    }
//    
//}
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
//- (IBAction)goBack:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
