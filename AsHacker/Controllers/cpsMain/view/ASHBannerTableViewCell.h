//
//  ASHBannerTableViewCell.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/31.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "UIImageView+ASH.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

#import "ASHLogoModel.h"
@interface ASHBannerTableViewCell : UITableViewCell<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy  ) void(^showBlock)(TYCyclePagerView *,UICollectionViewCell *,NSInteger);
- (void)loadData;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)createBanner:(CGRect)frame;
@end
