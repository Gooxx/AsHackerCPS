//
//  ASHMainViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/5.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMainViewController.h"

@interface ASHMainViewController (){
    NSArray *list;
}

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;


@property (nonatomic, strong) SDCursorView *cursorView;


@property (nonatomic, strong)JWPlayer *player;

@property (nonatomic, strong)UIView *bview;
@end

@implementation ASHMainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _cursorView.hidden = NO;
    _segHead.hidden = NO;
}
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _cursorView.hidden = YES;
    _segHead.hidden = YES;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     list = @[@"我的参与",@"我的支持",@"我的关注",@"我的项目"];
//    list = @[@"精选视频",@"自然发声",@"公益活动",@"我的"];
    
    NSMutableArray *contrors = [NSMutableArray array];
    
    for (NSInteger i=0; i<list.count; i++) {
        if (2==i){
            [contrors addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"mainTableController"]];
            
        }else if (4==i) {
            [contrors addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"natureTableController"]];
        }else if (3==i){
            [contrors addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"activityTableController"]];
        }else if (5==i){
            [contrors addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"mineViewController"]];
        }else{
            [contrors addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"mainTableController"]];
            //             [contrors addObject:nil];
        }
        
    }
    
//    NSArray *titles = @[@"头条",@"大数据股票财经",@"精选",@"娱乐视",@"热点点附近会计分录的",@"体育",@"科技",@"汽车"];
    _cursorView = [[SDCursorView alloc]initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 40)];
    //设置子页面容器的高度
    _cursorView.contentViewHeight = CGRectGetHeight(self.view.bounds)-150;
    //设置控件所在controller
    _cursorView.parentViewController = self;
    _cursorView.titles = list;
    
    //设置所有子controller
//    NSMutableArray *contrors = [NSMutableArray array];
//    for (NSString *title in titles) {
//        ShowViewController *controller = [[ShowViewController alloc]init];
//        controller.content = title;
//        [contrors addObject:controller];
//    }
    _cursorView.controllers = [contrors copy];
    //设置字体和颜色
    _cursorView.normalColor = [UIColor darkGrayColor];
    _cursorView.selectedColor = [UIColor grayColor];
    _cursorView.selectedFont = [UIFont systemFontOfSize:10];
    _cursorView.normalFont = [UIFont systemFontOfSize:10];
    _cursorView.backgroundColor = [UIColor whiteColor];
    _cursorView.lineView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_cursorView];
    
    //属性设置完成后，调用此方法绘制界面
    [_cursorView reloadPages];

    
//    contrors = @[@"mineViewController",@"mineViewController",@"mineViewController",@"mineViewController"];
//    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 64-64+120, SCREEN_WIDTH, 40) titles:list headStyle:0 layoutStyle:0];
//    _segHead.fontScale = 1.1;
//    _segHead.showIndex = 0;
//    _segHead.lineColor = [UIColor blackColor];
//    _segHead.headColor = [UIColor whiteColor];
////    _segHead.selectColor = [UIColor whiteColor];
//    _segHead.selectColor = MOMRGBColor(127, 127, 127);
//    _segHead.deSelectColor =  MOMRGBColor(72, 71, 71);//[UIColor grayColor];
//    _segHead.bottomLineColor = [UIColor redColor];
//    
//    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:contrors];
//    _segScroll.loadAll = YES;
//    
//    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
//        //        [self.view addSubview:_segHead];
//        //        [self.navigationController.navigationBar setItems:@[_segHead]];
//        [self.navigationController.navigationBar addSubview:_segHead];
//        [self.view addSubview:_segScroll];
//    }];
 
//    _cursorView.controllers = [contrors copy];
//    //设置字体和颜色
//    _cursorView.normalColor = [UIColor grayColor];
//    _cursorView.selectedColor = [UIColor whiteColor];
//    _cursorView.selectedFont = [UIFont systemFontOfSize:16];
//    _cursorView.normalFont = [UIFont systemFontOfSize:13];
//    _cursorView.backgroundColor = [UIColor blueColor];
//    _cursorView.lineView.backgroundColor = [UIColor yellowColor];
//    _cursorView.lineEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
////    [self.view addSubview:_cursorView];
//    [self.navigationController.navigationBar addSubview:_cursorView];
//    //属性设置完成后，调用此方法绘制界面
//    [_cursorView reloadPages];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
