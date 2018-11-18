//
//  ASHLogoModel.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/14.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHLogoModel.h"

@implementation ASHLogoModel
-(void)setImg_name:(NSString *)img_name
{
    self.logo_name = img_name;
}
-(NSString *)img_name
{
    return self.logo_name;
}


-(void)setImg_url:(NSString *)img_url
{
    self.logo_url = img_url;
}
-(NSString *)img_url
{
    return self.logo_url;
}
@end
