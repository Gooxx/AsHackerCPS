//
//  ASHActivityTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/7.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHActivityTableViewController.h"
static NSString * const topCellName = @"topCell";
static NSString * const bottomCellName = @"bottomCell";
@interface ASHActivityTableViewController (){
    NSArray *_dataArr;
    MOMScrollView *_scrollView;
}
//@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end

@implementation ASHActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    _dataArr = [NSArray array];
   [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:topCellName];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self refreshData];
}

-(void)refreshData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.footer endRefreshing];
        _dataArr =  [NSMutableArray array];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"6" forKey:@"rowCountPerPage"];
        if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
            [params setObject:[ASHMainUser userId] forKey:@"userId"];
        }
        
        [MOMNetWorking asynRequestByMethod:@"list1" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _dataArr = [dic objectForKey:@"projects"];
                [self.tableView reloadData];
            }
        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0==section) {
        return 1;
    }else{
        return _dataArr.count-3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section) {
        return (SCREEN_WIDTH*425)/750;
    }else{
        return 350;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0==indexPath.section) {
       
        
        ASHOrganizationBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHOrganizationBannerCell" forIndexPath:indexPath];
//        if (!cell) {
        cell.datas = _dataArr;
        [cell loadData];
//        __block NSIndexPath *weakIndexPath = indexPath;
        //    __block ZFPlayerCell *weakCell     = cell;
//        __block ASHOrganizationBannerCell *weakCell     = cell;
        __weak typeof(self)  weakSelf      = self;
        
        cell.showBlock = ^(TYCyclePagerView *pageView, UICollectionViewCell *cell, NSInteger index) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:FIRST_STORYBOARD bundle:nil];
            ASHFirstDetailTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
            ctl.dataDic = _dataArr[index];
            [weakSelf.navigationController pushViewController:ctl animated:YES];
        };
        return cell;
        
    }else{
        ASHActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottomCell" forIndexPath:indexPath];
        cell.observeBtn.tag = indexPath.row+3;
        [cell.observeBtn addTarget:self action:@selector(doObserve:) forControlEvents:UIControlEventTouchUpInside];
        if (_dataArr.count>3) {
            NSDictionary *dic = _dataArr[indexPath.row+3];
            __block NSIndexPath *weakIndexPath = indexPath;
            __block ASHMainTableViewCell *weakCell     = cell;
            __weak typeof(self)  weakSelf      = self;
            // 点击播放的回调
            cell.playBlock = ^(UIButton *btn){
                NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"COVER_HREF"]];
                NSString *videoURLStr2 = [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"VIDEO_HREF"]];
                NSString *videoURLStr = [videoURLStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *videoURL = [NSURL URLWithString:videoURLStr];
                if (videoURL) {
                    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
                    playerModel.title            = @"";//model.title;
                    playerModel.videoURL         = videoURL;
                    playerModel.placeholderImageURLString = imgURLStr;//@"http://www.chouduck.com/projects/40/600x290%E9%BB%91%E6%9A%97%E6%8C%91%E6%88%98-01_20170914173735.jpg";//model.coverForFeed;
                    playerModel.scrollView       = weakSelf.tableView;
                    playerModel.indexPath        = weakIndexPath;
                    // 赋值分辨率字典
                    //        playerModel.resolutionDic    = dic;
                    // player的父视图tag
                    playerModel.fatherViewTag    = weakCell.playerView.tag;
                    
                    // 设置播放控制层和model
                    [weakSelf.playerView playerControlView:nil playerModel:playerModel];
                    // 下载功能
                    weakSelf.playerView.hasDownload = NO;
                    
                    // 自动播放
                    [weakSelf.playerView autoPlayTheVideo];
                }else{
                    [MOMProgressHUD showErrorWithStatus:@"该视频已下架"];
                }
                
            };
            
//            [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
            [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"] placeholderImage:@"默认图片" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];//封面图
            cell.titleLabel.text = [dic objectForKey:@"TITLE"]; //标题
            [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];
            
            NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];
            
            if (name&&![name isKindOfClass:[NSNull class]]) {
                cell.nameLabel.text = name;
            }else{
                cell.nameLabel.text = @"";
            }
            
            
            NSString *sjStr = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
            cell.timelLabel.text = sjStr; //时间地点
            
            
            cell.typelLabel.text = [dic objectForKey:@"PROJECT_STATE"];
            
            cell.detailLabel.text = [dic objectForKey:@"INTRO"];
            NSString *tsStr = [[dic objectForKey:@"REMAIN_DAYS"] stringValue];
            NSString *rsStr = [[dic objectForKey:@"ENROLL_COUNT"] stringValue];
            NSString *zjStr = [[dic objectForKey:@"REAL_AMOUNT"] stringValue];
            
            NSString *trzStr = [NSString stringWithFormat:@"剩余天数:%@    报名人数:%@    筹得资金:%@",tsStr,rsStr,zjStr];//@"14";
            
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:trzStr];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[trzStr rangeOfString:tsStr]];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[trzStr rangeOfString:rsStr]];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[trzStr rangeOfString:zjStr]];
            cell.tsLabel.attributedText = attrStr;
            
            
            NSInteger ifFlollow = [[dic objectForKey:@"IF_FOLLOW"] integerValue];
            if (ifFlollow==0) {
                cell.observeBtn.selected =  NO;
            }else{
                cell.observeBtn.selected =  YES;
            }
            
           
        }
        
        return cell;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:FIRST_STORYBOARD bundle:nil];
//    ASHFirstDetailTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
//    ctl.dataDic = _dataArr[indexPath.row];
//    //    ctl.projectData = _dataArr[indexPath.row];
//    [self.navigationController pushViewController:ctl animated:YES];
    
}
-(void)doObserve:(UIButton *)sender
{
    NSDictionary *dic =  _dataArr[sender.tag];
    
    if (![ASHMainUser authorization]) {
        [self showLogin];
    }else{
        if(!sender.selected){
            sender.selected = YES;//!sender.selected;
            [MOMNetWorking asynRequestByMethod:@"follow" params:@{@"ORGANIZATION_USER_ID":[dic objectForKey:@"USER_ID"]} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
  
                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//                NSDictionary *dic = result;
                if (MOMResultSuccess==ret) {

                }
                
            }];
        }
        

        
    }

}
//让大家看看登录呗
- (void)showLogin {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ASHMinePhoneViewController *minePhoneViewController =  [storyboard instantiateViewControllerWithIdentifier:@"minePhoneViewController"];
    [self presentViewController:minePhoneViewController animated:YES completion:^{
        
    }];
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
         _playerView.stopPlayWhileCellNotVisable = YES;
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
*/

@end
