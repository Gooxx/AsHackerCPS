//
//  ASHFirstDetailTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/22.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstDetailTableViewController.h"

@interface ASHFirstDetailTableViewController (){
//    NSArray *_dataArr;
//    NSInteger _showType;//0 all 1 doing 2 end
    
//    NSDictionary *_projectData;//头
    
    NSArray *_projectArr;//主办国的活动
    
    NSArray *_supporertArr;//支持者
    
    NSAttributedString *_projectAttributeString;//详情富文本
    
    float _s1h;//section 1 de gaodu
    
    UIActivityIndicatorView *_activityIndicatorView ;
}

@property(nonatomic,assign)NSInteger selectCellNum;
@property(strong,nonatomic) ASHAlertView *alert;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ASHFirstDetailTableViewController
// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
   
    [self checkCanJoin];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"ASHFirstDetailSupportTableViewCell" bundle:nil] forCellReuseIdentifier:@"bbcell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"ASHPublisherMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASHPublisherMainTableViewCell"];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"右部选择"] style:UIBarButtonItemStylePlain target:self action:@selector(showSahre)];
    self.navigationItem.rightBarButtonItem =barBtn;
    self.bottomView.alpha = 0;
   
}

//用户是否能参与
-(void)checkCanJoin
{
    [MOMNetWorking asynRequestByMethod:@"canEnroll" params:@{@"PROJECT_ID":[_dataDic objectForKey:@"PROJECT_ID"]} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
    
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
             NSInteger canJoin = [[dic objectForKey:@"data"]integerValue];
            if (canJoin==1){
                if (_joinBtn.enabled==YES) {
                    _joinBtn.backgroundColor = MOMLightOrangeColor;
                    _joinBtn.enabled = YES;
                }
                
            }else{
                _joinBtn.backgroundColor = MOMWhiteGrayColor;
                _joinBtn.enabled = NO;
            }
//            {"statusCode":0,"data":"0"} 不能报名，灰色
//            {"statusCode":0,"data":"1"} 能报名
        }
        
        [UIView animateWithDuration:1.5 animations:^{
            self.bottomView.alpha = 1;
        }];
        
    }];
    
}
//数据源
-(void)refreshData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
           NSString *method = [NSString stringWithFormat:@"project/%@",[_dataDic objectForKey:@"PROJECT_ID"]];
        [MOMNetWorking asynRequestByMethod:method params:nil publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _projectData = [[dic objectForKey:@"project"] firstObject];
                _projectArr = [dic objectForKey:@"priorProjects"];
                _supporertArr = [dic objectForKey:@"supports"];
                
                if (_projectData&&[_projectData objectForKey:@"TITLE"]) {
                     self.navigationItem.title = [_projectData objectForKey:@"TITLE"];
                }

                //是否在可参与期限内
                NSInteger remainDays = [[_projectData objectForKey:@"REMAIN_DAYS"]integerValue];//
                if (remainDays>0) {
                    if (_joinBtn.enabled==YES) {
                        _joinBtn.backgroundColor = MOMLightOrangeColor;
                        _joinBtn.enabled = YES;
                    }
                }else{
                    _joinBtn.backgroundColor = MOMWhiteGrayColor;
                    _joinBtn.enabled = NO;
                }
                
                NSString *htmlString = [NSString stringWithFormat:@"<body >%@</body>",[_projectData objectForKey:@"CONTENT"]];
                [htmlString stringByReplacingOccurrencesOfString:@"http://www.chouduck.com" withString:@"http://resource.chouduck.com"];

//                "FUND_BEGIN_DATE":"2017-09-21",  // 众筹开始时间
//                "FUND_END_DATE":"2017-09-22",  // 众筹结束时间
                
//                "BEGIN_DATE":"2017-09-21",  // 活动开始时间
//                "END_DATE":"2017-09-25",  // 活动结束时间

                
                //提前构建富文本框，后面确定大小，以后少用富文本符合结构，天生的缺陷啊
                _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 633, SCREEN_WIDTH-20, 1)];
                _webView.userInteractionEnabled = NO;
                _webView.scalesPageToFit = NO;
                _webView.delegate =self;
                
                UIActivityIndicatorView *activityIndicatorView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                [activityIndicatorView startAnimating];
                activityIndicatorView.center = CGPointMake(self.view.center.x, 610);
                [self.view addSubview:activityIndicatorView];
                _activityIndicatorView = activityIndicatorView;
                [_webView loadHTMLString:htmlString baseURL:nil];
                [self.tableView addSubview:_webView];
                [self.tableView reloadData];
                
            }
        }];
}
//弹个菜单 选一下分享还是举报，可以重新封装一下 TODO
-(void)showSahre{
    
    if(!_alert||![self.view.subviews containsObject:_alert]){
        _alert =  [ASHAlertView alterDetailMenuView];
        _alert.delegate = self;
          [[[UIApplication sharedApplication].delegate window] addSubview:_alert];
    }else{
        [_alert removeFromSuperview];
        _alert = nil;
    }
}

