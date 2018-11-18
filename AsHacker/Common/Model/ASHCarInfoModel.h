//
//  ASHCarInfoModel.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/23.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "CommonRuntime_Model.h"
#import "CarBrandModel.h"


//            listBrand
//            "brand_cnName": "阿尔法·罗密欧",
//            "brand_enName": "aerfa·luomiou",
//            "brand_logo": "http://39.105.46.149/cps/fileUpload/brand/carImg2.jpg",
//            "id": "3"
@interface ASHCarInfoModel : CommonRuntime_Model
@property (nonatomic , assign) long long brandNum;
@property (nonatomic , strong) NSString *letter;
@property (nonatomic , strong) NSArray *brands;

//@property (nonatomic , assign) long long brandNum;
//@property (nonatomic , strong) NSString *letter;
//@property (nonatomic , strong) NSArray *brands;
@end
