//
//  Config.h
//  LivingArea
//
//  Created by goooo on 15/9/21.
//  Copyright (c) 2015年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MOMUser;
//13612083424 111111
//测试用的，是否单机状态
#define LOCAL_DATA NO

//测试用的，是否使用模拟假定位/Users/chentao/Downloads/chen/dong/cpalace2/LivingArea/Classes/Config/Config.h
#define LOCAL_POSITION NO

//百度KEY
#define BDMAP_KEY @"9qKDpOu5raUrFYpPcbPWcbLCxI2yhlvN"//@"Ng0p83LNtyzqLy7Lzczc425w" //@"qEbSl9xFGXIp3v8nzrsEgmQk"

//shareSDK SMS KEY
#define shareSDK_KEY  @"cdfb21f29b81"
#define shareSDK_Secret  @"30d1fa366403c3e52df6b1a3516f5928"

//#define HTTPURL @"http://192.168.1.125:8080/livingCircle/app/"
//#define HTTPURL @"http://139.129.35.37:8080/livingCircle/app/"
//#define HTTPURL_IMG @"http://192.168.1.129:8080/livingCircle/upload"
//#define HTTPURL @"http://139.129.35.37/app/"
//#define HTTPURL_IMG @"http://139.129.35.37/upload"

//#define HTTPURL @"http://120.27.122.140:8080/app/"
//#define HTTPURL_IMG @"http://120.27.122.140:8080/upload"

//#define HTTPURL @"http://www.ashacker.com/skiing/app/"
//#define HTTPURL_IMG @"http://www.ashacker.com"

//#define HTTPURL @"http://221.238.104.60/"
//#define HTTPURL @"http://47.92.114.252/"

//#define HTTPURL @"http://47.92.127.237/"

//#define HTTPURL @"http://www.chouduck.com/"

//cps/app/cps/mainBbsById.do?id=2
//#define HTTPURL @"http://www.chouduck.com/m/api/"
//#define HTTPURLCDN @"http://resource.chouduck.com/"

//#define MainMethodName @"m/api/"

#define HTTPURL @"http://39.105.46.149:8080/"
#define MainMethodName @"cps/app/cps/"

#define HTTPURLCDN @"http://39.105.46.149:8080"

#define HTTPURL_IMG @"http://39.105.46.149:8080"

//#define HTTPURL_IMG @"http://www.ashacker.com/skiing/upload"


//#define JPUSH_APPKEY @"5824c3050cf8770ddbab6dd3"
// 需要填写为您自己的 JPush Appkey
#define JMSSAGE_APPKEY @"7c951f7135fa01e4969ebc3c"

// 微信 appid
#define WX_APPID @"wx43e0ca9ffb089215"
#define WX_APPSECRET @"2b0e6d554249a4b35f194801bbc48ba7"


//storyboard们
#define FIRST_STORYBOARD @"First"
#define MAIN_STORYBOARD @"Main"
#define STORY_STORYBOARD @"Story"
#define USER_STORYBOARD @"User"



#define MAP_STORYBOARD @"Map"
#define INFO_STORYBOARD @"Info"
#define MORE_STORYBOARD @"More"

//storyboard里的viewController
#define Main_CTL @"mainTVC"
#define Main_NAVI @"mainNavi"

#define My_NAVI @"myNavi"


#define BBS_NAVI  @"BBSNavi"
#define IM_NAVI  @"IMNavi"
#define DATA_NAVI  @"dataNavi"

#define DISCOVERY_NAVI  @"discoveryNavi"



#define MAP_NAVI  @"MapNavi"
#define INFO_NAVI  @"InfoNavi"
#define MORE_NAVI  @"MoreNavi"


#define BBS_VC @"BBSVC"
#define Map360_VC @"map360VC"
#define Weather_VC @"weatherVC"
#define RANK_VC @"rankVC"

#define RegisterOver_VC  @"registerOverVC"//注册

#define FindPwd_VC  @"findPwdVC"//找回密码
#define UpdatePwd_VC  @"updatePwdVC"//修改密码

#define EditUser_VC  @"editUserVC"//修改用户信息


#define Comment_View @"MOMCommentView"//回复视图



//持久化参数
#define UD_Logined  @"logined"

#define FORM_FLE_INPUT @"file"


//User Default
#define MOMUserDefaults [NSUserDefaults standardUserDefaults]

//日志
#define MMLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#ifdef DEBUG

#define NSSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSSLog(...)

#endif
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(...)

