//
//  ASHMyProjectTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMyProjectTableViewController.h"
#import "ASHMyProjectDetailTableViewCell.h"
@interface ASHMyProjectTableViewController (){
    NSArray *_joinArr; //参与
    NSArray *_supporterArr; //支持
    NSArray *_volunteersArr; //志愿者
    
    NSArray *_returnAmountsArr;//回报项目
    NSArray *_returnSupportsArr; //回报
    
}
@property(nonatomic,assign)NSInteger selectCellNum;
@end

@implementation ASHMyProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"ASHMyProjectDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"tcell"];
    _joinArr = [NSArray array];
    _supporterArr = [NSArray array];
    _volunteersArr  = [NSArray array];
    
    _returnAmountsArr=[NSArray array];
    _returnSupportsArr =[NSArray array];
    
        [self refreshData];
   UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [scanBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanCode) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *scanBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"扫一扫"] style:UIBarButtonItemStylePlain target:self action:@selector(scanCode)];
    UIBarButtonItem *scanBar = [[UIBarButtonItem alloc]initWithCustomView:scanBtn];
    
//    UIBarButtonItem *scanBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(scanCode)];
    self.navigationItem.rightBarButtonItem = scanBar;
    
}
-(void)scanCode{
    /** 扫描二维码方法 */
    
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusNotDetermined) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        });
                        // 用户第一次同意了访问相机权限
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                        
                    } else {
                        // 用户第一次拒绝了访问相机权限
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
            } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
                SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                vc.dataDic = _dataDic;
                [self.navigationController pushViewController:vc animated:YES];
            } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                
            } else if (status == AVAuthorizationStatusRestricted) {
                NSLog(@"因为系统原因, 无法访问相册");
            }
        } else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
        } 
        


}
-(void)refreshData{
    NSDictionary *params = @{@"PROJECT_ID":[_dataDic objectForKey:@"PROJECT_ID"]};
    [MOMNetWorking asynRequestByMethod:@"myprojectdetail" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        
        if (MOMResultSuccess==ret) {
            _dataDic = [result objectForKey:@"project"];
//            _projectReturns = [result objectForKey:@"projectReturns"];
            _joinArr = [result objectForKey:@"joins"];
            _supporterArr = [result objectForKey:@"supports"];
            _volunteersArr = [result objectForKey:@"volunteers"];
            
            _returnAmountsArr = [result objectForKey:@"returnAmounts"];
            _returnSupportsArr = [result objectForKey:@"returnSupports"];
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
        if (_selectCellNum==0&&(section==2||section==3)) {
            return 30;
        }
    
    return 0;
}
//
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = _dataDic;
    NSString *projectState = [dic objectForKey:@"PROJECT_STATE"];
    
    
    if (![@"管理活动" isEqualToString:projectState]) {
        if (section==2) {
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(15, 10, 375, 20)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *label =[[UILabel alloc]initWithFrame:view.bounds];
            label.text = @"    志愿者";
            label.textColor = MOMLightGrayColor;
            [view addSubview:label];
            return view;
        }else if (section==3) {
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(20, 10, 375, 20)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *label =[[UILabel alloc]initWithFrame:view.bounds];
            label.text = @"    参与者";
            label.textColor = MOMLightGrayColor;
            [view addSubview:label];
            return view;
        }
    }
   
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        if (_selectCellNum==0){
            return _volunteersArr.count;
        }else if (_selectCellNum==1) {
            return _supporterArr.count;
        }
        
    }else if (section == 3) {
//        if (_selectCellNum==0){
            return _joinArr.count;

        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ASHMyProjectDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
        NSDictionary *dic = _dataDic;
        [cell showDetailData:dic];
        [cell.playerViewBG ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
        cell.titleLabel.text = [dic objectForKey:@"TITLE"]; //标题
        [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];//头像
        
        NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];//组织名称
        if (name&&![name isKindOfClass:[NSNull class]]) {
            cell.nameLabel.text = name;
        }else{
            cell.nameLabel.text = @"";
        }
        return cell;
        
        
    }else if (indexPath.section==1) {
        
        
        if (indexPath.row==0) {//  PROJECT_STATE value="众筹中"PROJECT_STATE value="众筹结束" PROJECT_STATE value="活动结束" PROJECT_STATE value="管理活动"
            
            ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            
//            NSDictionary *dic = _dataDic;
//            if(dic&&dic.count>0){
            
            if(_dataDic){
                [cell showMyProjectData:_dataDic];
            }
            
            return cell;
        }else if (indexPath.row==1) {
            NSDictionary *dic = _dataDic;
            NSString *projectState = [dic objectForKey:@"PROJECT_STATE"];

            
            if ([@"管理活动" isEqualToString:projectState]) {
                
                 ASHFirstDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell2" forIndexPath:indexPath];
//                 NSArray *returnAmounts = [dic objectForKey:@"returnAmounts"];
                
                NSMutableArray *tArr = [NSMutableArray array];
                for (NSDictionary *tDic  in _returnAmountsArr) {
                    NSString *value = [NSString stringWithFormat:@"%@元", [tDic objectForKey:@"AMOUNT"]];
                    [tArr addObject:value];
                }
                //初始化一个UISegmentedControl控件test
                if (!cell.segmentedControl) {
                    UISegmentedControl *test = [[UISegmentedControl alloc]initWithItems:tArr];
                    test.frame = CGRectMake(0, 10, SCREEN_WIDTH, 50);
                    
                    //设置无边框分段控制器
                    
                    //设置test控件的颜色为透明
                    test.tintColor = [UIColor clearColor];
                    //定义选中状态的样式selected，类型为字典
                    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                               NSForegroundColorAttributeName:MOMDarkGrayColor
                                               };
                    //                                           NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                    //                [mutableAttributedstring addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,5)];
                    
                    
                    //定义未选中状态下的样式normal，类型为字典
                    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                             NSForegroundColorAttributeName:MOMLightGrayColor};
                    
                    /*
                     NSFontAttributeName -> 系统宏定义的特殊键，用来给格式字典中的字体赋值
                     NSForegroundColorAttributeName -> 系统宏定义的特殊键，用来给格式字典中的字体颜色赋值
                     */
                    
                    //通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
                    [test setTitleTextAttributes:normal forState:UIControlStateNormal];
                    [test setTitleTextAttributes:selected forState:UIControlStateSelected];
                    
                    //设置test初始状态下的选中下标
                    test.selectedSegmentIndex = 0;
                    [test addTarget:self action:@selector(doChangeAmount:) forControlEvents:UIControlEventValueChanged];
                    //将test添加到某个View上
                    [cell addSubview:test];
                    
                    cell.segmentedControl = test;
//                    [self doChangeAmount:test];/
                   
                    NSInteger centerX = SCREEN_WIDTH/_returnAmountsArr.count/2;
                    
                    CGPoint centerP =  cell.lineLabel.center;
                    centerP.x = centerX;//sender.center.x;
                    cell.lineLabel.center = centerP;
                }
                
                
                return cell;
            }else{
                ASHFirstDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell" forIndexPath:indexPath];
                [cell.joinBtn addTarget:self action:@selector(showJoin:) forControlEvents:UIControlEventTouchUpInside];
                //
                [cell.supportBtn addTarget:self action:@selector(showSupport:) forControlEvents:UIControlEventTouchUpInside];
                
                
                //           "ENROLL_COUNT":1,  // 报名人数
                //           "QUIT_COUNT":2,  // 取消报名人数
                //           "FUND_COUNT":1,  // 认筹人数
                //           "REIMBURSE_COUNT":1,  // 退款人数
                
                NSDictionary *dic = _dataDic;
                NSInteger bmrs = [[dic objectForKey:@"ENROLL_COUNT"]integerValue];
                NSInteger qxbmrs = [[dic objectForKey:@"QUIT_COUNT"]integerValue];
                NSInteger rcrs = [[dic objectForKey:@"FUND_COUNT"]integerValue];
                NSInteger tkrs = [[dic objectForKey:@"REIMBURSE_COUNT"]integerValue];
                if(_selectCellNum==0){
                    
                    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
                    
                    
                    NSString *tsStr2 = [NSString stringWithFormat:@"%ld人报名",bmrs?bmrs:0];
                    NSMutableAttributedString *tsAttrStr = [[NSMutableAttributedString alloc] initWithString:tsStr2];
                    [tsAttrStr addAttribute:NSForegroundColorAttributeName
                                      value:MOMOrangeColor
                                      range:[tsStr2 rangeOfString:[NSString stringWithFormat:@"%ld",bmrs]]];
                    
                    NSString *rsStr2 = [NSString stringWithFormat:@"    %ld人取消报名",qxbmrs?qxbmrs:0];
                    NSMutableAttributedString *rsAttrStr = [[NSMutableAttributedString alloc] initWithString:rsStr2];
                    [rsAttrStr addAttribute:NSForegroundColorAttributeName
                                      value:MOMOrangeColor
                                      range:[rsStr2 rangeOfString:[NSString stringWithFormat:@"%ld",qxbmrs]]];
                    
                    
                    [attrStr appendAttributedString:tsAttrStr];
                    [attrStr appendAttributedString:rsAttrStr];
                    
                    
                    cell.titleLabel.attributedText = attrStr;
                    //               cell.titleLabel.text = [NSString stringWithFormat:@"%ld人报名    %ld人取消报名",bmrs,qxbmrs];
                    
                    
                }else{
                    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
                    
                    
                    NSString *tsStr2 = [NSString stringWithFormat:@"筹得%ld",rcrs?rcrs:0];
                    NSMutableAttributedString *tsAttrStr = [[NSMutableAttributedString alloc] initWithString:tsStr2];
                    [tsAttrStr addAttribute:NSForegroundColorAttributeName
                                      value:MOMOrangeColor
                                      range:[tsStr2 rangeOfString:[NSString stringWithFormat:@"%ld",rcrs]]];
                    
                    NSString *rsStr2 = [NSString stringWithFormat:@"    退款%ld",tkrs?tkrs:0];
                    NSMutableAttributedString *rsAttrStr = [[NSMutableAttributedString alloc] initWithString:rsStr2];
                    [rsAttrStr addAttribute:NSForegroundColorAttributeName
                                      value:MOMOrangeColor
                                      range:[rsStr2 rangeOfString:[NSString stringWithFormat:@"%ld",tkrs]]];
                    
                    
                    [attrStr appendAttributedString:tsAttrStr];
                    [attrStr appendAttributedString:rsAttrStr];
                    
                    
                    cell.titleLabel.attributedText = attrStr;
                    //               cell.titleLabel.text = [NSString stringWithFormat:@"筹得%ld    退款%ld",rcrs,tkrs];
                }
                
                
                return cell;
            }
            
        }
        
        
    }else if (indexPath.section==2) {
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        //        [cell showDetailData:_dataDic];
        NSDictionary *dic = _volunteersArr[indexPath.row];
        [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"AVATAR_HREF"]];
        
        NSString *name = [dic objectForKey:@"REAL_NAME"];
        NSString *time = [dic objectForKey:@"STATE_TIME"];
        NSString *phone = [dic objectForKey:@"PHONE_NO"];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",name];
        //        NSString *info = [NSString stringWithFormat:@" %@",[dic objectForKey:@"COMMENT"]];
        cell.timelLabel.text = time;
        cell.phoneLabel.text = phone;
        
        
        return cell;
    }else if (indexPath.section==3) {
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        NSDictionary *dic = _joinArr[indexPath.row];
        [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"AVATAR_HREF"]];
        
        NSString *name = [dic objectForKey:@"REAL_NAME"];
        NSString *time = [dic objectForKey:@"STATE_TIME"];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",name];
        
        cell.timelLabel.text = time;
        
        return cell;
    }
    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    return cell;
    
    
}
-(void)showJoin:(UIButton *)sender
{
    [self doChange:sender];
}
-(void)showSupport:(UIButton *)sender
{
    [self doChange:sender];
}
    
    - (void)doChange:(UIButton *)sender {
        //    sender.selected =  YES;//!sender.selected;
        
        
        _selectCellNum = sender.tag;
        ASHFirstDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        CGPoint centerP =  cell.lineLabel.center;
        centerP.x = sender.center.x;
        cell.lineLabel.center = centerP;
        //    _selectCellNum = 2;
        cell.supportBtn.selected = NO;
        cell.joinBtn.selected = NO;
        
        
        
        
        sender.selected =  YES;
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
        
    }

-(void)doChangeAmount:(UISegmentedControl *)sender
{
    [MOMProgressHUD showWithStatus:[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]];
    
    ASHFirstDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSInteger centerX = SCREEN_WIDTH/_returnAmountsArr.count *(sender.selectedSegmentIndex)+SCREEN_WIDTH/_returnAmountsArr.count/2;
    
    CGPoint centerP =  cell.lineLabel.center;
    centerP.x = centerX;//sender.center.x;
    cell.lineLabel.center = centerP;
    
}
    
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 25; //sectionHeaderHeight
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}
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
