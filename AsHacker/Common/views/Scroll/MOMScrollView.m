//
//  MOMScrollView.m
//  LivingArea
//
//  Created by goooo on 15/12/14.
//  Copyright © 2015年 mom. All rights reserved.
//

#import "MOMScrollView.h"

@implementation MOMScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame info:(NSArray *)infos
{
    self.imagesArray = infos;
    self = [super initWithFrame:frame];
    width=frame.size.width;
    hight=frame.size.height;
    scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, hight)];
    [scrollview setDelegate:self];
    for (int i=0; i<infos.count; i++) {
       // MOMBBSInfo *info = infos[i];
        NSString *url = infos[i];//[infos[i] objectForKey:@"GALLERY_POSTER_HREF"];
//        NSString *mes = info.GALLERY_DESC;//[infos[i] objectForKey:@"GALLERY_DESC"];
//        NSString *fileName=[NSString stringWithFormat:@"%d.jpg",i];
        UIButton *btn=[[UIButton alloc] init];
        btn.tag = i;
        [btn setFrame:CGRectMake(i*width, 0, width, hight)];
        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
        [scrollview  addSubview:btn];
        [btn addTarget:_delegate action:@selector(adClick:) forControlEvents:UIControlEventTouchUpInside];
        /*
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.tag = i;
        [imageView setFrame:CGRectMake(i*width, 0, width, hight)];
        
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//        [CacheUtil loadImage:url placeholderImage:@"" completion:^(UIImage *img) {
//            imageView.image = img;
//        }];
//        NSString *imgURLName =  [NSString stringWithFormat:@"%@%@",HTTPURL_IMG,[url stringByReplacingOccurrencesOfString:@"," withString:@""]];
//        NSData *headData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURLName]];
//        UIImage *headImage = [UIImage imageWithData:headData];
//        imageView.image = headImage;
        
        [scrollview  addSubview:imageView];
        
//        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adClick:)];
        [imageView addGestureRecognizer:tapG];
        */
        /*
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake(110, 110, 300, 44)];
        messageLab.center = CGPointMake(imageView.center.x, imageView.bounds.size.height-60);
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.textColor = [UIColor whiteColor];
        messageLab.text = mes;
        [scrollview addSubview:messageLab];
         */
        
    }
    [scrollview setContentSize:CGSizeMake(width*infos.count, hight)];
    [scrollview setBounces:NO];
    
    //滚动时是否水平显示滚动条
    [scrollview setShowsHorizontalScrollIndicator:NO];
    //分页显示
    [scrollview setPagingEnabled:YES];
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 460, 320, 20)];
    pageControl.center = CGPointMake(scrollview.center.x,scrollview.bounds.size.height-20);
    [pageControl setBackgroundColor:[UIColor clearColor]];
//    [pageControl setValue:[UIImage imageNamed:@"小横线灰"] forKeyPath:@"_pageImage"];
//    
//    [pageControl setValue:[UIImage imageNamed:@"小横线蓝"] forKeyPath:@"_currentPageImage"];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = infos.count;
//    [pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    [self addSubview:scrollview];
    [self insertSubview:pageControl aboveSubview:scrollview];

   self.time =  [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    return  self;
}
-(void)adClick:(UIButton *)sender
{
    NSLog(@"doClick*****************");
    if ([_delegate respondsToSelector:@selector(adClick:)]) {
        [_delegate performSelector:@selector(adClick:) withObject:sender];
    }
    
    
    
}
//-(void)adClick:(UITapGestureRecognizer *)sender
//{
//    
//    /*
//    NSArray *infos = self.imagesArray;
//    MOMBBSInfo *info =  infos[sender.view.tag];
//    NSString *url = info.GALLERY_ID;//[info objectForKey:@"GALLERY_ID"];
//    NSString *mes = info.GALLERY_DESC;//[info objectForKey:@"mes"];
////    UIViewController *renqiCtl = [[UIViewController alloc]init];
////    UIWebView *webView = [[UIWebView alloc]initWithFrame:MOMScreenBounds];
////    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
////
////    [renqiCtl.view addSubview:webView];
////
//    MOMMainBBSController *mainBBSCtl = self.delegate;
//    
//    [mainBBSCtl.bar removeFromSuperview];
//    ASHGalleryCollectionViewController *gctl = [mainBBSCtl.storyboard instantiateViewControllerWithIdentifier:@"bbscollectionctl"];
//    gctl.dataInfo = info;
////    [self.navigationController pushViewController:gctl animated:YES];
//    [mainBBSCtl.navigationController pushViewController:gctl animated:YES];
//    
//    //        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://renqi.map.baidu.com/"]]];
//    //        webView.scrollView.scrollEnabled = NO;
////    [ addSubview:webView];
//
////    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:mes message:@"广告位，等您莅临" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
////    [alert show];
//     */
//}

//- (void) click{
//    NSLog(@"xxx");
//    
//}
- (void)timeAction{
    NSInteger page = pageControl.currentPage;
    page++;
    if (page == self.imagesArray.count) {
        page = 0;
    }
    CGPoint point = CGPointMake(self.bounds.size.width * page, 0);
    [scrollview setContentOffset:point animated:YES];
    pageControl.currentPage = page;
}

//滚动是就会触发
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"正在滚动");
//}
//
////开始拖拽视图
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewWillBeginDragging");
//}
//完成拖拽
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//{
//    NSLog(@"scrollViewDidEndDragging");
//}
////将开始降速时
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewWillBeginDecelerating");
//}
//
////减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int index= scrollview.contentOffset.x/width;
    [pageControl setCurrentPage:index];
    
    
}
////滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewDidEndScrollingAnimation");
//}
////设置放大缩小的视图，要是uiscrollview的subview
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
//{
//    NSLog(@"viewForZoomingInScrollView");
//    return viewA;
//}
////完成放大缩小时调用
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;
//{
//
//    NSLog(@"scale between minimum and maximum. called after any 'bounce' animations");
//}// scale between minimum and maximum. called after any 'bounce' animations
//
////如果你不是完全滚动到滚轴视图的顶部，你可以轻点状态栏，那个可视的滚轴视图会一直滚动到顶部，那是默认行为，你可以通过该方法返回NO来关闭它
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewShouldScrollToTop");
//    return YES;
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewDidScrollToTop");
//}
@end
