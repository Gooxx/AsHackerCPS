//
//  ASHCarInfoModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/23.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
#import "CarBrandModel.h"
@interface ASHCarInfoModel : CommonRuntime_Model
@property (nonatomic , assign) long long brandNum;
@property (nonatomic , strong) NSString *letter;
@property (nonatomic , strong) NSArray *brands;
@end
