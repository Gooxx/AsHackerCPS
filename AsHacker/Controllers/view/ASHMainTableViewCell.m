//
//  ASHMainTableViewCell.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/24.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMainTableViewCell.h"

@implementation ASHMainTableViewCell

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
    _lab3 = [self viewWithTag:1010];//标签3
    
    _progressView = [self viewWithTag:2000];//进度条
    CGRect rect = _progressView.frame;
    rect.size.height = 10;
    _progressView.frame = rect;
    _progressView.tintColor = MOMProgressOrangeColor;
    _progressView.trackTintColor = MOMWhiteGrayColor;
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
//    [_timelLabel drawTextInRect:UIEdgeInsetsInsetRect(_timelLabel.frame, UIEdgeInsetsMake(2, 5, 2, 5))];
    
    _typelLabel = [self viewWithTag:4002];//进行中 状态
    
    _areaLabel = [self viewWithTag:4003];//地点
    _hdrsLabel = [self viewWithTag:4004];//活动人数
    
    _areatimeLabel = [self viewWithTag:4005];//地点 时间
    
    _phoneLabel = [self viewWithTag:4006];//电话
    _areatimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    _beinglLabel = [self viewWithTag:4007];//进行中 状态
    
    _showDetailBtn = [self viewWithTag:5001];//查看活动按钮
    
    
    // 代码添加playerBtn到imageView上
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    self.playBtn.frame = self.playerView.bounds;
//    self.playBtn.backgroundColor = [UIColor redColor];
    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.playBtn];
//    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.picView);
//        make.width.height.mas_equalTo(50);
//    }];
    
//    UIView *playerView = [self viewWithTag:1000];//视频播放器
//    
//    UILabel *titleLabel = [self viewWithTag:1002];//标题
//    UIImageView *iconIV = [self viewWithTag:1003];//头像
//    UIView *nameLabel = [self viewWithTag:1004];//名字
//    UILabel *rzLabel = [self viewWithTag:1005];//认证
//    
//    UILabel *tsLabel = [self viewWithTag:2001];//剩余天数
//    UILabel *rsLabel = [self viewWithTag:2002];//报名人数
//    UILabel *zjLabel = [self viewWithTag:2003];//筹得资金
//    
//    UILabel *detailLabel = [self viewWithTag:3001];//详解简介
//    
//    UILabel *timelLabel = [self viewWithTag:4001];//时间地点
//    UILabel *typelLabel = [self viewWithTag:4002];//进行中 状态
}
//展示数据
-(void)showMainData:(NSDictionary *)dic
{
    ASHMainTableViewCell * cell = self;
    [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"] placeholderImage:@"默认图片" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];//封面图
    
    NSString *titleStr = [dic objectForKey:@"TITLE"]; //标题
    if (titleStr) {
        NSMutableAttributedString *titleattrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        NSMutableParagraphStyle * titleparagraphStyle = [[NSMutableParagraphStyle alloc]init];
        //               //设置行间距
        [titleparagraphStyle setLineSpacing:8];
        //NSParagraphStyleAttributeName;(段落)
        [titleattrStr addAttribute:NSParagraphStyleAttributeName value:titleparagraphStyle range:NSMakeRange(0, [titleattrStr length])];
        [titleattrStr addAttribute:NSForegroundColorAttributeName
                             value:MOMDarkGrayColor
                             range:NSMakeRange(0, [titleattrStr length])];
        [titleattrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:NSMakeRange(0, [titleattrStr length])];
        cell.titleLabel.attributedText = titleattrStr;
    }
    
    
    [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];
    NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];
    if (name&&![name isKindOfClass:[NSNull class]]) {
        cell.nameLabel.text = name;
    }else{
        cell.nameLabel.text = @"";
    }
    
    NSString *tsStr = [[dic objectForKey:@"REMAIN_DAYS"] stringValue];
    NSString *rsStr = [[dic objectForKey:@"ENROLL_COUNT"] stringValue];
    NSString *zjStr = [[dic objectForKey:@"REAL_AMOUNT"] stringValue];
//    NSString *trzStr = [NSString stringWithFormat:@"剩余天数:%@    报名人数:%@    筹得资金:%@",tsStr,rsStr,zjStr];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:trzStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    
    
    NSString *tsStr2 = [NSString stringWithFormat:@"剩余天数:%@    ",tsStr];
    NSMutableAttributedString *tsAttrStr = [[NSMutableAttributedString alloc] initWithString:tsStr2];
    [tsAttrStr addAttribute:NSForegroundColorAttributeName
                    value:MOMOrangeColor
                    range:[tsStr2 rangeOfString:tsStr]];
    
    NSString *rsStr2 = [NSString stringWithFormat:@"报名人数:%@    ",rsStr];
    NSMutableAttributedString *rsAttrStr = [[NSMutableAttributedString alloc] initWithString:rsStr2];
    [rsAttrStr addAttribute:NSForegroundColorAttributeName
                    value:MOMOrangeColor
                    range:[rsStr2 rangeOfString:rsStr]];
    
    NSString *zjStr2 = [NSString stringWithFormat:@"筹得资金:%@ ",zjStr];
    NSMutableAttributedString *zjAttrStr = [[NSMutableAttributedString alloc] initWithString:zjStr2];
    [zjAttrStr addAttribute:NSForegroundColorAttributeName
                    value:MOMOrangeColor
                    range:[zjStr2 rangeOfString:zjStr]];
    [attrStr appendAttributedString:tsAttrStr];
    [attrStr appendAttributedString:rsAttrStr];
    [attrStr appendAttributedString:zjAttrStr];
    
    cell.tsLabel.attributedText = attrStr;
    
    
    
    NSMutableAttributedString *infoattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"INTRO"]];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
    //               //设置行间距
    [paragraphStyle1 setLineSpacing:8];
    //NSParagraphStyleAttributeName;(段落)
    [infoattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoattrStr length])];

    cell.detailLabel.attributedText = infoattrStr;
