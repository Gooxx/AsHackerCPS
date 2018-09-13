//
//  ASHBannerTableViewCell.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/31.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHBannerTableViewCell.h"

@implementation ASHBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
    
    _pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height);
    //    _pagerView.frame = self.bounds;
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}
-(instancetype)initWithFrame:(CGRect)frame
{
    id ctl = [super initWithFrame:frame];
    _pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height);
    //    _pagerView.frame = self.bounds;
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
    return ctl;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 0;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
//    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
//}

- (void)loadData {
    //    NSMutableArray *datas = [NSMutableArray array];
    //    for (int i = 0; i < 3; ++i) {
    ////        if (i == 0) {
    ////            [datas addObject:[UIColor redColor]];
    ////            continue;
    ////        }
    //        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    //    }
    //    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count<=3?_datas.count:3;
    [_pagerView reloadData];
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count<=3?_datas.count:3;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    //    cell.backgroundColor = _datas[index];
    //    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    ASHLogoModel *model =  _datas[index];
    //    [dic objectForKey:@""];
//    NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",HTTPURLCDN,model.logo_img];
    //    cell.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURLStr]]]];
    [cell.imageView ash_setImageWithURL:model.logo_img];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    //    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

#pragma mark - action

- (IBAction)switchValueChangeAction:(UISwitch *)sender {
    if (sender.tag == 0) {
        _pagerView.isInfiniteLoop = sender.isOn;
        [_pagerView updateData];
    }else if (sender.tag == 1) {
        _pagerView.autoScrollInterval = sender.isOn ? 3.0:0;
    }else if (sender.tag == 2) {
        _pagerView.layout.itemHorizontalCenter = sender.isOn;
        [UIView animateWithDuration:0.3 animations:^{
            [_pagerView setNeedUpdateLayout];
        }];
    }
}

- (IBAction)sliderValueChangeAction:(UISlider *)sender {
    if (sender.tag == 0) {
        _pagerView.layout.itemSize = CGSizeMake(CGRectGetWidth(_pagerView.frame)*sender.value, CGRectGetHeight(_pagerView.frame)*sender.value);
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 1) {
        _pagerView.layout.itemSpacing = 30*sender.value;
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 2) {
        _pageControl.pageIndicatorSize = CGSizeMake(6*(1+sender.value), 6*(1+sender.value));
        _pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+sender.value), 8*(1+sender.value));
        _pageControl.pageIndicatorSpaing = (1+sender.value)*10;
    }
}

- (IBAction)buttonAction:(UIButton *)sender {
    _pagerView.layout.layoutType = sender.tag;
    [_pagerView setNeedUpdateLayout];
}

- (void)pageControlValueChangeAction:(TYPageControl *)sender {
    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index
{
    NSLog(@"---------------****  %ld",index);
    
    _showBlock(pageView,cell,index);
}

@end
