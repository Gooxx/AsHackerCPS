//
//  ASHMineChouViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/4.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineChouViewController.h"

@interface ASHMineChouViewController (){
    NSArray *_dataArr;
    
    NSArray *_joindataArr;
    NSArray *_supportdataArr;
    NSArray *_observedataArr;
    NSArray *_projectdataArr;
//    NSInteger _showType;//0 all 1 doing 2 end
}
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property(nonatomic,assign)NSInteger selectCellNum;

@property (weak, nonatomic) IBOutlet UIButton *myJoinBtn;
@property (weak, nonatomic) IBOutlet UIButton *mySupportBtn;
@property (weak, nonatomic) IBOutlet UIButton *myObseveBtn;
@property (weak, nonatomic) IBOutlet UIButton *nyProjectBtn;
@property (weak, nonatomic) IBOutlet UILabel *unLoginLabel;


@end

@implementation ASHMineChouViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self refreshData];
    _namelabel.text = [ASHMainUser nick];
    [_iconIV ash_setImageWithURL:[ASHMainUser head]];
    
    if ([ASHMainUser userId]) {
        _namelabel.hidden = NO;
        _detailLabel.hidden = NO;
        _unLoginLabel.hidden = YES;
    }else{
        _namelabel.hidden = YES;
        _detailLabel.hidden = YES;
        _unLoginLabel.hidden = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    _dataArr =  [NSMutableArray array];
    _joindataArr = [NSMutableArray array];
    _supportdataArr = [NSMutableArray array];
    _projectdataArr = [NSMutableArray array];
    _observedataArr = [NSMutableArray array];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//   [self refreshDataJoin];
}
- (IBAction)showLogin:(id)sender {
    
    if (![ASHMainUser userId]) {
        ASHMinePhoneViewController *minePhoneViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"minePhoneViewController"];
        [self presentViewController:minePhoneViewController animated:YES completion:^{
            
        }];
    }else{
        
        
        UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        
        
        UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserInfoControllerNavi"];

        ASHMineUserInfoController *ctl = (ASHMineUserInfoController *)navi.topViewController;// [storyboard instantiateViewControllerWithIdentifier:@"ASHMineUserSimpleViewController"];
        [self.navigationController pushViewController:ctl animated:YES];
    }
   
}

//我的参与
-(void)refreshDataJoin{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

        [MOMNetWorking asynGETRequestByMethod:@"myjoin" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                NSArray *arr1 = [dic objectForKey:@"preResults"];
                NSArray *arr2 = [dic objectForKey:@"postResults"];//未开始
                NSArray *arrAll = [arr1 arrayByAddingObjectsFromArray:arr2];
                _joindataArr = arrAll;
                _dataArr =_joindataArr;
                [self.tableView reloadData];
                
            }
        }];
}

