//
//  ASHOrganizationBannerCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/29.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "UIImageView+ASH.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

#import "ASHLogoModel.h"
@interface ASHOrganizationBannerCell : UITableViewCell
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy  ) void(^showBlock)(TYCyclePagerView *,UICollectionViewCell *,NSInteger);
- (void)loadData;
//- (void)spagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;
@end
