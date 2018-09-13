//
//  AppDelegate.m
//  AsHacker
//
//  Created by 陈涛 on 2017/3/20. ----=== 00
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "AppDelegate.h"

#import "JWPlayer.h"
#import <UMSocialCore/UMSocialCore.h>
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
#import "WXApi.h"
#import "WXApiManager.h"
//

#import <AlipaySDK/AlipaySDK.h>
////新浪微博SDK头文件
//#import "WeiboSDK.h"
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
@interface AppDelegate ()
@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [ASHMainUser cleanInfo];
    
    [[UINavigationBar appearance]setTintColor:MOMLightGrayColor];
    //向微信注册wxd930ea5d5a258f4f
//    [WXApi registerApp:@"wx228db45a4d95ff91"]; // chouduck
      [WXApi registerApp:WX_APPID]; // cps
    
//    去掉 back
    UIOffset offset;
    offset.horizontal = -500;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58f6d41df29d98355d002800"];
//     [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a018499f43e485273000057"];
    
    
//    [self configUSharePlatforms];
//
//    [self confitUShareSettings];

    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
    
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付跳转支付宝钱包进行支付，处理支付结果 result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"授权跳转支付宝钱包进行支付，处理支付结果 result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }

    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    /*
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"跳转支付宝钱包进行支付，处理支付结果 result = %@",resultDic);
            }];
        }
//        else{
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:FIRST_STORYBOARD bundle:nil];
////        ASHFirstDetailTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
////        ctl.dataDic = _dataArr[index];
//        //    ctl.projectData = _dataArr[indexPath.row];
//        ASHSupportPrePayTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHSupportPrePayTableViewController"];
        
        //            ASHSupportPrePayViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHSupportPrePayViewController"];
//        ctl.dataDic = result;
//        ctl.comment = text;
//        ctl.title = [_dataDic objectForKey:@"TITLE"];
//        [self.navigationController pushViewController:ctl animated:YES];
//        [self.navigationController pushViewController:ctl animated:YES];
        
        id ctl = [((UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController visibleViewController];
            return  [WXApi handleOpenURL:url delegate:ctl];
//        }
     
     
//        return YES;
    }
     */
    id ctl = [((UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController visibleViewController];
    return  [WXApi handleOpenURL:url delegate:ctl];
//    return YES;
    
   
}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
//    [UMSocialSnsService  applicationDidBecomeActive];
    
//    [[UMSocialManager defaultManager] applicationDidBecomeActive:application];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    //chouduck
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx228db45a4d95ff91" appSecret:@"a01704c9110266fa212d848e5597395a" redirectURL:@"http://mobile.umeng.com/social"];
    //cps
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx43e0ca9ffb089215" appSecret:@"2b0e6d554249a4b35f194801bbc48ba7" redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106163758"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1431153700"  appSecret:@"b516979cf65e745b1047a97ae156550c" redirectURL:@"http://www.chouduck.com/"];
    
    
    
    
    /* 设置新浪的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2533533414"  appSecret:@"a1b68bc67ce1ce65336d6b1334b6e08d" redirectURL:@"http://www.mysuper6.com/"];
    
//     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3946668808"  appSecret:@"141ac516bce72d333f2623f5eb28cfc6" redirectURL:@"http://www.mysuper6.com"];
//
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1239706756"  appSecret:@"327bb58ace3963daa9b0ca1789a003bf" redirectURL:@"http://www.chouduck.com"];
   
    
    
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
     NSLog(@"微信SDK自带的方法-----------------2-");
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}

//作者：WangK_Dev
//链接：http://www.jianshu.com/p/1c1c834b6d52
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

@end
