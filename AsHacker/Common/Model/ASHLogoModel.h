//
//  ASHLogoModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/14.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
//名称    描述    类型
//ret    返回值：
//        1获取成功
//        2参数有误
//        0系统异常    String
//list    轮播列表    [Logo]
//Logo

//id    主键    String
//logo_name    名称    String
//logo_subname    简要信息    String
//logo_img    图片地址    String
//logo_flag    广告是否启动标识    String
//logo_url    跳转地址    String

@interface ASHLogoModel : CommonRuntime_Model

//@property (nonatomic , assign) long id;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *logo_name;

@property (nonatomic , strong) NSString *logo_subname;
@property (nonatomic , strong) NSString *logo_img;
@property (nonatomic , strong) NSString *logo_flag;
@property (nonatomic , strong) NSString *logo_url;

//id    主键
//img_name    图片名称
//img_url    图片链接
@property (nonatomic , strong) NSString *img_name;
@property (nonatomic , strong) NSString *img_url;

@end