//分享
- (void)doShare:(id)sender {

    NSDictionary *dic = _dataDic;
    NSString *title =[dic objectForKey:@"TITLE"];//标题
    NSString *place = [dic objectForKey:@"INTRO"];
    NSString *img = [NSString stringWithFormat:@"%@%@",HTTPURLCDN,[dic objectForKey:@"COVER_HREF"]];//封面图
    NSString *projectid =[_dataDic objectForKey:@"PROJECT_ID"];
    NSString *web =  [NSString stringWithFormat:@"http://www.chouduck.com/m/project/%@",projectid];
    
    [AshShareUM doShareWithTitle:title img:img detail:place web:web];

}
//望文而知意 ，为什么是个假的呢，因为没地方展示啊
- (void)doReport:(id)sender {
    [MOMProgressHUD showSuccessWithStatus:@"举报啦"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//本来是有一个三级section的
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}
////
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//        if (section==2) {
//            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(10, 0, 375, 30)];
////            view.backgroundColor = [UIColor redColor];
//            UILabel *label =[[UILabel alloc]initWithFrame:view.bounds];
//            label.text = @"发起过的活动";
//            label.textColor = MOMLightGrayColor;
//            [view addSubview:label];
//            return view;
//        }
//        return nil;
//}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==1&&_selectCellNum==0) {
        return _s1h+50;
        
    }else if(indexPath.section ==2&&_selectCellNum==1) {
      
        return (_projectArr.count/2+_projectArr.count%2)*200+60;
        
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            
            switch (_selectCellNum) {
                case 0:
                    return 1;
                    break;
                case 1:
                    return 1;
                    break;
                case 2:
                    return _supporertArr.count;
                    break;
                    
                default:
                    return 0;
                    break;
            }
            break;
        case 2:
//            if (_selectCellNum==1) {
                return 0;//_projectArr.count;
//            }else{
//                return 0;
//            }
            
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
                ASHFirstDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
                [cell.joinBtn addTarget:self action:@selector(doJoin:) forControlEvents:UIControlEventTouchUpInside];
                [cell.supportBtn addTarget:self action:@selector(doSupport:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.supporterBtn addTarget:self action:@selector(showSupporter:) forControlEvents:UIControlEventTouchUpInside];
                [cell.mySupportBtn addTarget:self action:@selector(showMySupport:) forControlEvents:UIControlEventTouchUpInside];
                [cell.publisherBtn addTarget:self action:@selector(showPublisher:) forControlEvents:UIControlEventTouchUpInside];
                
                
                NSDictionary *dic = _projectData;//_dataArr[indexPath.row];
       
                __block NSIndexPath *weakIndexPath = indexPath;
                __block ASHFirstDetailTableViewCell *weakCell     = cell;
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
                if (dic) {
                    
                    [cell showDetailData:dic];
                    NSString *beginTime = [_projectData objectForKey:@"FUND_BEGIN_DATE"];
                    NSString *endTime = [_projectData objectForKey:@"FUND_END_DATE"];
                    BOOL ended = [MOMTimeHelper validateWithStartTime:beginTime withExpireTime:endTime];
                    if (!ended) {
                        cell.supportBtn.selected = YES;
                    }else{
                        cell.supportBtn.selected = NO;
                    }

                }
                return cell;
          }else if (indexPath.section ==1) {
              _webView.hidden = YES;
                if (_selectCellNum==2) {// 支持者们啊
                    
                    ASHFirstDetailSupportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbcell" forIndexPath:indexPath];
                    
                    NSDictionary *dic = _supporertArr[indexPath.row];
                    [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"AVATAR_HREF"]];
                    
                    NSString *name = [dic objectForKey:@"REAL_NAME"];
                    NSString *time = [dic objectForKey:@"STATE_TIME"];
                    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",name,time];
                    NSString *info = [NSString stringWithFormat:@" %@",[dic objectForKey:@"COMMENT"]];
                    cell.detailLabel.text = info;
                    
                    NSString *amount = [dic objectForKey:@"AMOUNT"];
                    cell.zjLabel.text = [NSString stringWithFormat:@"支持了%@元",amount];
                    return cell;
                }else if (_selectCellNum==1) {
                    
                    ASHPublisherMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHPublisherMainTableViewCell" forIndexPath:indexPath];

                    NSDictionary *dic = _projectData;//_dataArr[indexPath.row];

                    __block NSIndexPath *weakIndexPath = indexPath;
                    __block ASHPublisherMainTableViewCell *weakCell     = cell;
                    __weak typeof(self)  weakSelf      = self;
                    // 点击播放的回调
                    cell.playBlock = ^(UIButton *btn){
                        NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"PHOTO_HREF"]];
                        NSString *videoURLStr2 = [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"U1_VIDEO_HREF"]];
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
                    cell.observeBtn.hidden= YES;
                    cell.labView.frame = CGRectZero;
                    [cell showDetailData:dic];
                    
                    return cell;
                }else{
                    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
                    _webView.hidden = NO;
                    return cell;
                }
       
    }else {
            ASHFirstDetailCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHFirstDetailCollectTableViewCell" forIndexPath:indexPath];
             if (_selectCellNum==1) {
                cell.titileLabel.text = @"发起过的活动";
             }else{
                 cell.titileLabel.text = @"";
             }
            cell.collectionView.delegate = self;
            cell.collectionView.dataSource = self;
            [cell.collectionView reloadData];
            return cell;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat high=0.0;
    high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue*2/3.0f;
    CGRect frame = [webView frame];
    frame.size.height = high;
    // 方法三 （不推荐使用，当webView.scalesPageToFit = YES计算的高度不准确）
    CGFloat height3 = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    _s1h = height3;
    //方法二：
    frame.size.width= SCREEN_WIDTH-20;
    frame.size.height=1;//这步不能少，不然webView.scrollView.contentSize.height为零
    webView.frame= frame;
    frame.size.height= webView.scrollView.contentSize.height;
    webView.frame= frame;
    webView.scrollView.scrollEnabled=NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [_activityIndicatorView stopAnimating];
}

