//
//  CarBrandModel.h
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 "icon": "http://img2.xcarimg.com/PicLib/logo/pl56_160s.png?t=20170828",
 "id": 56,
 "name": "阿斯顿·马丁"
 }
 */
//            listCar
//            "car_name": "A6",
//            "id": "2",
//            "show_pic": ""


//"brand_cnName": "阿尔法·罗密欧",
//"brand_enName": "aerfa·luomiou",
//"brand_logo": "http://39.105.46.149/cps/fileUpload/brand/carImg2.jpg",
//"id": "3"

@interface CarBrandModel : CommonRuntime_Model
@property (nonatomic , strong) NSString *brand_cnName;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *brand_enName;
@property (nonatomic , strong) NSString *brand_logo;
//@property (nonatomic , strong) NSString *icon;
//@property (nonatomic , assign) long id;
//@property (nonatomic , strong) NSString *name;

@end