//我的zhichi
-(void)refreshDataSupport{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MOMNetWorking asynGETRequestByMethod:@"mysupport" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _supportdataArr = [dic objectForKey:@"allResults"];//全部项目
                
//                payedResults  topayResults reimbursedResults  waitResults
//                NSArray *arr1 = [dic objectForKey:@"topayResults"];//
//                 NSArray *arr2 = [dic objectForKey:@"payedResults"];//
//                 NSArray *arr3 = [dic objectForKey:@"reimbursedResults"];//
//                 NSArray *arr4 = [dic objectForKey:@"waitResults"];//
//                 NSArray *arrAll = [arr1 arrayByAddingObjectsFromArray:@[arr1,arr2,arr3,arr4]];
//                _supportdataArr = arrAll;
                
                _dataArr =_supportdataArr;
                [self.tableView reloadData];
            }
        }];
}
//我的关注
-(void)refreshDataObserve{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MOMNetWorking asynGETRequestByMethod:@"myfollow" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _observedataArr = [dic objectForKey:@"currentProjectGroups"];//全部项目
                _dataArr =_observedataArr;
                [self.tableView reloadData];
            }
            
        }];
}
//我的项目
-(void)refreshDataProject{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.footer endRefreshing];
        [MOMNetWorking asynGETRequestByMethod:@"myproject" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                _projectdataArr = [dic objectForKey:@"allResults"];//全部项目
                
                _dataArr =_projectdataArr;
                [self.tableView reloadData];
            }

            if (_dataArr&&_dataArr.count>0) {
                self.tableView.tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
                self.tableView.tableFooterView.hidden = YES;
            }else{
                self.tableView.tableFooterView.hidden = NO;
                self.tableView.tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
            }

        }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 278;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selectCellNum == 0) {
        ASHMyJoinTableViewController *ctl= [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMyJoinTableViewController"];
        ctl.dataDic = _joindataArr[indexPath.row];
        [self.navigationController pushViewController:ctl animated:YES];
    }else if (_selectCellNum == 1) {
        ASHMySupportTableViewController *ctl= [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMySupportTableViewController"];
        ctl.dataDic = _supportdataArr[indexPath.row];
        [self.navigationController pushViewController:ctl animated:YES];
    }else if (_selectCellNum == 2) {
        ASHMyAttentionTableViewController *ctl= [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMyAttentionTableViewController"];
//        ctl.dataDic = _observedataArr[indexPath.row];
        [self.navigationController pushViewController:ctl animated:YES];
    }else if (_selectCellNum == 3) {
        ASHMyProjectTableViewController *ctl= [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMyProjectTableViewController"];
        ctl.dataDic = _projectdataArr[indexPath.row];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

        NSString *cellName =[NSString stringWithFormat:@"cell%ld",_selectCellNum];
            ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
            NSDictionary *dic = _dataArr[indexPath.row];
        if (_selectCellNum==0) {
            [cell showDetailData:dic];
        }else if (_selectCellNum==2) {
            NSDictionary *dict = [dic objectForKey:@"organization"];
            NSArray *arr = [dic objectForKey:@"currentProjects"];
            [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];//头像
            
            NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];//组织名称
            if (name&&![name isKindOfClass:[NSNull class]]) {
                cell.nameLabel.text = name;
            }else{
                cell.nameLabel.text = @"";
            }
            
            NSArray *categoryArr = [dict objectForKey:@"CATEGORY"];
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
            [cell showMineData:arr.firstObject];
//            
//            NSString *sjStr = [NSString stringWithFormat:@"  %@ %@  ",[dict objectForKey:@"CITY"],[dict objectForKey:@"BEGIN_DATE"]];
//            //    NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
//            //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
//            //    NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:sjStr];
//            //        [retMsTR addAttribute:NSForegroundColorAttributeName
//            //                        value:MOMOrangeColor
//            //                        range:[amount rangeOfString:tStr]];
//            //    retMsTR seta
//            NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                           [UIFont systemFontOfSize:9.0],NSFontAttributeName,
//                                           MOMLightGrayColor,NSForegroundColorAttributeName,nil];
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:sjStr attributes:attributeDict];
//            //    [attrStr appendAttributedString:retMsTR];
//            cell.areatimeLabel.attributedText = AttributedStr;
        }else if (_selectCellNum==1) {

            [cell showMineData:dic];
//            cell.mbjeLabel.text = [NSString stringWithFormat:@"%@    %@",[dic objectForKey:@"AMOUNT"],[dic objectForKey:@"CONTENT"]];// [dic objectForKey:@"AMOUNT"];
//            cell.typelLabel.text = [dic objectForKey:@"CONTENT"];
//            cell.typelLabel.text = [dic objectForKey:@"SUPPORT_STATE"];
            
            
        }else if (_selectCellNum==3) {
            
            [cell showMineData:dic];
            cell.typelLabel.text = [dic objectForKey:@"PROJECT_STATE"];
        }
        return cell;
}

-(void)refreshData
{
    self.tableView.tableFooterView.hidden = YES;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    switch (_selectCellNum) {
        case 0:
             [self refreshDataJoin];
            break;
        case 1:
            [self refreshDataSupport];
            break;
        case 2:
           [self refreshDataObserve];
            break;
        case 3:
           [self refreshDataProject];
            break;
            
            
        default:
            break;
    }
    
    
}
- (IBAction)showMyPartake:(UIButton *)sender {
    CGPoint centerP =  _lineLabel.center;
    centerP.x = sender.center.x;
    _lineLabel.center = centerP;
    _myJoinBtn.selected = NO;
    _mySupportBtn.selected = NO;
    _myObseveBtn.selected = NO;
    _nyProjectBtn.selected = NO;
    
    sender.selected = YES;
//    [self.tableView reloadData];
    _selectCellNum = 0;
//    [self refreshDataJoin];
    [self refreshData];
    
    
}

- (IBAction)showMySupport:(UIButton *)sender {
    CGPoint centerP =  _lineLabel.center;
    centerP.x = sender.center.x;
    _lineLabel.center = centerP;
    _selectCellNum = 1;
    _myJoinBtn.selected = NO;
    _mySupportBtn.selected = NO;
    _myObseveBtn.selected = NO;
    _nyProjectBtn.selected = NO;
    
    sender.selected = YES;
    
//    [self refreshDataSupport];
    [self refreshData];
//    [self.tableView reloadData];
}

- (IBAction)showMyAttention:(UIButton *)sender {
    CGPoint centerP =  _lineLabel.center;
    centerP.x = sender.center.x;
    _lineLabel.center = centerP;
    _selectCellNum = 2;
    _myJoinBtn.selected = NO;
    _mySupportBtn.selected = NO;
    _myObseveBtn.selected = NO;
    _nyProjectBtn.selected = NO;
    
    sender.selected = YES;
//    [self.tableView reloadData];
//    [self refreshDataObserve];
     [self refreshData];
    
}

- (IBAction)showMyProject:(UIButton *)sender {
    CGPoint centerP =  _lineLabel.center;
    centerP.x = sender.center.x;
    _lineLabel.center = centerP;
    _selectCellNum = 3;
    _myJoinBtn.selected = NO;
    _mySupportBtn.selected = NO;
    _myObseveBtn.selected = NO;
    _nyProjectBtn.selected = NO;
    
    sender.selected = YES;
//    [self.tableView reloadData];
//    [self refreshDataProject];
     [self refreshData];
}

- (IBAction)showSetting:(id)sender {
    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ASHMineSettingTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHMineSettingTableViewController"];
    [self.navigationController pushViewController:ctl animated:YES];
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
