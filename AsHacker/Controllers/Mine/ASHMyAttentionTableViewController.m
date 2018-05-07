//
//  ASHMyAttentionTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMyAttentionTableViewController.h"
#import "ASHSupportMainTableViewCell.h"
#import "ASHPublisherMainTableViewCell.h"
@interface ASHMyAttentionTableViewController (){
    NSDictionary *_organizerDic;// 组织详情
    NSArray *_teammatesArr;// 团队成员
    NSArray *_currentProjectsArr;// 进行中的活动
    NSArray *_priorProjects;// 举办过的活动
    
}
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation ASHMyAttentionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _organizerDic = [NSDictionary dictionary];
    _teammatesArr = [NSArray array];
    _currentProjectsArr = [NSArray array];
    _priorProjects = [NSArray array];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ASHSupportMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
       [self.tableView registerNib:[UINib nibWithNibName:@"ASHPublisherMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASHPublisherMainTableViewCell"];
    
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self refreshData];
}

//31. 返回组织详细信息
//入口：/m/api/organizer/组织的USER_ID
//请求头：无
//请求方法：get
//上传参数：无

-(void)refreshData{
    NSDictionary *dic = [_dataDic objectForKey:@"organization"];
//    NSArray *arr = [dic objectForKey:@"currentProjects"];

//
    NSString *method = [NSString stringWithFormat:@"organizer/%@",[dic objectForKey:@"USER_ID"]];
        [MOMNetWorking asynGETRequestByMethod:method params:nil publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
       
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                
                _organizerDic = [dic objectForKey:@"organizer"];// 组织详情
                _teammatesArr = [dic objectForKey:@"teammates"];// 团队成员
                _currentProjectsArr = [dic objectForKey:@"currentProjects"];// 进行中的活动
                _priorProjects = [dic objectForKey:@"priorProjects"];// 举办过的活动
                [self.tableView reloadData];

            }

        }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0==indexPath.section) {
//        return 250;
//    }else{
//        return 500;
//    }
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 30;
    }
    
    return 0.01;
}
//
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(15, 10, 375, 20)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 375, 20)];
        label.text = @"    往期活动";
        label.textColor = MOMDarkGrayColor;
        [view addSubview:label];
        return view;
    }
//    else if (section==3) {
//        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(20, 10, 375, 20)];
//        view.backgroundColor = [UIColor whiteColor];
//        UILabel *label =[[UILabel alloc]initWithFrame:view.bounds];
//        label.text = @"    参与者";
//        label.textColor = MOMLightGrayColor;
//        [view addSubview:label];
//        return view;
//    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }if (section==1) {
        return _teammatesArr.count;
    }else{
        return _priorProjects.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ASHPublisherMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHPublisherMainTableViewCell" forIndexPath:indexPath];
        if (_organizerDic.count>0) {
//            [cell showMainData:_organizerDic];
            NSDictionary *dic = _organizerDic;
            
            __block NSIndexPath *weakIndexPath = indexPath;
            
            __block ASHPublisherMainTableViewCell *weakCell     = cell;
            __weak typeof(self)  weakSelf      = self;
            // 点击播放的回调
            cell.playBlock = ^(UIButton *btn){
                
                
                NSString *imgURLStr = [NSString stringWithFormat:@"%@%@",HTTPURL,[dic objectForKey:@"PHOTO_HREF"]];
                
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
            cell.observeBtn.hidden= YES;
            cell.labView.frame = CGRectZero;
//            [cell showDetailData:dic];
            
            [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];//头像
            
            NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];//组织名称
            if (name&&![name isKindOfClass:[NSNull class]]) {
                cell.nameLabel.text = name;
            }else{
                cell.nameLabel.text = @"";
            }
            [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"PHOTO_HREF"]];//封面图
            NSMutableAttributedString *infoattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"TEAM_INTRO"]];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
            //               //设置行间距
            [paragraphStyle1 setLineSpacing:8];
            //NSParagraphStyleAttributeName;(段落)
            [infoattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoattrStr length])];
            
            [infoattrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0] range:NSMakeRange(0, [infoattrStr length])];
            
            cell.detailLabel.attributedText = infoattrStr;

        }
        
        
        return cell;
    }else if (indexPath.section==1) {
//        "AVATAR_HREF" = "/organizers/217/20171205230918_1489.jpeg";
//        ID = 33;
//        INTRO = "\U4e00\U4e2a\U5929\U874e\U5ea7\U7684\U95f7\U9a9a\U65e0\U8da3\U665a\U671f\U7684\U76f4\U7537\U764c\U517d\U533b\Uff01";
//        NAME = "\U5927\U5d14";
//        TITLE = "iTA\U8d1f\U8d23\U4eba";
//        "USER_ID" = 217;

        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        NSDictionary *dic = _teammatesArr[indexPath.row];
//        [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"AVATAR_HREF"]];//头像
//        
//        NSString *name = [dic objectForKey:@"NAME"];//组织名称
//        if (name&&![name isKindOfClass:[NSNull class]]) {
//            cell.nameLabel.text = name;
//        }else{
//            cell.nameLabel.text = @"";
//        }
//        NSString *title = [dic objectForKey:@"TITLE"];//组织名称
//        cell.rzLabel.text = title;
//        
//        NSMutableAttributedString *infoattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"INTRO"]];
//        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
//        //               //设置行间距
//        [paragraphStyle1 setLineSpacing:8];
//        //NSParagraphStyleAttributeName;(段落)
//        [infoattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoattrStr length])];
//        
//        [infoattrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0] range:NSMakeRange(0, [infoattrStr length])];
//        
//        cell.detailLabel.attributedText = infoattrStr;
        
        return cell;
    }else{
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//        
//        [cell showMainData:_priorProjects[indexPath.row]];
        NSDictionary *dic= _priorProjects[indexPath.row];
        NSString *titleStr = [dic objectForKey:@"TITLE"]; //标题
        if (titleStr) {
            self.navigationItem.title = titleStr;
            NSMutableAttributedString *titleattrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
            NSMutableParagraphStyle * titleparagraphStyle = [[NSMutableParagraphStyle alloc]init];
            //               //设置行间距
            [titleparagraphStyle setLineSpacing:4];
            //NSParagraphStyleAttributeName;(段落)
            [titleattrStr addAttribute:NSParagraphStyleAttributeName value:titleparagraphStyle range:NSMakeRange(0, [titleattrStr length])];
            [titleattrStr addAttribute:NSForegroundColorAttributeName
                                 value:MOMDarkGrayColor
                                 range:NSMakeRange(0, [titleattrStr length])];
            [titleattrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:NSMakeRange(0, [titleattrStr length])];
            cell.titleLabel.attributedText = titleattrStr;
        }
        [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
    
        
        NSString *sjStr = [NSString stringWithFormat:@"  %@ %@  ",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
        //    NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
        //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
        NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:sjStr];
        //    [retMsTR addAttribute:NSForegroundColorAttributeName
        //                    value:MOMOrangeColor
        //                    range:[amount rangeOfString:tStr]];
        //    [attrStr appendAttributedString:retMsTR];
        cell.areatimeLabel.attributedText = retMsTR;
        
        NSMutableAttributedString *infoattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"INTRO"]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
        //               //设置行间距
        [paragraphStyle1 setLineSpacing:8];
        //NSParagraphStyleAttributeName;(段落)
        [infoattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoattrStr length])];
        
        cell.detailLabel.attributedText = infoattrStr;
        return cell;
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
