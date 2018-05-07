//
//  ASHVideoListViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/2.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHVideoListViewController.h"

@interface ASHVideoListViewController (){
//    NSArray *_dataArr;
//    //    NSMutableArray *_cellArr;
//    UIScrollView *_scrollView;
    
}
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *cellList;
@end

@implementation ASHVideoListViewController
-(void)handleListChange:(NSNotification*)sender{
    NSLog(@"%@",sender);
    NSDictionary *dic= sender.userInfo;
    if (dic) {
        NSMutableArray *arr =  _dataArr;
        //    NSMutableDictionary *videoDic = arr[sender.tag];
        NSInteger num =  [arr indexOfObject:dic];
        [arr replaceObjectAtIndex:num withObject:dic];
        _dataArr = arr;
        
         ASHVideoListCell *cell = _cellList[num];
        BOOL isCollected = [[dic objectForKey:@"IF_FAVORITE"]boolValue];
        
        cell.downloadBtn.selected = isCollected;

    }
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(handleListChange:)
               name:@"updatellist"
             object:nil];
//    if (!_dataArr) {
//        _cellList = [NSMutableArray array];
//        _dataArr = [NSArray array];//@[@"1.gif",@"2.gif",@"3.gif",@"4.gif",@"5.gif",@"6.gif",@"1(450x800).gif",];
//        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 6*278+623+44)  ;
//        [self.view addSubview:_scrollView];
//        
//        
//        NSDictionary *params = [NSDictionary dictionary];
//        if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
//            params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId", nil];
//        }
//        
//        
//        //    [self doShow];
//        
//        __weak typeof(self) weakSelf = self;
//        [MOMNetWorking asynRequestByMethod:@"videos" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//            NSDictionary *dic = result;
//            if (MOMResultSuccess==ret) {
//                weakSelf.dataArr = [dic objectForKey:@"data"];
//                //            NSLog(@"_dataarr:%@",_dataArr);
//                //            NSSLog(@"2_dataarr:%@",_dataArr);
//                for (NSInteger i=0; i<(weakSelf.dataArr.count<6?weakSelf.dataArr.count:6); i++) {
//                    
//                    NSDictionary *videoDic = _dataArr[i];
//                    NSString *name = [videoDic objectForKey:@"VIDEO_WRITER"];
//                    NSString *time = [videoDic objectForKey:@"VIDEO_TIME"];
//                    BOOL isWatched = [[videoDic objectForKey:@"IF_WATCH"]boolValue];
//                    BOOL isCollected = [[videoDic objectForKey:@"IF_FAVORITE"]boolValue];
////                    NSString *gifStr = [videoDic objectForKey:@"VIDEO_COVER_HREF"];
//                    //                NSURL *gifURL = [NSURL URLWithString:gifStr];
//                    //                NSData *gifData = [NSData dataWithContentsOfURL:gifURL];
//                    
//                    
//                    
//                    
//                    CGRect rect = CGRectMake(0, i*278, self.view.bounds.size.width,270);
//                    ASHVideoListCell *cell = [[ASHVideoListCell alloc]initWithFrame:rect];
//                    cell.tag = i;
//                    cell.downloadBtn.tag = i;
//                    //        cell.backgroundColor = [UIColor redColor];
////                    [cell.mainIV ash_setImageWithURL:gifStr];
//                     NSString *mp4Str = [videoDic objectForKey:@"VIDEO_THUMB_HREF"];
////                    NSURL *gifURL = [NSURL URLWithString:mp4Str];
////                    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:gifURL]];
////                    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
////                    imageView.animatedImage = image;
////                    imageView.frame = cell.mainIV.bounds;
////                    //                    cell.mainIV = imageView;
////                    [cell.mainIV addSubview:imageView];
//                    
//                    
//                    
//                    
////                    [cell.mainIV ash_setImageWithURL:mp4Str];
//                    //                [self.view addSubview:imageView];
////                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//////                        //
////                        TICK;
////                        //                    NSURL *gifURL = [NSURL URLWithString:gifStr];
////                        //                    NSData *gifData = [NSData dataWithContentsOfURL:gifURL];
////                        //                    cell.mainIV.image = [OLImage imageWithIncrementalData:gifData];
////                        NSURL *gifURL = [NSURL URLWithString:gifStr];
////                        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:gifURL]];
////                        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
////                        imageView.animatedImage = image;
////                        imageView.frame = cell.mainIV.bounds;
////                        //                    cell.mainIV = imageView;
////                        [cell.mainIV addSubview:imageView];
//////                        [cell setNeedsLayout];
//////                    [cell reloadInputViews];
////                        TOCK;
////                    });
//                
//                    
//                    cell.titleLabel.text = [videoDic objectForKey:@"VIDEO_TITLE"];
//                    cell.nameLabel.text = [NSString stringWithFormat:@"%@ / %@",name,time];
//                    cell.lookLabel.hidden = !isWatched;
//                    cell.downloadBtn.selected = isCollected;
//                    
//                    __weak typeof(self) weakSelf = self;
//                    cell.shareBlock = ^(UIButton *sender){
//                        [weakSelf doShare];
//                    };
//                    cell.collectBlock = ^(UIButton *sender){
//                        [weakSelf doCollection:sender];
//                    };
//                    [weakSelf.cellList addObject:cell];
//                    [weakSelf.scrollView addSubview:cell];
//                    
//                    UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail:)];
//                    
//                    [cell addGestureRecognizer:tapG];
//                    //
//                    //                [cell.shareBtn addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
//                    //
//                    //                [cell.downloadBtn addTarget:self action:@selector(doCollection:) forControlEvents:UIControlEventTouchUpInside];
//                    
//                }
//                
//                CGRect rect = CGRectMake(0, (_dataArr.count<6?_dataArr.count:6)*278, self.view.bounds.size.width, 623);
//                ASHVideoADListCell *cell = [[ASHVideoADListCell alloc]initWithFrame:rect];
//                //    cell.backgroundColor = [UIColor redColor];
//                cell.mainIV.image = [OLImage imageNamed:@"1(450x800).gif"];
//                
//                [_scrollView addSubview:cell];
//                
//                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                if ([ASHMainUser ifShow]) {
//                                    ASHAlertView *alert = [[ASHAlertView alloc]init];
//                                    [self.view insertSubview:alert aboveSubview:_scrollView];
//                
//                                }
//                            });
//                
//                
//            }
//            //        {"VIDEO_ID":16,"VIDEO_TITLE":"忆江南","VIDEO_WRITER":"白居易[唐]","VIDEO_COVER_HREF":"http://47.92.114.252:80/video/video_20170502210756.gif","VIDEO_THUMB_HREF":"http://47.92.114.252:80/video/video_20170502210756_thumb.gif","VIDEO_HREF":"http://47.92.114.252:80/video/video_20170502114509.mp4","FIRST_FRAME_HREF":"http://47.92.114.252:80/video/video_20170502114509.mp4.jpg","VIDEO_TIME":"6\u00277\"","VIDEO_DESC":"                             忆江南①\n\n                             【唐】白居易\n\n                      江南好，\n                      风景旧曾谙。②\n                      日出江花红胜火，\n                      春来江水绿如蓝，③\n                      能不忆江南。","VIDEO_TAGS":"忆江南,白居易,唐,千山","POST_ADMIN":"admin","POST_DATE":"2017-04-23","APPROVER":"admin","DISAPPROVE_REASON":"","IF_PUBLISH":"是","IF_TRASH":"否","TOP_TIME":"2017-04-23 21:03:46","SHOW_ORDER":5,"IF_WATCH":false}
//            
//            
//            
//        }];
//    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    return 623;
//}else{
//    return 278;
    
