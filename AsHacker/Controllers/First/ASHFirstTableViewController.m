//
//  ASHFirstTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/2.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstTableViewController.h"
#import "ZFPlayer.h"

//#import "Order.h"
//#import "APAuthV2Info.h"
//#import "RSADataSigner.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "ZFVideoModel.h"

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
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    
     [self refreshData];
    
    self.tableView.estimatedRowHeight = 50.0f;
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
}
//X菜单展示



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.row];
    [cell showMainData:dic];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ASHFirstDetailTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
    ctl.dataDic = _dataArr[indexPath.row];
    [self.navigationController pushViewController:ctl animated:YES];
    
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
 {"statusCode":0,
 "projects":[
 {"PROJECT_ID":40,
 "USER_ID":14,
 "SECOND_USER_ID":null,
 "COVER_HREF":"/projects/600x290黑暗挑战-01_20170914173948.jpg",
 "VIDEO_HREF":"/projects/VID_20170826_110919_1_1_20170914173058.mp4",
 "TITLE":"黑暗挑战",
 "INTRO":"我们致力于服务于视网膜色素变性人群（Retinitis Pigmentosa，简称RP）",
 "TOTAL_AMOUNT":50000,
 "REAL_AMOUNT":0,
 "FUND_BEGIN_DATE":"2017-09-14",
 "FUND_END_DATE":"2017-12-14",
 "INITIATOR":"李艳丽",
 "DUTY_PHONE":"18057188284",
 "PROVINCE":"浙江省",
 "CITY":"杭州市",
 "DISTRICT":"西湖区",
 "ADDRESS":"余杭塘路799号 五洲国际广场",
 "BEGIN_DATE":"2017.09.14",
 "END_DATE":"2017-12-14",
 "PERSON_LIMIT":1000,
 "CATEGORY":"残障",
 "CONTENT":"考虑放开了我就<div><br></div><div><img src="/projects/53/slider-bg-1_20171003121512.thumb.jpg" class="" style="margin: 0px; resize: none; position: relative; zoom: 1; display: block; height: 203px; width: 600px; top: 0px; left: 0px;"><br></div>",
 "APPROVE_STATE":3,
 "ENROLL_COUNT":1,
 "QUIT_COUNT":0,
 "FUND_COUNT":0,
 "REIMBURSE_COUNT":0,
 "IF_EXTRACT":null,
 "IF_HOT":1,
 "IF_VOLUNTEER":1,
 "FEEDBACK":null,
 "INIT_VIDEO_HREF":null,
 "INIT_CONTENT":null,
 "REMAIN_DAYS":71,
 "LOGO_HREF":"/organizers/logo.png",
 "ORGANIZATION_NAME":"浙江省宽居幸福生活公益服务中心",
 "PROJECT_STATE":"众筹中"
 },
 {"PROJECT_ID":39,
 "USER_ID":14,
 "SECOND_USER_ID":2,
 "COVER_HREF":"/projects/0826_18_12270_20170914173245.JPG",
 "VIDEO_HREF":"/projects/index.mp4",
 "TITLE":"黑暗挑战",
 "INTRO":"用体验的方式来培训志愿者",
 "TOTAL_AMOUNT":10000,
 "REAL_AMOUNT":0,
 "FUND_BEGIN_DATE":"2017-09-14",
 "FUND_END_DATE":"2017-09-14",
 "INITIATOR":"李艳丽",
 "DUTY_PHONE":"18057188284",
 "PROVINCE":"浙江省",
 "CITY":"杭州市",
 "DISTRICT":"西湖区",
 "ADDRESS":"五洲国际",
 "BEGIN_DATE":"2017.09.14",
 "END_DATE":"2017-09-30",
 "PERSON_LIMIT":50,
 "CATEGORY":"残障",
 "CONTENT":“考虑放开了我就<div><br></div><div><img src="/projects/53/slider-bg-1_20171003121512.thumb.jpg" class="" style="margin: 0px; resize: none; position: relative; zoom: 1; display: block; height: 203px; width: 600px; top: 0px; left: 0px;"><br></div>”,
 "APPROVE_STATE":3,
 "ENROLL_COUNT":0,
 "QUIT_COUNT":0,
 "FUND_COUNT":0,
 "REIMBURSE_COUNT":0,
 "IF_EXTRACT":1,
 "IF_HOT":0,
 "IF_VOLUNTEER":0,
 "FEEDBACK":“1”,
 "INIT_VIDEO_HREF":“/projects/111.mp4”,
 "INIT_CONTENT":“考虑放开了我就<div><br></div><div><img src="/projects/53/slider-bg-1_20171003121512.thumb.jpg" class="" style="margin: 0px; resize: none; position: relative; zoom: 1; display: block; height: 203px; width: 600px; top: 0px; left: 0px;"><br></div>”,
 "REMAIN_DAYS":0,
 "LOGO_HREF":"/organizers/logo.png",
 "ORGANIZATION_NAME":"浙江省宽居幸福生活公益服务中心",
 "PROJECT_STATE":"活动结束"
 }
 ]
 }

*/

@end
