//
//  ChineseString.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/18.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//


#import <Foundation/Foundation.h>
//#import "PinYin.h"
//#import "PictureBook.h"
//#import "ASHCarInfoModel.h"
#import "CarBrandModel.h"
@interface ChineseString : NSObject
@property(retain,nonatomic) NSString *string;
@property(retain,nonatomic) NSString *pinYin;
@property(nonatomic,strong) CarBrandModel *book;//对象

/**
 *  TableView右方IndexArray
 */
+(NSMutableArray *) IndexArray:(NSArray *) stringArr;

/**
 *  文本列表
 */
+(NSMutableArray *) LetterSortArray:(NSArray *)stringArr;

/**
 *返回一组字母排列数组(中英混排)
 */
+(NSMutableArray *) SortArray:(NSArray *)stringArr;

@end