//    cell.detailLabel.text =[dic objectForKey:@"INTRO"] ;
    
    NSString *sjStr = [NSString stringWithFormat:@"  %@ %@\t",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
//    NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
    //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
    NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:sjStr];
//    [retMsTR addAttribute:NSForegroundColorAttributeName
//                    value:MOMOrangeColor
//                    range:[amount rangeOfString:tStr]];
//    [attrStr appendAttributedString:retMsTR];
    cell.areatimeLabel.attributedText = retMsTR;
//    cell.areatimeLabel.text = sjStr; //时间地点
//     cell.areatimeLabel.lineBreakMode =
//    NSLineBreakByWordWrapping = 0,     	// Wrap at word boundaries, default
//    NSLineBreakByCharWrapping,		// Wrap at character boundaries
//    NSLineBreakByClipping,		// Simply clip
//    NSLineBreakByTruncatingHead,	// Truncate at head of line: "...wxyz"
//    NSLineBreakByTruncatingTail,	// Truncate at tail of line: "abcd..."
//    NSLineBreakByTruncatingMiddle
    
    cell.typelLabel.text = [dic objectForKey:@"PROJECT_STATE"];//进行中
    
    
    
    /*
    float ta =  [[dic objectForKey:@"TOTAL_AMOUNT"]floatValue];;
    float ra = [[dic objectForKey:@"REAL_AMOUNT"]floatValue];
    float blf = (ra/ta);
    //        NSString *blStr = [NSString stringWithFormat:@"已达到:%.0f %%",blf*100];
    cell.progressView.progress = blf;
    
    
    //    [cell.picIV ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];
    //    cell.playerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage ima]];
     */
    
}

