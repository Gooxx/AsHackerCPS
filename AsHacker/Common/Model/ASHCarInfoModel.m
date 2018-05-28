//
//  ASHCarInfoModel.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/23.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHCarInfoModel.h"

@implementation ASHCarInfoModel
+ (instancetype)ModelWithDict:(NSDictionary *)dic {
    id obj = [[self alloc]init];
    NSArray *properties = [self properties];//返回存储着类属性名字的数组
    for (NSString *pro in properties) {
        //判断你获取到的数组中的属性的值是否为空
        if (dic[pro] != nil && ![dic[pro] isKindOfClass:[NSNull class]]) {
            if ([pro isEqualToString:@"brands"]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dict in dic[pro]) {
                    CarBrandModel *model = [CarBrandModel ModelWithDict:dict];
                    [array addObject:model];
                }
                [obj setValue:[array copy] forKey:pro];
                continue;
            }
            [obj setValue:dic[pro] forKey:pro];
        }
    }
    return obj;
}
@end
