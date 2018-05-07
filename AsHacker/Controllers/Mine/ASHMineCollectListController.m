//
//  ASHMineCollectListController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/11.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineCollectListController.h"

@interface ASHMineCollectListController (){
    NSArray *_dataArr;
    UIScrollView *_scrollView;
    UISegmentedControl * _mySegment;
}

@property(nonatomic,strong)NSMutableArray *cellList;
@end

@implementation ASHMineCollectListController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mySegment removeFromSuperview];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_mySegment) {
        UISegmentedControl * mySegment;
        mySegment = [[UISegmentedControl alloc]
                     initWithFrame:CGRectMake(5.0f, 10.0, 120.0f, 30.0f)];
        mySegment.center = CGPointMake(self.view.center.x, mySegment.center.y);
        [mySegment insertSegmentWithTitle:@"收藏" atIndex:0 animated:YES];
        [mySegment insertSegmentWithTitle:@"青睐" atIndex:1 animated:YES];
        mySegment.segmentedControlStyle = UISegmentedControlStyleBar;
        [mySegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
        mySegment.selectedSegmentIndex = 0;
        mySegment.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
        [mySegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                                   NSForegroundColorAttributeName: [UIColor lightTextColor]};
        [mySegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        [self.navigationController.navigationBar addSubview: mySegment];
        _mySegment = mySegment;
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(handleListChange:)
               name:@"updatellist"
             object:nil];
    
    [self doSerchMethod:@"my_favorites"];

    
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //    return 623;
    //}else{
    //    return 278;
    
    //    NSString *name = [ASHMainUser name];
    
    _cellList = [NSMutableArray array];
    //    return 623;
    //}else{
    //    return 278;
    
    //    NSString *name = [ASHMainUser name];
    
    UISegmentedControl * mySegment;
    mySegment = [[UISegmentedControl alloc]
                 initWithFrame:CGRectMake(5.0f, 10.0, 120.0f, 30.0f)];
    mySegment.center = CGPointMake(self.view.center.x, mySegment.center.y);
    [mySegment insertSegmentWithTitle:@"收藏" atIndex:0 animated:YES];
    [mySegment insertSegmentWithTitle:@"青睐" atIndex:1 animated:YES];
    mySegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [mySegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    mySegment.selectedSegmentIndex = 0;
    mySegment.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [mySegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName: [UIColor lightTextColor]};
    [mySegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview: mySegment];
    _mySegment = mySegment;
    
    _dataArr = @[@"1.gif",@"2.gif",@"3.gif",@"4.gif",@"5.gif",@"6.gif",@"1(450x800).gif",];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 6*278+623)  ;
    [self.view addSubview:_scrollView];
    
    

}

-(void)segAction:(UISegmentedControl *)sender
{
    if (0==sender.selectedSegmentIndex) {

        [self doSerchMethod:@"my_favorites"];
    }else if (1==sender.selectedSegmentIndex){
        [self doSerchMethod:@"my_zans"];

    }
}


-(void)doSerchMethod:(NSString *)method{
    [_scrollView removeFromSuperview];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 6*278+623)  ;
    [self.view addSubview:_scrollView];
    NSDictionary *params = [NSDictionary dictionary];
    if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId", nil];
    }
    
    [MOMNetWorking asynRequestByMethod:method params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            _dataArr = [dic objectForKey:@"data"];
            //            NSLog(@"_dataarr:%@",_dataArr);
            //            NSSLog(@"2_dataarr:%@",_dataArr);
            _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, _dataArr.count*278)  ;
            for (NSInteger i=0; i<_dataArr.count; i++) {
                
                NSDictionary *videoDic = _dataArr[i];
                NSString *name = [videoDic objectForKey:@"VIDEO_WRITER"];
                NSString *time = [videoDic objectForKey:@"VIDEO_TIME"];
                BOOL isWatched = [[videoDic objectForKey:@"IF_WATCH"]boolValue];
                BOOL isCollected = [[videoDic objectForKey:@"IF_FAVORITE"]boolValue];
                NSString *gifStr = [videoDic objectForKey:@"VIDEO_COVER_HREF"];
                NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:gifStr]];
                
                CGRect rect = CGRectMake(0, i*278, self.view.bounds.size.width,270);
                ASHVideoListCell *cell = [[ASHVideoListCell alloc]initWithFrame:rect];
                cell.tag = i;
                cell.downloadBtn.tag = i;
                //        cell.backgroundColor = [UIColor redColor];
                cell.mainIV.image = [OLImage imageWithIncrementalData:gifData];
                
                
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
                [_cellList addObject:cell];
                [_scrollView addSubview:cell];
                
                UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail:)];
                
                [cell addGestureRecognizer:tapG];
                
                //                    [cell.shareBtn addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
                //
                //                    [cell.downloadBtn addTarget:self action:@selector(doCollection) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
    }];
}
-(void)showDetail:(UITapGestureRecognizer *)sender
{
    ASHVideoDetailViewController *videoDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"videoDetailViewController"];
    //    NSArray *arr = @[@"A Homeless Polar Bear in London - Ft. Jude Law and Radiohead",
    //                     @"Break the Barrier - 60 Second Ad",
    //                     @"David Beckham- Violence can mark children forever - #ENDviolence",
    //                     @"SickKids VS- Undeniable",
    //                     @"The Man Who Died The Most In Movies",
    //                     @"The Most Important Thing - 60 seconds"];
    videoDetailViewController.dataDic = _dataArr[sender.view.tag];//@{@"video":indexPath.row<arr.count?arr[indexPath.row]:@"A Homeless Polar Bear in London - Ft. Jude Law and Radiohead"};
    [self presentViewController:videoDetailViewController animated:YES completion:^{
        
    }];
    
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
