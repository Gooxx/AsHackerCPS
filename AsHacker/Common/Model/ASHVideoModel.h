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
 
 */
@interface ASHVideoModel : CommonRuntime_Model
//@property (nonatomic , assign) long id;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *video_title;

@property (nonatomic , strong) NSString *video_count;
@property (nonatomic , strong) NSString *video_description;
@property (nonatomic , strong) NSString *video_order;

@property (nonatomic , strong) NSString *video_userId;
@property (nonatomic , strong) NSString *video_time;
@property (nonatomic , strong) NSString *video_flag;
@property (nonatomic , strong) NSString *video_url;
@end
