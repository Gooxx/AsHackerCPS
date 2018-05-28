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
    NSArray *_dataArr;
    NSInteger _showType;//0 all 1 doing 2 end
}

@property(strong,nonatomic) ASHAlertView *alert;


@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end

@implementation ASHFirstTableViewController

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    
     [self refreshData];
     // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
//数据源
-(void)refreshDataUP{
    [self refreshData];
}

-(void)refreshDataDown{
    [self refreshData];
}

-(void)refreshData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
        
    }
    [self.tableView reloadData];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count+4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *cellNames = @[@"cpsMainCellLB",@"cpsMainCell1P",@"cpsMainCell3P",@"cpsMainCell1V"];
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[indexPath.row] forIndexPath:indexPath];
//    static NSString *cellName =
//    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[indexPath.row] forIndexPath:indexPath];
//    NSDictionary *dic = _dataArr[indexPath.row];
//    [cell showMainData:dic];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    ASHFirstDetailTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
    ctl.dataDic = _dataArr[indexPath.row];
    [self.navigationController pushViewController:ctl animated:YES];
     */
    
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
