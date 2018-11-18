//
//  ASHFirstTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/2.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstTableViewController.h"
#import "ZFPlayer.h"


@interface ASHFirstTableViewController (){
//    NSArray *_dataArr;
    NSInteger _showType;//0 all 1 doing 2 end
}

@property(strong,nonatomic)NSArray *logoArr;
@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic) ASHAlertView *alert;


@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end
static NSString *const kLP_CELL = @"cpsMainCellLB";
static NSString *const k1P_CELL = @"cpsMainCell1P";
static NSString *const k3P_CELL = @"cpsMainCell3P";
static NSString *const k1V_CELL = @"cpsMainCell1V";

//static NSInteger const PAGE_COUNT = 10;
@implementation ASHFirstTableViewController

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//     [self.tableView registerClass:[ASHBannerTableViewCell class] forCellReuseIdentifier:@"ASHBannerTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1PTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASH1PTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH3PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell3P"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1VCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1V"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ASHOrganizationBannerCell" bundle:nil] forCellReuseIdentifier:@"ASHOrganizationBannerCell"];
//    ASHOrganizationBannerCell

//    [self.tableView registerNib:[UINib nibWithNibName:@"ASHBBS1PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1P"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ASH3PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell3P"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1VCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1V"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    
//    [self refreshLogo];
//     [self refreshData];
     // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [MOMFilter registerFliterIn:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDataUP];
}
//数据源
-(void)refreshDataUP{
    [self refreshLogo];
    [self refreshDataWithIndex:1];
}

-(void)refreshDataDown{
    double count = _dataArr.count;
    NSInteger num = ceil(count/PAGE_COUNT);
    [self refreshDataWithIndex:num+1];
}

-(void)refreshDataWithIndex:(NSInteger)index{
    //    http://39.105.46.149/cps/app/cps/mainBbsById.do?id=2
    //    http://localhost:8080/cps/app/cps/mainLogo.do
   
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
        
    }
    [self.tableView reloadData];
    
//    NSString *rowCountStr = [NSString stringWithFormat:@"%ld",_dataArr.count>0?_dataArr.count:0];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger count = _dataArr.count;
//    NSInteger num =  count/PAGE_COUNT;
    
    [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"pageIndex"];
//    [params setObject:[NSString stringWithFormat:@"%ld",num+1] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"count"];
     [params setObject:@"1" forKey:@"flag"];
    
    
    [MOMNetWorking asynRequestByMethod:@"mainBbsList.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
//            _dataArr = [ASHBBSModel ModelsWithArray:[dic objectForKey:@"list"]];
            NSMutableArray *arrm = [NSMutableArray arrayWithArray:_dataArr];
            NSArray *arr = [ASHBBSModel ModelsWithArray:[dic objectForKey:@"list"]];
            _dataArr = [arrm arrayByAddingObjectsFromArray:arr];
            [self.tableView reloadData];
        }
    }];
    /*
     NSString *rowCountStr = [NSString stringWithFormat:@"%ld",_dataArr.count+10];
     
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
     [params setObject:@"1" forKey:@"pageNo"];
     [params setObject:rowCountStr forKey:@"rowCountPerPage"];
     if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
     [params setObject:[ASHMainUser userId] forKey:@"userId"];
     }
     //    pageNo=页数（不上传为缺省1）&rowCountPerPage=每页活动数（不上传为缺省10）
     
     [MOMNetWorking asynRequestByMethod:@"list" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
     NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
     NSDictionary *dic = result;
     if (MOMResultSuccess==ret) {
     _dataArr = [dic objectForKey:@"projects"];
     [self.tableView reloadData];
     }
     }];
     */
}
-(void)refreshLogo{
//    http://39.105.46.149/cps/app/cps/mainBbsById.do?id=2
//    http://localhost:8080/cps/app/cps/mainLogo.do
    
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//    if (!_dataArr) {
//        _dataArr =  [NSMutableArray array];
//
//    }
//    [self.tableView reloadData];
    
    
    [MOMNetWorking asynRequestByMethod:@"mainLogo.do" params:@{@"flag":@1} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
//            _dataArr = [dic objectForKey:@"list"];
             _logoArr = [ASHLogoModel ModelsWithArray:[dic objectForKey:@"list"]];
            [self.tableView reloadData];
        }
    }];
    /*
    NSString *rowCountStr = [NSString stringWithFormat:@"%ld",_dataArr.count+10];
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"1" forKey:@"pageNo"];
        [params setObject:rowCountStr forKey:@"rowCountPerPage"];
        if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
            [params setObject:[ASHMainUser userId] forKey:@"userId"];
        }
//    pageNo=页数（不上传为缺省1）&rowCountPerPage=每页活动数（不上传为缺省10）
    
        [MOMNetWorking asynRequestByMethod:@"list" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _dataArr = [dic objectForKey:@"projects"];
                [self.tableView reloadData];
            }
        }];
     */
}
//X菜单展示




