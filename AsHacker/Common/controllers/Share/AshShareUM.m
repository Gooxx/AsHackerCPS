//
//  AshShareUM.m
//  AsHacker
//
//  Created by 陈涛 on 2017/6/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "AshShareUM.h"

@implementation AshShareUM


+(void)doShare{
    
    id wself =  [[super alloc]init];
    if (wself) {
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [wself shareWebPageToPlatformType:platformType];
        }];
    }
   
}

+(void)doShareWithTitle:(NSString *)title img:(NSString *)img detail:(NSString *)detail web:(NSString *)web{
    
    id wself =  [[super alloc]init];
    if (wself) {
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            //            [wself shareWebPageToPlatformType:platformType];
            [wself shareWebPageToPlatformType:platformType title:title img:img detail:detail web:web];
        }];
    }
    
}
-(void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType title:(NSString *)title img:(NSString *)img detail:(NSString *)detail web:(NSString *)web
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURLStr =  img?img:@"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    NSURL *thumbURL = [NSURL URLWithString:thumbURLStr];
    NSData *thumbURLData = [NSData dataWithContentsOfURL:thumbURL];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title?title:@"欢迎使用筹小鸭" descr:detail?detail:@"老司机带带我，自由的飞翔" thumImage:thumbURLData];
    //设置网页地址
    shareObject.webpageUrl = web?web:@"http://www.chouduck.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}


-(void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用筹小鸭" descr:@"老司机带带我，自由的飞翔" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.ashacker.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}
@end
