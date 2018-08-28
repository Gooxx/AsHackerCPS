//
//  ASHBBSModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
//Bbs
//id    主键    String
//bbs_title    标题    String
//bbs_type    类别：
//1单图
//2多图
//3视频    String
//bbs_description    文章描述    String
//bbs_minPic    缩略图片路径    String
//bbs_time    发布时间    String
//bbs_url    视频链接    String

@interface ASHBBSModel : CommonRuntime_Model

//以下是首页列表的字段
//@property (nonatomic , assign) long id;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *bbs_title;

@property (nonatomic , assign) long bbs_type;
@property (nonatomic , strong) NSString *bbs_description;
@property (nonatomic , strong) NSString *bbs_minPic;
@property (nonatomic , strong) NSString *bbs_time;
@property (nonatomic , strong) NSString *bbs_url;

//以下是详情页的字段
@property (nonatomic , strong) NSString *bbs_content; // 详情页的 内容
@property (nonatomic , assign) BOOL is_store; // 1收藏 0未收藏

//以下是收藏列表的字段
@property (nonatomic , strong) NSString *bbs_count; //浏览数



@end
