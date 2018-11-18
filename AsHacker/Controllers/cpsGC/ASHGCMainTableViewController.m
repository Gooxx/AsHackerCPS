//
//  ASHGCMainTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/26.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHGCMainTableViewController.h"

@interface ASHGCMainTableViewController ()

@property(strong,nonatomic)NSArray *logoArr;
@property(strong,nonatomic)NSArray *dataArr;

@end
static NSString *const kLP_CELL = @"cpsMainCellLB";
static NSString *const k1P_CELL = @"cpsMainCell1P";
static NSString *const k3P_CELL = @"cpsMainCell3P";
static NSString *const k1V_CELL = @"cpsMainCell1V";


@implementation ASHGCMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1PTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASH1PTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH3PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell3P"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1VCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1V"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    

    // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
//    [MOMFilter registerFliterIn:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDataUP];
}
//数据源
-(void)refreshDataUP{
    [self refreshLogo];
    [self refreshDataWithIndex:1];
}

-(void)refreshDataDown{
    double count = _dataArr.count;
    NSInteger num = ceil(count/PAGE_COUNT);
    [self refreshDataWithIndex:num+1];
}

-(void)refreshDataWithIndex:(NSInteger)index{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
        
    }
    [self.tableView reloadData];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger count = _dataArr.count;
    [params setObject:@"1" forKey:@"flag"];
    [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"count"];
//    [params setObject:_carId forKey:@"carId"];
//    [params setObject:@"1" forKey:@"bbs_type"];
    
    
    [MOMNetWorking asynRequestByMethod:@"mainBbsList.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
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
-(void)refreshLogo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_carId forKey:@"car_id"];
    
    [MOMNetWorking asynRequestByMethod:@"carImgList.do" params:@{@"flag":@1} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
            _logoArr = [ASHLogoModel ModelsWithArray:[dic objectForKey:@"list"]];
            [self.tableView reloadData];
        }
    }];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0&&indexPath.row==0) {
        return 200;
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSArray *cellNames = @[@"cpsMainCellLB",@"ASH1PTableViewCell",@"cpsMainCell3P",@"cpsMainCell1V"];
    if (0==indexPath.row) {
        ASHBannerTableViewCell *cell = [[ASHBannerTableViewCell alloc]createBanner:CGRectMake(0, 0, ScreenWidth, 190)];
        cell.datas = _logoArr;
        [cell loadData];
        __weak typeof(self)  weakSelf      = self;
        
        cell.showBlock = ^(TYCyclePagerView *pageView, UICollectionViewCell *cell, NSInteger index) {
            ASHLogoModel *model = _logoArr[index];
            ASHNewsTWDetailViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsTWDetailViewController"];
            ctl.detailId = model.id;
            [weakSelf.navigationController pushViewController:ctl animated:YES];
            
        };
        return cell;
    }else{
        ASHBBSModel *model = _dataArr[indexPath.row-1];
        UITableViewCell *tcell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
        if(!tcell){
            tcell = [[[NSBundle mainBundle]loadNibNamed:cellNames[model.bbs_type] owner:nil options:nil] firstObject];
        }
        
        if (ASHBBSType1P == model.bbs_type) {
            __weak ASHBBS1PCell *cell = (ASHBBS1PCell *)tcell;
            cell.title.text = model.bbs_title;
            cell.name.text = model.user_nick;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            tcell = cell;
        }else if (ASHBBSType3P == model.bbs_type) {
            __weak ASH3PCell *cell =  (ASH3PCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            [cell.image2 ash_setImageWithURL:model.bbs_minPic];
            [cell.image3 ash_setImageWithURL:model.bbs_minPic];
            tcell = cell;
        }else if (ASHBBSType1V == model.bbs_type) {
            __weak ASH1VCell *cell =  (ASH1VCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            
            tcell = cell;
        }
        return tcell;
    }
    
    return nil;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASHBBSModel *model = _dataArr[indexPath.row-1];
    if (ASHBBSType1P == model.bbs_type||ASHBBSType3P == model.bbs_type) {
        ASHNewsTWDetailViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsTWDetailViewController"];
        
        //        ctl.lModel = model;
        ctl.detailId = model.id;
        
        [self.navigationController pushViewController:ctl animated:YES];
        
    }else if (ASHBBSType1V == model.bbs_type) {
        ASHNewsVideoDetailTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsVideoDetailTableViewController"];
        //        ctl.lModel = model;
        ctl.detailId = model.id;
        [self.navigationController pushViewController:ctl animated:YES];
    }
    
    
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
