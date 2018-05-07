//
//  ASHOrganizationDetalViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/15.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHOrganizationDetalViewController.h"

@interface ASHOrganizationDetalViewController () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ASHOrganizationDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    [self addPagerView];
//    [self addPageControl];
//    
//    [self loadData];
}
//- (void)addPagerView {
//    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
//    pagerView.layer.borderWidth = 1;
//    pagerView.isInfiniteLoop = YES;
//    pagerView.autoScrollInterval = 3.0;
//    pagerView.dataSource = self;
//    pagerView.delegate = self;
//    // registerClass or registerNib
//    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    [self.view addSubview:pagerView];
//    _pagerView = pagerView;
//}
//
//- (void)addPageControl {
//    TYPageControl *pageControl = [[TYPageControl alloc]init];
//    //pageControl.numberOfPages = _datas.count;
//    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
//    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
//    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
//    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
//    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
//    [_pagerView addSubview:pageControl];
//    _pageControl = pageControl;
//}
//
//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
//    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
//}
//
//- (void)loadData {
//    NSMutableArray *datas = [NSMutableArray array];
//    for (int i = 0; i < 5; ++i) {
//        if (i == 0) {
//            [datas addObject:[UIColor redColor]];
//            continue;
//        }
//        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
//    }
//    _datas = [datas copy];
//    _pageControl.numberOfPages = _datas.count;
//    [_pagerView reloadData];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==1) {
//        return 520;
//    }
//    NSString *identifier=@"cell0";
//    UITableViewCell *cell =(UITableViewCell *)([self.tableView dequeueReusableCellWithIdentifier:identifier]);
//    return cell.frame.size.height;
////    return 0;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1||indexPath.row==2) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        ASHOrganizationBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHOrganizationBannerCell" forIndexPath:indexPath];

////        cell.imageView.image  = [UIImage imageNamed:@"视频播放横版"];
//       
////
//        UIView *img =  [cell viewWithTag:11];
////        img.image =[UIImage imageNamed:@"视频播放横版"];
//        UIImage *iiimge =  [UIImage imageNamed:@"视频p"];//报名参与 视频播放横版推荐  视频详情
////        img.image = iiimge;
////        img.frame = CGRectMake(10, 10, 355, iiimge.size.height*355/iiimge.size.width);
//
//         UIImageView *imgView =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 355, iiimge.size.height*355/iiimge.size.width)];
//        imgView.image = iiimge;
//        
//        UIImageView *imgView2 =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10+iiimge.size.height*355/iiimge.size.width, 355, iiimge.size.height*355/iiimge.size.width)];
//        imgView2.image = iiimge;
//        
//        [cell addSubview:imgView];
//        [cell addSubview:imgView2];
//        UIImageView *imgView =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 355, iiimge.size.height*355/iiimge.size.width)];
//        imgView.image = iiimge;
//        [cell addSubview:imgView];
        // Configure the cell...
        
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