#endif
//屏幕bounds
#define MOMScreenBounds [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//国际化
#define MyLocalizedString(str) NSLocalizedStringFromTable(str,@"MyLocalizable", nil)
//颜色
#define MOMRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//#define MOMOrangeColor MOMRGBColor(240,126,11)
#define MOMOrangeColor MOMRGBColor(255,147,83)

#define MOMProgressOrangeColor MOMRGBColor(255,214,72)

#define MOMLightOrangeColor MOMRGBColor(255,214,72)

#define MOMLightGrayColor MOMRGBColor(148,148,148)
#define MOMWhiteGrayColor MOMRGBColor(233,233,233)

#define MOMDarkGrayColor MOMRGBColor(77,77,77)

//#define MOMMainNaviColor MOMRGBColor(48,55,77)

//TICK 和 TOCK 之间的时间
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
//struct GOOUser{
//    NSString *name;
//    NSString *password;
//};
//typedef struct GOOUser GOOUser;
//
//inline  GOOUser  GOOUserMake(NSString *name, NSString *password){
//    GOOUser user;
//    user.name = name;
//    user.password = password;
//    return user;
//}
//struct MOMUserModel{
//    NSString *name;
//    NSString *password;
//};
//typedef struct MOMUserModel MOMUserModel;
//1绑定成功
//2绑定失败
//3不是合法的手机号码
//4验证码不正确
//5该openId绑定的用户不存在
//0系统异常    String
//成功还是失败
typedef NS_ENUM(NSInteger, MOMResult) {
    
    MOMResultError=0,
    MOMResultSuccess=1,
    MOMResultFailure=2,
    
    MOMResultWrongPhone =3,
    MOMResultWrongCode = 4,
    MOMResultWrongWXOpenId = 5,
    
    MOMResultReLogin,
    MOMResultNOLogin = 400,
    MOMResultSuccess2 = 200
};
//性别
typedef NS_ENUM(NSInteger, MOMUserSex) {
    MOMUserSexMan=0,
    MOMUserSexWoMan,
    MOMUserSexBoth
};

//网络请求  公共参数
typedef NS_ENUM(NSInteger,MOMNetPublicParam) {
    MOMNetPublicParamNone=0,
    MOMNetPublicParamUserId = 1<<0,
    MOMNetPublicParamKey = 1<<1,
    MOMNetPublicParamAreaId = 1<<2,
    MOMNetPublicParamToken = 1<<3
};

///dong美术馆 音乐馆 科技馆
typedef NS_ENUM(NSInteger, MOMGalleryType) {
    MOMGalleryTypeUser = 0,
    MOMGalleryTypePicture=1,
    MOMGalleryTypeMusic,
    MOMGalleryTypeTechnology
};
////登录返回状态 TODO
//typedef NS_ENUM(NSInteger, MOMLoginResult) {
//    MOMLoginResultFailure=0,
//    MOMLoginResultSuccess
//};
//
////注册返回状态 TODO
//typedef NS_ENUM(NSInteger, MOMRegisterResult) {
//    MOMRegisterResultFailure=0,
//    MOMRegisterResultSuccess
//};

////自定义输入框的样式
//typedef NS_ENUM(NSInteger,MOMTextFieldType) {
//    MOMTextFieldTypeNormal=0,
//    MOMTextFieldTypeLeftUser = 1<<0,
//    MOMTextFieldTypeLeftPassword = 1<<1,
//    MOMTextFieldTypeLeftVerify = 1<<2,
//    MOMTextFieldTypeRightVerify = 1<<3,
//    MOMTextFieldTypeRightScan = 1<<4,
//    MOMTextFieldTypeLeftInvite = 1<<5
//};

////BBS不同模块话题
////Type:0 热门
////Type:1 闲聊
////Type:2 二手
////Type:3 求助
////Type:4 物业
//typedef NS_ENUM(NSInteger,MOMBBSType) {
//    MOMBBSTypeHot=0,
//    MOMBBSTypeNormal,
//    MOMBBSTypeShop,
//    MOMBBSTypeHelp,
//    MOMBBSTypeProperty
//};

/*文章类型bbs_type
 类别：
1单图
2多图
3视频
*/
typedef NS_ENUM(NSInteger, ASHBBSTypes) {
    
    ASHBBSType1P=1,
    ASHBBSType3P=2,
    ASHBBSType1V=3,
    
};

//typedef void(^MOMTestBlock) (NSString *str);
typedef void(^MOMBlock) (MOMResult ret,id result,NSError*error);
typedef void(^MOMFailureBlock) (NSError*error);
#define kWaitTime 60 // 验证码倒计时

//float MOMOSVersion();
//CGRect MOMApplicationBounds();



//@interface Config : NSObject
//
//@end
