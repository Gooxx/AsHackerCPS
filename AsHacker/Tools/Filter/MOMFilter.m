//
//  MOMFilter.m
//  LivingArea
//
//  Created by goooo on 15/12/23.
//  Copyright © 2015年 mom. All rights reserved.
//

#import "MOMFilter.h"
NSString *kFilterChangedNotification = @"kFilterChangedNotification";
@implementation MOMFilter


+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static MOMFilter *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MOMFilter alloc] init];
    });
    return sharedInstance;
}
+(void)registerFliterIn:(id)target
{
     [[self sharedInstance] registerSelfFliterIn:target];
//    return self;
}
-(void)registerSelfFliterIn:(id)target
{
    __weak typeof(target) wearTarget = target;
    self.weakSelf = wearTarget;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(filterTrigger:)
//                                                 name: kFilterChangedNotification
//                                               object: nil];
    
}

+(void)filters:(MOMFilters)filter
{
    if (filter&MOMFilterUnLogin) {
        [self filterLogin];
    }
}

//no 代表拦住了；  yes 代表有这个userId
+(BOOL)filterLogin
{
    return  [self filterLoginCallback:^(BOOL b) {
        if (!b) {
            [[self sharedInstance] filterTrigger];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kFilterChangedNotification object:@"9"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kFilterChangedNotification object:@"9" userInfo:@{@"key":@9}];
            
            
//            UIStoryboard *story = [UIStoryboard storyboardWithName:USER_STORYBOARD bundle:nil];
//            UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:Main_NAVI];
//            UIViewController *viewCtl = [self getCurrentVC];
//            [viewCtl presentViewController:mainTVController animated:YES completion:^{
//                
//            }];
            /*
            UIViewController *viewCtl = [self getCurrentVC];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"登陆失效，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //            UIStoryboard *story = [UIStoryboard storyboardWithName:USER_STORYBOARD bundle:nil];
                //            UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:Main_NAVI];
                //            UIViewController *viewCtl = [self getCurrentVC];
                //            [viewCtl presentViewController:mainTVController animated:YES completion:^{
                //
                //            }];
            }];
            UIAlertAction *reLogin = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:USER_STORYBOARD bundle:nil];
                UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:Main_NAVI];
                //                            UIViewController *viewCtl = [self getCurrentVC];
                [viewCtl presentViewController:mainTVController animated:YES completion:^{
                    
                }];
            }];
            
            [alert addAction:cancel];
            [alert addAction:reLogin];
            [viewCtl presentViewController:alert animated:YES completion:^{
                
            }];
             
             */
            /**/
//            UIViewController *viewCtl = [self getCurrentVC];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注意" message:@"登陆失效，请重新登录" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
//            [alert show];
            
            
            
            /*
            UIViewController *viewCtl = [self getCurrentVC];
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
//            [cityPickerVC setDelegate:cityPickerVC];
            
            cityPickerVC.locationCityID =  [MOMCurrentUser areaId];
            //    cityPickerVC.locationCityID = @"1400010000";
            //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
            //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            //    [self.navigationController pushViewController:cityPickerVC animated:YES];
            
            [viewCtl presentViewController:cityPickerVC animated:YES completion:^{
                
            }];
              */
        }
        
    }];
//    NSString *userId = [MOMCurrentUser userId];
//    if (!userId||[@"" isEqualToString:userId]) {
//        UIStoryboard *story = [UIStoryboard storyboardWithName:USER_STORYBOARD bundle:nil];
//        UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:@"mainNavi"];
//        
//        
//        
//        [[self getCurrentVC] presentViewController:mainTVController animated:YES completion:^{
//            
//        }];
//        
//        return YES;
//    }
//    return  NO;
    
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    //    UIViewController *mainTVController = [storyboard instantiateViewControllerWithIdentifier:Main_CTL];
    
}

//+(BOOL)filterLoginCallback:(void(^)(BOOL b))block
//{
//    NSString *userId = [MOMCurrentUser userId];
//    if (!userId||[@"" isEqualToString:userId]) {
//
//        block(NO);
//        return NO;
//    }
//    block(YES);
//    return  YES;
//}
+(BOOL)filterArea
{
    return  [self filterAreaCallback:^(BOOL b) {
        if (!b) {
            [[self sharedInstance] filterAreaTrigger];
        }
    }];
}
//+(BOOL)filterAreaCallback:(void(^)(BOOL b))block
//{
//    NSString *areaId = [MOMCurrentUser observeAreaId];
//    BOOL bo = areaId&&![@"" isEqualToString:areaId];
//    block(bo);
//    return bo;
//}

+(BOOL)filterResult:(id)result
{
    if (result) {
        NSDictionary *dic = result;
        NSString *retStr = [dic objectForKey:@"ret"];
        MOMResult ret = [retStr integerValue];
//        if (MOMResultReLogin==ret||MOMResultNOLogin==ret) {
        if (MOMResultNOLogin==ret) {
            [[self sharedInstance] filterTrigger];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kFilterChangedNotification object:@"9"];
        }else if(MOMResultSuccess==ret){
            return YES;
        }
    }
    return NO;
}


//+(UIViewController *)getCurrentVC
//{
//    UIViewController *result = nil;
//    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//    
//    return result;
//}
-(void)filterAreaTrigger{
//    UIViewController *viewCtl = self.weakSelf;
//    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
//    //            [cityPickerVC setDelegate:cityPickerVC];
//    
//    cityPickerVC.locationCityID =  [MOMCurrentUser areaId];
//    //    cityPickerVC.locationCityID = @"1400010000";
//    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
//    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
//    //    [self.navigationController pushViewController:cityPickerVC animated:YES];
//    
//    [viewCtl presentViewController:cityPickerVC animated:YES completion:^{
//        
//    }];

}

//拦截器执行
- (void)filterTrigger {
    UIViewController *viewCtl= self.weakSelf;
    if (viewCtl) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"登陆失效，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *reLogin = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *story = viewCtl.storyboard; //[UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
            
            UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:LOGIN_NAVI];
//            [viewCtl.navigationController pushViewController:mainTVController animated:YES];
//            UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:Main_NAVI];
            [viewCtl presentViewController:mainTVController animated:YES completion:^{
                
            }];
        }];
        
        [alert addAction:cancel];
        [alert addAction:reLogin];
        [viewCtl presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        UIStoryboard *story = [UIStoryboard storyboardWithName:USER_STORYBOARD bundle:nil];
        UIViewController *mainTVController = [story instantiateViewControllerWithIdentifier:Main_NAVI];
        UIViewController *viewCtl = [MOMFilter getCurrentVC];
        [viewCtl presentViewController:mainTVController animated:YES completion:^{

        }];
}


@end
