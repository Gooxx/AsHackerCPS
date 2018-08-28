//
//  ASHUserLoginViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/11.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHUserLoginViewController.h"

@interface ASHUserLoginViewController ()

@end

@implementation ASHUserLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
   
}

//- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
//        
//        UMSocialUserInfoResponse *resp = result;
//        
//        // 第三方登录数据(为空表示平台未提供)
//        // 授权数据
//        NSLog(@" uid: %@", resp.uid);
//        NSLog(@" openid: %@", resp.openid);
//        NSLog(@" accessToken: %@", resp.accessToken);
//        NSLog(@" refreshToken: %@", resp.refreshToken);
//        NSLog(@" expiration: %@", resp.expiration);
//        
//        // 用户数据
//        NSLog(@" name: %@", resp.name);
//        NSLog(@" iconurl: %@", resp.iconurl);
//        NSLog(@" gender: %@", resp.gender);
//        
//        // 第三方平台SDK原始数据
//        NSLog(@" originalResponse: %@", resp.originalResponse);
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:resp.uid,@"userId", nil];
//        
//        [MOMNetWorking asynRequestByMethod:@"login" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret) {
////                BOOL isCollected= [[dic objectForKey:@"data"]boolValue];//"data":false  //false：用户未曾登陆过，接下来显示个人资料。true：用户以前登陆过。
//            }
//        }];
//    }];
//}
//- (IBAction)loginSuper:(id)sender {
//    
//    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
//    NSString *userId = [NSString stringWithFormat:@"%ld",time];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId", nil];
//    [MOMProgressHUD show];
//    
//    [MOMNetWorking asynRequestByMethod:@"login" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        [MOMProgressHUD dismiss];
//        if (MOMResultSuccess==ret) {
////            BOOL isCollected= [[dic objectForKey:@"data"]boolValue];//"data":false  //false：用户未曾登陆过，接下来显示个人资料。true：用户以前登陆过。
//            NSString *nick = [NSString stringWithFormat:@"游客%@",userId];
//            
//            [ASHMainUser cleanInfo];
//            [ASHMainUser setUserId:userId];
//            [ASHMainUser setNick:nick];
//            [ASHMainUser setSex:@"男"];
//            [ASHMainUser setHead:nil];
//            
//            
//            
//            
//            if (0==_states) {
//                [self dismissViewControllerAnimated:YES completion:^{
//                    
//                }];
//            }else{
//                ASHMineUserInfoController *mineUserInfoController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineUserInfoController"];
//                
//                //                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mineUserInfoController];
//                //                        navi.navigationBar.hidden = YES;
//                //        [self presentViewController:navi animated:YES completion:^{
//                //
//                //        }];
//                [self.navigationController pushViewController:mineUserInfoController animated:YES];
//            }
//            
//        }
//    }];
//}
//- (IBAction)loginSinaWB:(id)sender {
//     [self getAuthWithUserInfoFromSina];
//}
//- (IBAction)loginSina:(id)sender {
//    [self getAuthWithUserInfoFromSina];
//}
//- (IBAction)loginWX:(id)sender {
//    [self getAuthWithUserInfoFromWechat];
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
//           [self doLoginWithParams:resp];
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
//                       [self doLoginWithParams:resp];
//        }
//    }];
//}
//-(void)doLoginWithParams:(UMSocialUserInfoResponse *)resp
//{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:resp.uid,@"userId", nil];
//    [MOMProgressHUD show];
//
//    [MOMNetWorking asynRequestByMethod:@"login" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
////        NSDictionary *dic = result;
//         [MOMProgressHUD dismiss];
//        if (MOMResultSuccess==ret) {
////            BOOL isCollected= [[dic objectForKey:@"data"]boolValue];//"data":false  //false：用户未曾登陆过，接下来显示个人资料。true：用户以前登陆过。
//            NSString *nick = resp.name;
//            
//            [ASHMainUser cleanInfo];
//            [ASHMainUser setUserId:resp.uid];
//            [ASHMainUser setNick:nick];
//            [ASHMainUser setSex:resp.unionGender];
//            [ASHMainUser setHead:resp.iconurl];
//            
//            
//        
//
//            if (0==_states) {
//                [self dismissViewControllerAnimated:YES completion:^{
//                    
//                }];
//            }else{
//                ASHMineUserInfoController *mineUserInfoController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineUserInfoController"];
//                
////                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mineUserInfoController];
////                        navi.navigationBar.hidden = YES;
//                //        [self presentViewController:navi animated:YES completion:^{
//                //            
//                //        }];
//                [self.navigationController pushViewController:mineUserInfoController animated:YES];
//            }
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
////            "USER_ID":"123",
////            "REAL_NAME":"李刚",
////            "PHONE":"18622567903",
////            "GENDER":"男",
////            "BIRTHDATE":"1980-05-12",
////            "CITY":"上海",
////            "COMPANY":"国贸大厦",
////            "TITLE":"销售总监",
////            "AVATAR_HREF":"http://ip:80/avatar/123.jpg",  // 头像URL
////            "LOGIN_TIME":"2017-04-23 21:37:57",
////            "REMOTE_ADDRESS":"127.0.0.1",
////            "LOGOUT_TIME":"2017-04-23 21:38:50",
////            "IF_USING":"否"
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
