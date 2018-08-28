//
//  ASHUserModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/5.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
/*
 id    主键
 user_head    用户头像
 user_minhead    用户缩略头像
 user_nick    用户昵称
 
 user_info    用户信息
 bbsCount    动态数量
 followCount    关注数量
 fansCount    粉丝数量
 
 */
@interface ASHUserModel : CommonRuntime_Model
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *user_head;
@property (nonatomic , strong) NSString *user_minhead;
@property (nonatomic , strong) NSString *user_nick;

@property (nonatomic , strong) NSString *user_info;
@property (nonatomic , strong) NSString *bbsCount;
@property (nonatomic , strong) NSString *followCount;
@property (nonatomic , strong) NSString *fansCount;

@end