-(void)showDetailData:(NSDictionary *)dic
{
    ASHMainTableViewCell * cell = self;
    
    [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
    
//    cell.titleLabel.text = [dic objectForKey:@"TITLE"]; //标题
    NSMutableAttributedString *titleattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"TITLE"]];
    NSMutableParagraphStyle * titleparagraphStyle = [[NSMutableParagraphStyle alloc]init];
    //               //设置行间距
    [titleparagraphStyle setLineSpacing:8];
    //NSParagraphStyleAttributeName;(段落)
    [titleattrStr addAttribute:NSParagraphStyleAttributeName value:titleparagraphStyle range:NSMakeRange(0, [titleattrStr length])];
    [titleattrStr addAttribute:NSForegroundColorAttributeName
                         value:MOMDarkGrayColor
                         range:NSMakeRange(0, [titleattrStr length])];
    [titleattrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:NSMakeRange(0, [titleattrStr length])];
    cell.titleLabel.attributedText = titleattrStr;

    
    [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"U1_LOGO_HREF"]];
    NSString *name = [dic objectForKey:@"U1_ORGANIZATION_NAME"];
    if (name&&![name isKindOfClass:[NSNull class]]) {
        cell.nameLabel.text = name;
    }else{
        cell.nameLabel.text = @"";
    }
    
    NSString *sjStr = [NSString stringWithFormat:@"  %@ %@  ",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
    //    NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
    //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
    NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:sjStr];
    //    [retMsTR addAttribute:NSForegroundColorAttributeName
    //                    value:MOMOrangeColor
    //                    range:[amount rangeOfString:tStr]];
    //    [attrStr appendAttributedString:retMsTR];
    cell.areatimeLabel.attributedText = retMsTR;

    
    NSArray *categoryArr = [dic objectForKey:@"CATEGORY"];
    if ([categoryArr isKindOfClass:[NSArray class]]) {
        for (NSInteger i=0; i<categoryArr.count; i++) {
            switch (i) {
                case 0:
                    cell.lab0.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@   ",categoryArr[0]]];
                    //                cell.lab0.text = [NSString stringWithFormat:@"   %@  .",categoryArr[0]];
                    cell.lab0.hidden = NO;
                    break;
                case 1:
                    //                cell.lab1.text = [NSString stringWithFormat:@"   %@  .",categoryArr[1]];
                    cell.lab1.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@   ",categoryArr[1]]];
                    cell.lab1.hidden = NO;
                    break;
                case 2:
                    //                cell.lab2.text = [NSString stringWithFormat:@"   %@  .",categoryArr[2]];
                    cell.lab2.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@   ",categoryArr[2]]];
                    cell.lab2.hidden = NO;
                    break;
                default:
                    break;
            }
        }
    }else{
        cell.lab0.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  ",categoryArr]];
        //                cell.lab0.text = [NSString stringWithFormat:@"   %@  .",categoryArr[0]];
        cell.lab0.hidden = NO;
    }
   
    
    
    
    //                NSString *sjStr = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
    cell.timelLabel.text = [NSString stringWithFormat:@"活动时间：%@",[dic objectForKey:@"BEGIN_DATE"]]; //时间
    cell.areaLabel.text = [NSString stringWithFormat:@"活动地点：%@",[dic objectForKey:@"ADDRESS"]]; //地点
   
    NSString *enrollcount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ENROLL_COUNT"]];
    NSString *personlimit = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PERSON_LIMIT"]];
    NSString *rsbStr = [NSString stringWithFormat:@"活动人数：%@/%@",enrollcount,personlimit];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:rsbStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MOMOrangeColor
                    range:[rsbStr rangeOfString:enrollcount]];
//    cell.hdrsLabel.text = rsbStr; // "ENROLL_COUNT":1,  // 已报名人数  "PERSON_LIMIT":50,  // 人数上限
    cell.hdrsLabel.attributedText = attrStr;
    
    
    cell.detailLabel.text = [dic objectForKey:@"INTRO"];

