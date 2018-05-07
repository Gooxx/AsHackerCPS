//
//  ASHMainTableViewCell.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/24.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMainCollectionViewCell.h"

@implementation ASHMainCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _playerView = [self viewWithTag:1000];//视频播放器
    
    _playerViewBG = [self viewWithTag:1001];//视频播放器 封面图
    
    _titleLabel = [self viewWithTag:1002];//标题
    _iconIV = [self viewWithTag:1003];//头像
    _nameLabel = [self viewWithTag:1004];//名字
    _rzLabel = [self viewWithTag:1005];//认证
    
    _picIV = [self viewWithTag:1006];//图片
    
    _lab0 = [self viewWithTag:1007];//标签0
    _lab1 = [self viewWithTag:1008];//标签1
    _lab2 = [self viewWithTag:1009];//标签2
    
    
    _progressView = [self viewWithTag:2000];//进度条
//   _slider = [self viewWithTag:2000];//进度条
//    _slider.userInteractionEnabled = NO;
    
    
    _tsLabel = [self viewWithTag:2001];//剩余天数
    _rsLabel = [self viewWithTag:2002];//报名人数
    _zjLabel = [self viewWithTag:2003];//筹得资金
    
    _mbjeLabel = [self viewWithTag:2004];//目标金额
    
    _detailLabel = [self viewWithTag:3001];//详解简介
    _detailWebView = [self viewWithTag:3002];//详解简介  webview
    _detailWebView.delegate = self;
    
    _timelLabel = [self viewWithTag:4001];//时间
    _typelLabel = [self viewWithTag:4002];//进行中 状态
    
    _areaLabel = [self viewWithTag:4003];//地点
    _hdrsLabel = [self viewWithTag:4004];//活动人数
    
    _areatimeLabel = [self viewWithTag:4005];//地点 时间
    
    // 代码添加playerBtn到imageView上
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    self.playBtn.frame = self.playerView.bounds;
//    self.playBtn.backgroundColor = [UIColor redColor];
    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.playBtn];

}

- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{   //设置webView高度
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
}

@end