//    NSString *name = [ASHMainUser name];
    
    
//    ASHAlertViewController *alert = [[ASHAlertViewController alloc]init];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alert animated:YES completion:^{
//        
//    }];
    
    
    [self doShow];
    
    
}

-(void)doShow{
    if (!_dataArr) {
        _cellList = [NSMutableArray array];
        _dataArr = [NSArray array];//@[@"1.gif",@"2.gif",@"3.gif",@"4.gif",@"5.gif",@"6.gif",@"1(450x800).gif",];
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 6*278+623+44)  ;
        [self.view addSubview:_scrollView];
        
        
        NSDictionary *params = [NSDictionary dictionary];
        if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
            params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId", nil];
        }
        
        
        //    [self doShow];
        
        __weak typeof(self) weakSelf = self;
        [MOMNetWorking asynRequestByMethod:@"videos" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                weakSelf.dataArr = [dic objectForKey:@"data"];
                //            NSLog(@"_dataarr:%@",_dataArr);
                //            NSSLog(@"2_dataarr:%@",_dataArr);
                for (NSInteger i=0; i<(weakSelf.dataArr.count<6?weakSelf.dataArr.count:6); i++) {
                    
                    NSDictionary *videoDic = _dataArr[i];
                    NSString *name = [videoDic objectForKey:@"VIDEO_WRITER"];
                    NSString *time = [videoDic objectForKey:@"VIDEO_TIME"];
                    BOOL isWatched = [[videoDic objectForKey:@"IF_WATCH"]boolValue];
                    BOOL isCollected = [[videoDic objectForKey:@"IF_FAVORITE"]boolValue];
                    //                    NSString *gifStr = [videoDic objectForKey:@"VIDEO_COVER_HREF"];
                    //                NSURL *gifURL = [NSURL URLWithString:gifStr];
                    //                NSData *gifData = [NSData dataWithContentsOfURL:gifURL];
                    
                    
                    
                    
                    CGRect rect = CGRectMake(0, i*278, self.view.bounds.size.width,270);
                    ASHVideoListCell *cell = [[ASHVideoListCell alloc]initWithFrame:rect];
                    cell.tag = i;
                    cell.downloadBtn.tag = i;
                    //        cell.backgroundColor = [UIColor redColor];
                    //                    [cell.mainIV ash_setImageWithURL:gifStr];
                    NSString *mp4Str = [videoDic objectForKey:@"VIDEO_THUMB_HREF"];
                    //                    NSURL *gifURL = [NSURL URLWithString:mp4Str];
                    //                    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:gifURL]];
                    //                    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
                    //                    imageView.animatedImage = image;
                    //                    imageView.frame = cell.mainIV.bounds;
                    //                    //                    cell.mainIV = imageView;
                    //                    [cell.mainIV addSubview:imageView];
                    
                    
                    
                    
                    //                    [cell.mainIV ash_setImageWithURL:mp4Str];
                    //                [self.view addSubview:imageView];
                    //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    ////                        //
                    //                        TICK;
                    //                        //                    NSURL *gifURL = [NSURL URLWithString:gifStr];
                    //                        //                    NSData *gifData = [NSData dataWithContentsOfURL:gifURL];
                    //                        //                    cell.mainIV.image = [OLImage imageWithIncrementalData:gifData];
                    //                        NSURL *gifURL = [NSURL URLWithString:gifStr];
                    //                        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:gifURL]];
                    //                        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
                    //                        imageView.animatedImage = image;
                    //                        imageView.frame = cell.mainIV.bounds;
                    //                        //                    cell.mainIV = imageView;
                    //                        [cell.mainIV addSubview:imageView];
                    ////                        [cell setNeedsLayout];
                    ////                    [cell reloadInputViews];
                    //                        TOCK;
                    //                    });
                    
                    
                    cell.titleLabel.text = [videoDic objectForKey:@"VIDEO_TITLE"];
                    cell.nameLabel.text = [NSString stringWithFormat:@"%@ / %@",name,time];
                    cell.lookLabel.hidden = !isWatched;
                    cell.downloadBtn.selected = isCollected;
                    
                    __weak typeof(self) weakSelf = self;
                    cell.shareBlock = ^(UIButton *sender){
                        [weakSelf doShare];
                    };
                    cell.collectBlock = ^(UIButton *sender){
                        [weakSelf doCollection:sender];
                    };
                    [weakSelf.cellList addObject:cell];
                    [weakSelf.scrollView addSubview:cell];
                    
                    UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail:)];
                    
                    [cell addGestureRecognizer:tapG];
                    //
                    //                [cell.shareBtn addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
                    //
                    //                [cell.downloadBtn addTarget:self action:@selector(doCollection:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
                CGRect rect = CGRectMake(0, (_dataArr.count<6?_dataArr.count:6)*278, self.view.bounds.size.width, 623);
                ASHVideoADListCell *cell = [[ASHVideoADListCell alloc]initWithFrame:rect];
                //    cell.backgroundColor = [UIColor redColor];
                cell.mainIV.image = [OLImage imageNamed:@"1(450x800).gif"];
                
                [_scrollView addSubview:cell];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([ASHMainUser ifShow]) {
                        ASHAlertView *alert = [[ASHAlertView alloc]init];
                        [self.view insertSubview:alert aboveSubview:_scrollView];
                        
                    }
                });
                
                
            }
            //        {"VIDEO_ID":16,"VIDEO_TITLE":"忆江南","VIDEO_WRITER":"白居易[唐]","VIDEO_COVER_HREF":"http://47.92.114.252:80/video/video_20170502210756.gif","VIDEO_THUMB_HREF":"http://47.92.114.252:80/video/video_20170502210756_thumb.gif","VIDEO_HREF":"http://47.92.114.252:80/video/video_20170502114509.mp4","FIRST_FRAME_HREF":"http://47.92.114.252:80/video/video_20170502114509.mp4.jpg","VIDEO_TIME":"6\u00277\"","VIDEO_DESC":"                             忆江南①\n\n                             【唐】白居易\n\n                      江南好，\n                      风景旧曾谙。②\n                      日出江花红胜火，\n                      春来江水绿如蓝，③\n                      能不忆江南。","VIDEO_TAGS":"忆江南,白居易,唐,千山","POST_ADMIN":"admin","POST_DATE":"2017-04-23","APPROVER":"admin","DISAPPROVE_REASON":"","IF_PUBLISH":"是","IF_TRASH":"否","TOP_TIME":"2017-04-23 21:03:46","SHOW_ORDER":5,"IF_WATCH":false}
            
            
            
        }];
    }
}
-(void)showDetail:(UITapGestureRecognizer *)sender
{
    
//    SZKAlterView *lll=[SZKAlterView alterViewWithTitle:@"简书号:iOS_凯" content:@"感谢各位朋友的关注与鼓励" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
//        //取消按钮点击事件
//        NSLog(@"取消");
//    } sureBtClcik:^{
//        //确定按钮点击事件
//        NSLog(@"确定");
//    }];
//    [self.view addSubview:lll];
//    
//    ASHAlertView *alert = [[ASHAlertView alloc]init];
//    ASHAlertView *alert = [ASHAlertView alterViewWithTitle:@"111" content:@"222" image:@""];
//      ASHAlertView *alert = [ASHAlertView alterViewWithTitle:@"111" content:@"222"];
//     [self.view addSubview:alert];
    
//    ASHAlertViewController *alertViewController = [[ASHAlertViewController alloc]init];
//    [self presentViewController:alertViewController animated:YES completion:^{
//        
//    }];
    
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"tips"]];
//    
//    [SVProgressHUD showInfoWithStatus:@"工艺之美"];
//    UIView *vv =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    vv.backgroundColor = [UIColor redColor];
//    
//    [SVProgressHUD setContainerView:vv];
    
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"1(450x800)"]];
//    [SVProgressHUD showImage:[UIImage imageNamed:@"占位图"] status:@"工艺之美"];
    
    
    MoviePlayerViewController *videoDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"videoDetailViewController"];
