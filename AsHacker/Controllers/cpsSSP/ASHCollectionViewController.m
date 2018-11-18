//
//  ASHCollectionViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/22.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHCollectionViewController.h"

@interface ASHCollectionViewController ()
@property(strong,nonatomic)NSArray *dataArr;
@end
//static NSInteger const PAGE_COUNT = 10;
@implementation ASHCollectionViewController

static NSString * const reuseIdentifier = @"ASHSSPCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
       

    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerNib:[ASHSSPCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDataUP];
}
- (IBAction)addSSP:(id)sender {
    CameraFilterVC *ctl = [[CameraFilterVC alloc]init];
    ctl.hidesBottomBarWhenPushed = YES;
//    ASHGPUImageController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHGPUImageController"];
//    ASHGPUImageController *ctl = [[ASHGPUImageController alloc]init];
    [self.navigationController pushViewController:ctl animated:YES];
    
//    ASHVideotapeViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHVideotapeViewController"];
//    [self.navigationController pushViewController:ctl animated:YES];
}
//数据源
//数据源
-(void)refreshDataUP{
    
    [self refreshDataWithIndex:1];
}

-(void)refreshDataDown{
    double count = _dataArr.count;
    NSInteger num = ceil(count/PAGE_COUNT);
    [self refreshDataWithIndex:num+1];
}



-(void)refreshDataWithIndex:(NSInteger)index{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
        
    }
//    [self.collectionView reloadData];
    //    videoList
    //    flag    随手拍标识
    //    1立即发布
    //    2待审核视频
    //    0删除    String
    //    userId    文章类别    String
    //    pageIndex    起始数    String
    //    count    每页显示数    String
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger count = _dataArr.count;
    [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"count"];
    [params setObject:@"1" forKey:@"flag"];
    
    
    [MOMNetWorking asynRequestByMethod:@"videoList.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
            if (index==1) {
                _dataArr = [ASHVideoModel ModelsWithArray:[dic objectForKey:@"list"]];
            }else{
                NSMutableArray *arrm = [NSMutableArray arrayWithArray:_dataArr];
                NSArray *arr = [ASHVideoModel ModelsWithArray:[dic objectForKey:@"list"]];
                _dataArr = [arrm arrayByAddingObjectsFromArray:arr];
            }
            
            [self.collectionView reloadData];
        }
    }];
  
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASHVideoModel *model =_dataArr[indexPath.row];
    ASHSSPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:nil options:nil]firstObject];
    }
    [cell.bgIV ash_setImageWithURL:model.video_name];
    
    cell.titleLabel.text = model.video_title;
    cell.nameLabel.text = model.video_description;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ASHVideoModel *model =_dataArr[indexPath.row];
    
    ASHVideoPlayerViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHVideoPlayerViewController"];
    ctl.sspId = model.id;
    [self.navigationController pushViewController:ctl animated:YES];
    
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