//    cell.typelLabel.text = [dic objectForKey:@"PROJECT_STATE"];
    
    NSString *tsStr = [[dic objectForKey:@"REMAIN_DAYS"] stringValue];
    NSString *rsStr = [[dic objectForKey:@"ENROLL_COUNT"] stringValue];
    NSString *zjStr = [[dic objectForKey:@"REAL_AMOUNT"] stringValue];
    NSString *mbjeStr = [NSString stringWithFormat:@"目标金额:%@元",[[dic objectForKey:@"TOTAL_AMOUNT"] stringValue]];
    cell.tsLabel.text = tsStr;
    cell.rsLabel.text = rsStr;
    cell.zjLabel.text = zjStr;
    
    cell.mbjeLabel.text = mbjeStr;
    float ta =  [[dic objectForKey:@"TOTAL_AMOUNT"]floatValue];;
    float ra = [[dic objectForKey:@"REAL_AMOUNT"]floatValue];
    float blf = (ra/ta);
    //        NSString *blStr = [NSString stringWithFormat:@"已达到:%.0f %%",blf*100];
    cell.progressView.progress = blf;

}
-(void)showMineData:(NSDictionary *)dic
{
    
    ASHMainTableViewCell * cell = self;
   
    [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
    cell.titleLabel.text = [dic objectForKey:@"TITLE"]; //标题
    [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];//头像
    
    NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];//组织名称
    if (name&&![name isKindOfClass:[NSNull class]]) {
        cell.nameLabel.text = name;
    }else{
        cell.nameLabel.text = @"";
    }
    
    
//    NSString *sjStr = [NSString stringWithFormat:@" %@ %@ ",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
//    cell.areatimeLabel.text = sjStr; //时间地点
    NSString *sjStr = [NSString stringWithFormat:@"  %@ %@  ",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
    //    NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
    //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
//    NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:sjStr];
//        [retMsTR addAttribute:NSForegroundColorAttributeName
//                        value:MOMOrangeColor
//                        range:[amount rangeOfString:tStr]];
//    retMsTR seta
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:9.0],NSFontAttributeName,
                                   MOMLightGrayColor,NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:sjStr attributes:attributeDict];
    //    [attrStr appendAttributedString:retMsTR];
    cell.areatimeLabel.attributedText = AttributedStr;
    
    //        cell.timelLabel.text = [NSString stringWithFormat:@"活动地点：%@",[dic objectForKey:@"BEGIN_DATE"]]; //时间
    cell.areaLabel.text = [NSString stringWithFormat:@"活动时间：%@",[dic objectForKey:@"CITY"]]; //地点
    
    NSString *rsbStr = [NSString stringWithFormat:@"活动人数：%@/%@",[dic objectForKey:@"ENROLL_COUNT"],[dic objectForKey:@"PERSON_LIMIT"]];
    cell.hdrsLabel.text = rsbStr; // "ENROLL_COUNT":1,  // 已报名人数  "PERSON_LIMIT":50,  // 人数上限
    
    cell.typelLabel.text = [dic objectForKey:@"SUPPORT_STATE"];//[dic objectForKey:@"PROJECT_STATE"];//支付状态
    NSString *tsStr = [NSString stringWithFormat:@"剩余天数:%@",[dic objectForKey:@"REMAIN_DAYS"]];