//    NSArray *arr = @[@"A Homeless Polar Bear in London - Ft. Jude Law and Radiohead",
//                     @"Break the Barrier - 60 Second Ad",
//                     @"David Beckham- Violence can mark children forever - #ENDviolence",
//                     @"SickKids VS- Undeniable",
//                     @"The Man Who Died The Most In Movies",
//                     @"The Most Important Thing - 60 seconds"];
//    videoDetailViewController.dataDic = _dataArr[sender.view.tag];//
    
    
//    [self presentViewController:videoDetailViewController animated:YES completion:^{
//        
//    }];
    videoDetailViewController.videoURL                   = [NSURL URLWithString:@"http://47.92.114.252:80/video/video_20170524102824.mp4"];//[NSURL URLWithString:@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4"];
    [self.navigationController pushViewController:videoDetailViewController animated:YES];

}

-(void)doShare{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用super6" descr:@"老司机带带我，自由的飞翔" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.kaiyanapp.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}

-(void)doCollection:(UIButton *)sender
{
    NSMutableArray *arr =  _dataArr;
    NSMutableDictionary *videoDic = arr[sender.tag];
    NSString *vedioId = [videoDic objectForKey:@"VIDEO_ID"];
//    BOOL isCollected = [[videoDic objectForKey:@"IF_FAVORITE"]boolValue];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",vedioId,@"videoId", nil];
    
    NSString *methedStr = @"unfavorite";
    if(!sender.selected){
        methedStr = @"favorite";
    }
    
    [MOMNetWorking asynRequestByMethod:methedStr params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            BOOL isCollected= [[dic objectForKey:@"data"]boolValue];
            if (isCollected) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注意" message:@"已经收藏过了哦" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }else{
                sender.selected = !sender.selected;
//                 BOOL isCollected = [[videoDic objectForKey:@"IF_FAVORITE"]boolValue];
                [videoDic setObject:[NSNumber numberWithBool:sender.selected] forKey:@"IF_FAVORITE"];
                _dataArr = arr;
//                BOOL isCollected = [[_dataArr[sender.tag] objectForKey:@"IF_FAVORITE"]boolValue];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"操作成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                [alert show];
                
            }
        }else if(MOMResultNOLogin==ret){
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没登录" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
            
            ASHUserLoginViewController *userLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"userLoginViewController"];
            //    [self.navigationController pushViewController:userLoginViewController animated:YES];
   
            [self presentViewController:userLoginViewController animated:YES completion:^{
                
            }];
        }
    }];
}

// 必须支持转屏，但只是只支持竖屏，否则横屏启动起来页面是横的
- (BOOL)shouldAutorotate {
    return YES;
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
