//
//  ASHNewsVideoDetailTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHNewsVideoDetailTableViewController.h"

@interface ASHNewsVideoDetailTableViewController (){
    AVAudioPlayer *_audioPlayer;
}
@property(strong,nonatomic)NSArray *dataArr;
@property(strong,nonatomic)ASHBBSModel *bbsModel;
 @property(strong,nonatomic)JWPlayer *player;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end
//static NSInteger const PAGE_COUNT = 10;
@implementation ASHNewsVideoDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASHVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASHVideoTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1PTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASH1PTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH3PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell3P"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1VCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1V"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    _dataArr = [NSArray array];
    //    [self refreshLogo];
    //     [self refreshData];
    // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [MOMFilter registerFliterIn:self];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player pause];
    _player = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDataUP];
    [self refreshDataDetail];
}

//数据源
-(void)refreshDataDetail{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_detailId forKey:@"id"];
    
    [MOMNetWorking asynRequestByMethod:@"mainBbsById.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            ASHBBSModel *model = [ASHBBSModel ModelWithDict:dic];
            _bbsModel = model;
            [self.tableView reloadData];
//            NSString *headHTMLStr = [NSString stringWithFormat:@"<h1>%@</h1><p style='red'><span style='color:gray;'>%@  %@</span></p><br>%@",model.bbs_title,model.user_nick,model.bbs_time,model.bbs_content];
            
//            [_webView loadHTMLString:headHTMLStr baseURL:nil];
            
//            _collectBtn.selected = model.is_store;
            //            _dataArr = [dic objectForKey:@"list"];
            //            _logoArr = [ASHLogoModel ModelsWithArray:[dic objectForKey:@"list"]];
            //            [self.tableView reloadData];
        }
    }];
}

-(void)refreshDataUP{
    
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
    [params setObject:@"1" forKey:@"type"];
    
    [MOMNetWorking asynRequestByMethod:@"sameBbsList.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
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
   
}

-(void)play{
    NSURL *url= [NSURL URLWithString:@"http://221.238.104.60:81/music/1/vrmuseum_yinyue_adata/sounds/z10"];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    
    NSError *error=nil;
    //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
    //     _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    _audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:&error];
    //设置播放器属性
    _audioPlayer.numberOfLoops=10000;//设置为0不循环
    _audioPlayer.delegate=self;
    
    [_audioPlayer prepareToPlay];//加载音频文件到缓存
    [_audioPlayer play];
}

-(void)pause{
    [_audioPlayer pause];
}
- (IBAction)doCollect:(UIButton *)sender {
    if (!sender.selected) {
        //        flag    标识
        //        1 点赞
        //        2 收藏
        //        bbs_id    文章id
        //        user_id    用户id
        //        token    传输token
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_detailId forKey:@"bbs_id"];
        [params setObject:@"2" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"insertDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                _collectBtn.selected = YES;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"收藏失败"];
            }
        }];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_detailId forKey:@"bbs_id"];
        [params setObject:@"2" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"delDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                _collectBtn.selected = NO;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"取消收藏失败"];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_player pause];
    _player = nil;
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0&&indexPath.row==0) {
        return 425;
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArr.count>0?1:0+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *cellNames = @[@"cpsMainCellLB",@"ASH1PTableViewCell",@"cpsMainCell3P",@"cpsMainCell1V"];
    if (0==indexPath.row) {
        ASHVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHVideoTableViewCell" forIndexPath:indexPath];
        __block NSIndexPath *weakIndexPath = indexPath;
//        __block
        ASHVideoTableViewCell *weakCell     = cell;
//        __weak
        typeof(self)  weakSelf      = self;
        ASHBBSModel *model = _bbsModel;
        
        NSString *headHTMLStr = [NSString stringWithFormat:@"<h1>%@</h1><p style='red'><span style='color:gray;'>%@  %@</span></p><br>%@",model.bbs_title,model.user_nick,model.bbs_time,model.bbs_content];
        
        [cell.webView loadHTMLString:headHTMLStr baseURL:nil];
        
        CGRect rect = cell.videoView.frame;
        //            rect.origin.y =  rect.origin.y;
        //            rect.size.height =  rect.size.height-100;
        //            float ff = MOMScreenBounds.size.width;
        if (!_player) {
            //                            rect.size.width =  ff;
            _player=[[JWPlayer alloc]initWithFrame:rect];
            //            [player updatePlayerWith:[NSURL URLWithString:video]];
            [_player updatePlayerWith:[NSURL URLWithString:@"http://39.105.46.149:8080/cps/userfiles/41/flash/ssp/2018/09/1536245834138_1.mp4"]];
            
            //            [cell addSubview:player];'
            
            [_player showInSuperView:cell.videoView andSuperVC:self];
            //                [_player pause];
        }else{
            _player.frame = rect;
        }
        return cell;
        // 点击播放的回调
//        cell.playBlock = ^(UIButton *btn){
      /*
            NSString *imgURLStr = model.bbs_minPic;// [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"COVER_HREF"]];
        NSString *videoURLStr2 = @"http://resource.chouduck.com/projects/20180615115001_8198.mp4";//imgURLStr;// [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"VIDEO_HREF"]];
            NSString *videoURLStr =  [videoURLStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *videoURL = [NSURL URLWithString:videoURLStr];
            if (videoURL) {
                ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
                playerModel.title            = @"";//model.title;
                playerModel.videoURL         = videoURL;
                playerModel.placeholderImageURLString = imgURLStr;//@"http://www.chouduck.com/projects/40/600x290%E9%BB%91%E6%9A%97%E6%8C%91%E6%88%98-01_20170914173735.jpg";//model.coverForFeed;
                playerModel.scrollView       = weakSelf.tableView;
                playerModel.indexPath        = indexPath;
                // 赋值分辨率字典
                //        playerModel.resolutionDic    = dic;
                // player的父视图tag
                playerModel.fatherViewTag    = weakCell.videoView.tag;
                playerModel.fatherView = weakCell.videoView;
                // 设置播放控制层和model
                [weakSelf.playerView playerControlView:nil playerModel:playerModel];
                // 下载功能
                weakSelf.playerView.hasDownload = NO;
                // 自动播放
                [weakSelf.playerView autoPlayTheVideo];
            }else{
                [MOMProgressHUD showErrorWithStatus:@"该视频已下架"];
            }
//        };
       
        return weakCell;
        */
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
                [cell.image1 ash_setImageWithURL:images.count>1?images[0]:@""];
               
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
                [cell.image1 ash_setImageWithURL:images.count>1?images[0]:@""];
                
            }else{
                [cell.image1 ash_setImageWithURL:model.bbs_minPic];
            }
            
            tcell = cell;
        }
        return tcell;
    }
    
    return nil;
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
