//
//  ASHCarBBSModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/7/5.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
/*
 id    主键
 car_bbs_name    车辆文章名称
 car_bbs_type    车辆文章类别
 car_bbs_url    车辆文章链接
 car_id    车辆id
 
 */
@interface ASHCarBBSModel : CommonRuntime_Model
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *car_bbs_name;
@property (nonatomic , strong) NSString *car_bbs_type;
@property (nonatomic , strong) NSString *car_bbs_url;

@property (nonatomic , strong) NSString *car_id;
@end