//    NSString *rsStr = [NSString stringWithFormat:@"报名人数:%@",[dic objectForKey:@"ENROLL_COUNT"]];
    NSString *zjStr = [NSString stringWithFormat:@"筹得资金:%@",[dic objectForKey:@"REAL_AMOUNT"]];
    
    NSString *rcStr = [NSString stringWithFormat:@"认筹人数:%@",[dic objectForKey:@"FUND_COUNT"]];
    NSString *mbjeStr = [NSString stringWithFormat:@"¥ %@元",[dic objectForKey:@"TOTAL_AMOUNT"]];
    
    cell.tsLabel.text = tsStr;
    cell.rsLabel.text = rcStr;
    cell.zjLabel.text = zjStr;
    
    cell.mbjeLabel.text = mbjeStr;
    
    cell.typelLabel.text = [dic objectForKey:@"SUPPORT_STATE"];
    
    float ta =  [[dic objectForKey:@"TOTAL_AMOUNT"]floatValue];;
    float ra = [[dic objectForKey:@"REAL_AMOUNT"]floatValue];
    float blf = (ra/ta);
    //        NSString *blStr = [NSString stringWithFormat:@"已达到:%.0f %%",blf*100];
    cell.progressView.progress = blf;
}
-(void)showMyProjectData:(NSDictionary *)dic
{
//    NSDictionary *dic = _dataDic;
    NSString *rcrs = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FUND_COUNT"]?[dic objectForKey:@"FUND_COUNT"]:@"0"]; //认筹人数
    NSString *mbje = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TOTAL_AMOUNT"]?[dic objectForKey:@"TOTAL_AMOUNT"]:@"0"]; //目标金额
    NSString *zcts = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FUND_DAYS"]?[dic objectForKey:@"FUND_DAYS"]:@"0"]; //众筹天数
    
    
    NSString *tkrs = [NSString stringWithFormat:@"%@",[dic objectForKey:@"REIMBURSE_COUNT"]?[dic objectForKey:@"REIMBURSE_COUNT"]:@"0"]; //退款人数
    NSString *cdje = [NSString stringWithFormat:@"%@",[dic objectForKey:@"REAL_AMOUNT"]?[dic objectForKey:@"REAL_AMOUNT"]:@"0"]; //筹得金额
    NSString *ydc =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"PERCENT"]?[dic objectForKey:@"PERCENT"]:@"0"]; // 已达成
    if ([ydc isEqualToString:@"(null)"]||[ydc isEqualToString:@"<null>"]) {
        ydc= @"0";
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    
    
    NSString *tsStr2 = [NSString stringWithFormat:@"认筹人数 %@人\n",rcrs!=nil?rcrs:@"0"];
    NSMutableAttributedString *tsAttrStr = [[NSMutableAttributedString alloc] initWithString:tsStr2];
    [tsAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[tsStr2 rangeOfString:rcrs]];
    
    NSString *rsStr2 = [NSString stringWithFormat:@"目标金额 %@元\n",mbje?mbje:@"0"];
    NSMutableAttributedString *rsAttrStr = [[NSMutableAttributedString alloc] initWithString:rsStr2];
    [rsAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[rsStr2 rangeOfString:mbje]];
    
    NSString *zjStr2 = [NSString stringWithFormat:@"众筹天数 %@天",zcts?zcts:@"0"];
    NSMutableAttributedString *zjAttrStr = [[NSMutableAttributedString alloc] initWithString:zjStr2];
    [zjAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[zjStr2 rangeOfString:zcts]];
    [attrStr appendAttributedString:tsAttrStr];
    [attrStr appendAttributedString:rsAttrStr];
    [attrStr appendAttributedString:zjAttrStr];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
    //               //设置行间距
    [paragraphStyle1 setLineSpacing:10];
    //NSParagraphStyleAttributeName;(段落)
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
    
    _lab0.attributedText = attrStr;
    
    attrStr = [[NSMutableAttributedString alloc] init];
    tsStr2 = [NSString stringWithFormat:@"退款人数 %@人\n",tkrs?tkrs:@"0"];
    tsAttrStr = [[NSMutableAttributedString alloc] initWithString:tsStr2];
    [tsAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[tsStr2 rangeOfString:tkrs]];
    
    rsStr2 = [NSString stringWithFormat:@"筹得金额 %@元\n",cdje?cdje:@"0"];
    rsAttrStr = [[NSMutableAttributedString alloc] initWithString:rsStr2];
    [rsAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[rsStr2 rangeOfString:cdje]];
    
    zjStr2 = [NSString stringWithFormat:@"已达成 %@ %%",ydc?ydc:@"0"];
    zjAttrStr = [[NSMutableAttributedString alloc] initWithString:zjStr2];
    [zjAttrStr addAttribute:NSForegroundColorAttributeName
                      value:MOMOrangeColor
                      range:[zjStr2 rangeOfString:ydc]];
    [attrStr appendAttributedString:tsAttrStr];
    [attrStr appendAttributedString:rsAttrStr];
    [attrStr appendAttributedString:zjAttrStr];
    
    
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
    _lab1.attributedText = attrStr;
    
    
    
    
    
    //            "FIRST_AMOUNT":0,  // 第一笔打款金额  第一期打款金额：38500元
    //            "SECOND_AMOUNT":0,  // 第二笔打款金额   第二期打款金额：38500元   总打款金额：38500元
    //            "FIRST_AMOUNT_PERCENT":"70"  // 第一笔打款金额百分比
    //  PROJECT_STATE value="众筹中"PROJECT_STATE value="众筹结束" PROJECT_STATE value="活动结束" PROJECT_STATE value="管理活动"
    NSString *projectState = [dic objectForKey:@"PROJECT_STATE"];
    NSInteger first = [[dic objectForKey:@"FIRST_AMOUNT"]integerValue];
    NSInteger second = [[dic objectForKey:@"FIRST_AMOUNT"]integerValue];
    if ([@"活动结束" isEqualToString:projectState]) {
        _lab2.text = [NSString stringWithFormat:@"第二期打款金额：%@元",[dic objectForKey:@"SECOND_AMOUNT"]];
        _lab3.text = @"Tips:活动结束第二期打入筹得金额30%，活动结束上传反馈信息打入剩余全部金额";
    }else if ([@"管理活动" isEqualToString:projectState]) {
        _lab2.text = [NSString stringWithFormat:@"总打款金额：%ld元",first+second];
        _lab3.text = @"";
    }else {
        //            }else if ([@"众筹结束" isEqualToString:projectState]) {
        _lab2.text = [NSString stringWithFormat:@"第一期打款金额：%@元",[dic objectForKey:@"FIRST_AMOUNT"]];
        
        _lab3.text = @"Tips:众筹结束第一期打入筹得金额70%，活动结束上传反馈信息打入剩余全部金额";
    }

}

- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{   //设置webView高度
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
}

@end
