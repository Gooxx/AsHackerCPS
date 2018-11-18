//
//  ASHVideoModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/5.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
/*
 id    主键
 video_title    标题
 video_count    类别
 video_order    视频排序
 video_description    视频描述
 video_userId    用户id
 video_time    发布时间
 video_flag    视频状态
 video_url    视频链接
 
 
 
 ret    返回值：
 1获取成功
 2参数有误
 9用户token过期
 0系统异常    String
 id    主键    String
 video_title    标题    String
 video_description    视频描述    String
 video_time    发布时间    String
 video_flag    视频状态    String
 video_url    视频链接    String
 video_name    视频图片    String
 
 is_friend    是否关注    String
 good_num    点赞数    String
 user_head    用户头像    String
 user_nick    用户昵称    String
 
 */
@interface ASHVideoModel : CommonRuntime_Model
//@property (nonatomic , assign) long id;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *video_title;

@property (nonatomic , strong) NSString *video_name;
@property (nonatomic , strong) NSString *video_count;
@property (nonatomic , strong) NSString *video_description;
@property (nonatomic , strong) NSString *video_order;

@property (nonatomic , strong) NSString *video_userId;
@property (nonatomic , strong) NSString *video_time;
@property (nonatomic , strong) NSString *video_flag;
@property (nonatomic , strong) NSString *video_url;

@property (nonatomic , assign) BOOL is_friend; // 1关注 0未关注
@property (nonatomic , strong) NSString *good_num; //
@property (nonatomic , strong) NSString *user_head; //
@property (nonatomic , strong) NSString *user_nick; //
@end
