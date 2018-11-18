//
//  ASHVideoPlayerViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/13.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHVideoPlayerViewController.h"

@interface ASHVideoPlayerViewController ()
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabe;
@property (weak, nonatomic) IBOutlet UIButton *observeBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;


@property(nonatomic,strong)ASHVideoModel *videoModel;
@end

@implementation ASHVideoPlayerViewController
// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateData];
}

-(void)updateData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:_sspId forKey:@"id"];
    
    
    [MOMNetWorking asynRequestByMethod:@"videoInfo.do" params:params publicParams:MOMNetPublicParamUserId|MOMNetPublicParamToken callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
            _videoModel = [ASHVideoModel ModelWithDict:dic];
            _observeBtn.selected = _videoModel.is_friend;
            
            
            [_iconIV ash_setImageWithURL:_videoModel.user_head];
            _titleLabel.text = _videoModel.video_title;
            _detailLabe.text = _videoModel.video_description;
            
            [_zanBtn setTitle:_videoModel.good_num forState:UIControlStateNormal];
            
//            _zanBtn.selected = _videoModel.good_num
            [self doPlay];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_bgView bringSubviewToFront:_bottonView];
            });
        }
    }];
}
-(void)doPlay
{
    NSString *imgURLStr = _videoModel.video_name;
    
    NSString *videoURLStr = _videoModel.video_url;//[videoURLStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];@"http://resource.chouduck.com/projects/20180615115001_8198.mp4";//
        NSURL *videoURL = [NSURL URLWithString:videoURLStr];
        if (videoURL) {
            [_iconIV ash_setImageWithURL:_videoModel.user_head];
//            _titleLabel.text = _videoModel.video_title;
//            _detailLabe.text = _videoModel.video_description;
//            _observeBtn.selected = _videoModel.is_friend;
//            [_zanBtn setTitle:_videoModel.good_num forState:UIControlStateNormal];
            
            ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
            playerModel.title            = _videoModel.video_title;//model.title;
            playerModel.videoURL         = videoURL;
            playerModel.placeholderImageURLString = imgURLStr;//@"http://www.chouduck.com/projects/40/600x290%E9%BB%91%E6%9A%97%E6%8C%91%E6%88%98-01_20170914173735.jpg";//model.coverForFeed;
//            playerModel.scrollView       = self.tableView;
//            playerModel.indexPath        = weakIndexPath;
            // 赋值分辨率字典
            //        playerModel.resolutionDic    = dic;
            // player的父视图tag
//            playerModel.fatherViewTag    = weakCell.playerView.tag;

            playerModel.fatherView = self.bgView;
            // 设置播放控制层和model
            [self.playerView playerControlView:[UIView new] playerModel:playerModel];
            // 下载功能
            self.playerView.hasDownload = NO;
            // 自动播放
            [self.playerView autoPlayTheVideo];
            
            
            
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
- (IBAction)doObserve:(UIButton *)sender {

            //        名称    描述
            //        user_id    用户id
            //        type    用户关系类别
            //        0黑名单（没有拉黑的话，则会拉黑；如果已经在黑名单，再次进行此操作就会移除）
            //        1单向关注（没有关注的话，则会关注；如果已经被关注，再次进行此操作就会取消）
            //        user_fir    被操作的用户id
            //        friend_desc    请求描述
            //        token    uuid32
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:_videoModel.id forKey:@"user_fir"];
            [params setObject:@"1" forKey:@"type"];
            [params setObject:@"1" forKey:@"friend_desc"];
            
            
            [MOMNetWorking asynRequestByMethod:@"beFriend.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
                NSInteger ret = [[result objectForKey:@"ret"] integerValue];
                if (MOMResultSuccess==ret) {
                    sender.selected = YES;
//                    [MOMProgressHUD showErrorWithStatus:@"成功"];
                }else{
                    [MOMProgressHUD showErrorWithStatus:@"失败！请重新操作"];
                }
            }];
       
    
}
- (IBAction)doZan:(UIButton *)sender {
    if (!sender.selected) {
        //        flag    标识
        //        1 点赞
        //        2 收藏
        //        bbs_id    文章id
        //        user_id    用户id
        //        token    传输token
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_videoModel.id forKey:@"bbs_id"];
        [params setObject:@"1" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"insertDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                sender.selected = YES;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"点赞失败"];
            }
        }];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_videoModel.id forKey:@"bbs_id"];
        [params setObject:@"1" forKey:@"flag"];
        
        [MOMNetWorking asynRequestByMethod:@"delDzsc.do" params:params publicParams:MOMNetPublicParamToken|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"ret"] integerValue];
            if (MOMResultSuccess==ret) {
                sender.selected = NO;
            }else{
                [MOMProgressHUD showErrorWithStatus:@"取消点赞失败"];
            }
        }];
    }
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