#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0&&indexPath.row==0) {
        return 200;
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSArray *cellNames = @[@"cpsMainCellLB",@"ASH1PTableViewCell",@"cpsMainCell3P",@"cpsMainCell1V"];
    if (0==indexPath.row) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHOrganizationBannerCell" forIndexPath:indexPath];
//        return cell;
        
//        ASHBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHBannerTableViewCell" forIndexPath:indexPath];
//
//
//        if(!cell){
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"ASHOrganizationBannerCell" owner:nil options:nil] firstObject];// [[ASHOrganizationBannerCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 190)];
        ASHBannerTableViewCell *cell = [[ASHBannerTableViewCell alloc]createBanner:CGRectMake(0, 0, ScreenWidth, 190)];
        
//        ASHBannerTableViewCell *cell = [[ASHBannerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ASHBannerTableViewCell"];
            NSLog(@"---------");
//        }
//        //        if (!cell) {
        cell.datas = _logoArr; 
        [cell loadData];
        //        __block NSIndexPath *weakIndexPath = indexPath;
        //    __block ZFPlayerCell *weakCell     = cell;
        //        __block ASHOrganizationBannerCell *weakCell     = cell;
        
        
        __weak typeof(self)  weakSelf      = self;
        
        cell.showBlock = ^(TYCyclePagerView *pageView, UICollectionViewCell *cell, NSInteger index) {
                ASHLogoModel *model = _logoArr[index];
                ASHNewsTWDetailViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsTWDetailViewController"];
                ctl.detailId = model.id;
                [weakSelf.navigationController pushViewController:ctl animated:YES];
            
        };
        return cell;
    }else{
        ASHBBSModel *model = _dataArr[indexPath.row-1];
//        UITableViewCell *tcell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
        UITableViewCell *tcell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
        if(!tcell){
            tcell = [[[NSBundle mainBundle]loadNibNamed:cellNames[model.bbs_type] owner:nil options:nil] firstObject];
        }
        
        
//        NSLog(@"model: %@------index:%ld",model,indexPath.row);
        
        
//        ASHBBS1PCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
//        cell.title.text = model.bbs_description;
//        cell.name.text = model.bbs_title;
//        cell.time.text = model.bbs_time;
//        [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
        
        if (ASHBBSType1P == model.bbs_type) {
            __weak ASHBBS1PCell *cell = (ASHBBS1PCell *)tcell;
            cell.title.text = model.bbs_title;
            cell.name.text = model.user_nick;
            cell.time.text = model.bbs_time;
//            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            if ([model.bbs_minPic containsString:@"||"]) {
                NSArray *images = [model.bbs_minPic componentsSeparatedByString:@"||"];
                [cell.image1 ash_setImageWithURL:images[0]];
            }else{
                [cell.image1 ash_setImageWithURL:model.bbs_minPic];
            }
            
            tcell = cell;
        }else if (ASHBBSType3P == model.bbs_type) {
            __weak ASH3PCell *cell =  (ASH3PCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            if ([model.bbs_minPic containsString:@"||"]) {
                NSArray *images = [model.bbs_minPic componentsSeparatedByString:@"||"];
                [cell.image1 ash_setImageWithURL:images.count>1?images[0]:@""];
                [cell.image2 ash_setImageWithURL:images.count>2?images[1]:@""];
                [cell.image3 ash_setImageWithURL:images.count>3?images[2]:@""];
            }else{
                [cell.image1 ash_setImageWithURL:model.bbs_minPic];
            }

            tcell = cell;
        }else if (ASHBBSType1V == model.bbs_type) {
            __weak ASH1VCell *cell =  (ASH1VCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
//            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            if ([model.bbs_minPic containsString:@"||"]) {
                NSArray *images = [model.bbs_minPic componentsSeparatedByString:@"||"];
                [cell.image1 ash_setImageWithURL:images[0]];
            }else{
                [cell.image1 ash_setImageWithURL:model.bbs_minPic];
            }
           
            tcell = cell;
        }
        return tcell;
    }
    
    return nil;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASHBBSModel *model = _dataArr[indexPath.row-1];
    if (ASHBBSType1P == model.bbs_type||ASHBBSType3P == model.bbs_type) {
        ASHNewsTWDetailViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsTWDetailViewController"];
        
//        ctl.lModel = model;
        ctl.detailId = model.id;
       
        [self.navigationController pushViewController:ctl animated:YES];
       
    }else if (ASHBBSType1V == model.bbs_type) {
        ASHNewsVideoDetailTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsVideoDetailTableViewController"];
//        ctl.lModel = model;
        ctl.detailId = model.id;
        [self.navigationController pushViewController:ctl animated:YES];
    }
    
    
}
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
        // 移除屏幕移除player
        // _playerView.stopPlayWhileCellNotVisable = YES;
    }
    return _playerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