//我要参与
- (IBAction)doJoin:(id)sender {
//}
    
//    [ASHMainUser setPhoneNumber:nil];
    //**************************************
    BOOL b = [[_projectData objectForKey:@"IF_VOLUNTEER"]boolValue];
    if (b) {
        ASHAlertView *alert = [[ASHAlertView alloc]init];
        alert.delegate = self;
        [[[UIApplication sharedApplication].delegate window] addSubview:alert];
    }else{
        [self doJoin2:nil];
    }

    
}
- (void)doJoin2:(id)sender{
    if (![ASHMainUser authorization]) {
        [self showLogin];
    }else if (![ASHMainUser getPhoneNumber]) {
        UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        ASHMineUserSimpleViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewController"];
        ctl.delegate = self;
        UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewControllerNavi"];
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }else{
        
        NSString *projectId = [_dataDic objectForKey:@"PROJECT_ID"];

        [MOMNetWorking asynRequestByMethod:@"enroll" params:@{@"PROJECT_ID":projectId} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            if (MOMResultSuccess==ret) {
                [MOMProgressHUD showSuccessWithStatus:@"报名成功"];
                
                ASHFirstJoinSuccessViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHFirstJoinSuccessViewController"];
                ctl.dataDic = result;
                
                [self.navigationController pushViewController:ctl animated:YES];
                ctl.navigationItem.title = self.navigationItem.title;
            }
        }];
    }
}


- (IBAction)beVolunteer:(id)sender
{
    if (![ASHMainUser authorization]) {
        [self showLogin];
    }
    else{
        //        [MOMProgressHUD showSuccessWithStatus:@"没填电话哦 不能参与"];
        UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        ASHMineUserSimpleViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewController"];
        //        ctl.dataDic = result;
        ctl.delegate = self;
         ctl.projectId = [_dataDic objectForKey:@"PROJECT_ID"];
        UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewControllerNavi"];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}
- (void)doSupport:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    if (![ASHMainUser authorization]) {
        [self showLogin];
    }else if (![ASHMainUser getPhoneNumber]) {
        UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        ASHMineUserSimpleViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewController"];
        ctl.delegate = self;
        UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewControllerNavi"];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }else{
        ASHSupportTableViewController *ctl =[self.storyboard instantiateViewControllerWithIdentifier:@"ASHSupportTableViewController"];
//        ctl.dataDic = _dataDic;
        ctl.dataDic = _projectData;
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

//让大家看看登录呗
- (void)showLogin {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ASHMinePhoneViewController *minePhoneViewController =  [storyboard instantiateViewControllerWithIdentifier:@"minePhoneViewController"];
    [self presentViewController:minePhoneViewController animated:YES completion:^{
        
    }];
}

- (void)showSupporter:(UIButton *)sender {
    [self doChange:sender];
}
- (void)showMySupport:(UIButton *)sender {
    [self doChange:sender];
}
- (void)showPublisher:(UIButton *)sender {
    [self doChange:sender];
}


- (void)doChange:(UIButton *)sender {
    _selectCellNum = sender.tag;
    ASHFirstDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGPoint centerP =  cell.lineLabel.center;
    centerP.x = sender.center.x;
    cell.lineLabel.center = centerP;
    cell.supporterBtn.selected = NO;
    cell.mySupportBtn.selected = NO;
    cell.publisherBtn.selected = NO;
     sender.selected =  YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _projectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _projectArr[indexPath.row];
    ASHMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccell" forIndexPath:indexPath];
//    [cell.picIV ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];
    [cell.picIV ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"] placeholderImage:@"默认图片" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];//封面图

    cell.detailLabel.text = [dic objectForKey:@"INTRO"];
    cell.timelLabel.text = [dic objectForKey:@"BEGIN_DATE"];
//    cell.lab0.text = [dic objectForKey:@"CATEGORY"];
    return cell;
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
*/

@end
