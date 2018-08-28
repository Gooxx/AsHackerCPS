//
//  ASHMissionModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/5.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
/*
 id    主键
 mission_title    任务标题
 mission_short    任务简介
 mission_content    任务内容
 mission_but    按钮文字
 mission_flag    任务状态
 
 */
@interface ASHMissionModel : CommonRuntime_Model
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *mission_title;
@property (nonatomic , strong) NSString *mission_short;
@property (nonatomic , strong) NSString *mission_content;

@property (nonatomic , strong) NSString *mission_but;
@property (nonatomic , strong) NSString *mission_flag;


@end
