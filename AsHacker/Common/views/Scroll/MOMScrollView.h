//
//  MOMScrollView.h
//  LivingArea
//
//  Created by goooo on 15/12/14.
//  Copyright © 2015年 mom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdScrollView.h"
//#import "MOMBBSInfo.h"
//#import "MOMMainBBSController.h"
//#import "ASHGalleryCollectionViewController.h"
//#import "MOMObject.h"
////{"areaId":3,"jp":"wksjhc","name":"万科四季花城","pinyin":"wankesijihuacheng"}
//@interface MOMAD : MOMObject
//@property (nonatomic,copy)NSString *mes;//小区id
//@property (nonatomic,copy)NSString *img;//小区名称
//@end


@interface MOMScrollView : UIView<UIScrollViewDelegate>{
    
        UIScrollView *scrollview;
        UIPageControl *pageControl;
        NSInteger width;
        NSInteger hight;
    
}
//@property(nonatomic ,strong)UIScrollView * headScroll;
//@property(nonatomic ,strong)UIPageControl * pageControl;
@property(nonatomic,weak)id delegate;

@property(nonatomic,strong)NSArray * imagesArray;
@property (nonatomic, strong)NSTimer *time;

-(instancetype)initWithFrame:(CGRect)frame info:(NSArray *)infos;
@end




