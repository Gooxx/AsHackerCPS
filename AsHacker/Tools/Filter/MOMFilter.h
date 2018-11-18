//
//  MOMFilter.h
//  LivingArea
//
//  Created by goooo on 15/12/23.
//  Copyright © 2015年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//#import "MOMCurrentUser.h"
#import "Config.h"
//#import "TLCityPickerController.h" 

#import "ASHLoginViewController.h"
typedef NS_ENUM(NSInteger,MOMFilters) {
    MOMFilterNone=0,
    MOMFilterUnLogin =1<<0,
    MOMFilterUnSession =1<<1,
    MOMFilterUnArea =1<<2
};

@interface MOMFilter : NSObject
@property(nonatomic,strong)id weakSelf;
+(void)filters:(MOMFilters)filter;

//+(void)filters:(MOMFilters)filter callback:()
+(void)registerFliterIn:(id)target;
//是否已经登录
+(BOOL)filterLogin;

+(BOOL)filterLoginCallback:(void(^)(BOOL b))block;


//是否已经选择了小区
+(BOOL)filterArea;

+(BOOL)filterAreaCallback:(void(^)(BOOL b))block;

//过滤结果中  9  重登陆
+(BOOL)filterResult:(id)result;

//获取当前的controller
+(UIViewController *)getCurrentVC;

@end
