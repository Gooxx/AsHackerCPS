//
//  ASHMainTableViewCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/24.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+ASH.h"

@interface ASHMainTableViewCell : UITableViewCell<UIWebViewDelegate>
@property(nonatomic,strong)UIView *playerView;
@property(nonatomic,strong)UIImageView *playerViewBG;//

@property(nonatomic,strong)UILabel *titleLabel;//标题
@property(nonatomic,strong)UIImageView *iconIV;//头像
@property(nonatomic,strong)UILabel *nameLabel;//名字
@property(nonatomic,strong)UILabel *rzLabel;//认证

@property(nonatomic,strong)UIImageView *picIV;//图片
@property(nonatomic,strong)UILabel *lab0;//标签0
@property(nonatomic,strong)UILabel *lab1;//标签1
@property(nonatomic,strong)UILabel *lab2;//标签2
@property(nonatomic,strong)UILabel *lab3;//标签3

@property(nonatomic,strong)UIProgressView *progressView;//进度条
//@property(nonatomic,strong)UISlider  *slider;//进度条


@property(nonatomic,strong)UILabel *tsLabel;//剩余天数
@property(nonatomic,strong)UILabel *rsLabel;//报名人数
@property(nonatomic,strong)UILabel *zjLabel;//筹得资金

@property(nonatomic,strong)UILabel *mbjeLabel;//目标金额

@property(nonatomic,strong)UILabel *detailLabel;//详解简介
@property(nonatomic,strong)UIWebView *detailWebView;//详解简介webview

@property(nonatomic,strong)UILabel *timelLabel;//时间地点
@property(nonatomic,strong)UILabel *typelLabel;//进行中 状态

@property(nonatomic,strong)UILabel *areaLabel;//地点
@property(nonatomic,strong)UILabel *hdrsLabel;//活动人数
@property(nonatomic,strong)UILabel *areatimeLabel;//地点+时间
@property(nonatomic,strong)UILabel *phoneLabel;//电话

@property(nonatomic,strong)UIButton *showDetailBtn;//查看活动按钮

@property (nonatomic, strong) UIButton                      *playBtn;


@property (nonatomic, copy  ) void(^playBlock)(UIButton *);

-(void)showMainData:(NSDictionary *)dic;

-(void)showDetailData:(NSDictionary *)dic;

-(void)showMineData:(NSDictionary *)dic;

-(void)showMyProjectData:(NSDictionary *)dic;
@end
