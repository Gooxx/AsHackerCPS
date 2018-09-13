//
//  ASHFWTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/27.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHFWTableViewController.h"

@interface ASHFWTableViewController ()
@property(strong,nonatomic)NSArray *dataArr;
@end
static NSString *const kLP_CELL = @"cpsMainCellLB";
static NSString *const k1P_CELL = @"cpsMainCell1P";
static NSString *const k3P_CELL = @"cpsMainCell3P";
static NSString *const k1V_CELL = @"cpsMainCell1V";

static NSInteger const PAGE_COUNT = 10;
@implementation ASHFWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
//
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    
//    [self refreshData];
    // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1PTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASH1PTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH3PCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell3P"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASH1VCell" bundle:nil] forCellReuseIdentifier:@"cpsMainCell1V"];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    [self refreshDataUP];
}

//数据源
-(void)refreshDataUP{
    [self refreshDataWithIndex:1];
}

-(void)refreshDataDown{
    NSInteger count = _dataArr.count;
    NSInteger num =  count/PAGE_COUNT;
    [self refreshDataWithIndex:num+1];
}

-(void)refreshDataWithIndex:(NSInteger)index{
    //    http://39.105.46.149/cps/app/cps/mainBbsById.do?id=2
    //    http://localhost:8080/cps/app/cps/mainLogo.do
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
        
    }
    [self.tableView reloadData];
    
    //    NSString *rowCountStr = [NSString stringWithFormat:@"%ld",_dataArr.count>0?_dataArr.count:0];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSInteger count = _dataArr.count;
    //    NSInteger num =  count/PAGE_COUNT;
    
    [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"pageIndex"];
    //    [params setObject:[NSString stringWithFormat:@"%ld",num+1] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"count"];
    [params setObject:@"1" forKey:@"flag"];
    
    
    [MOMNetWorking asynRequestByMethod:@"mainBbsList.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            //            _dataArr = [dic objectForKey:@"list"];
            _dataArr = [ASHBBSModel ModelsWithArray:[dic objectForKey:@"list"]];
            [self.tableView reloadData];
        }
    }];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSArray *cellNames = @[@"cpsMainCellLB",@"ASH1PTableViewCell",@"cpsMainCell3P",@"cpsMainCell1V"];
    if (0==indexPath.row) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cpsMainCellLB" forIndexPath:indexPath];
        return cell;
    }else{
        ASHBBSModel *model = _dataArr[indexPath.row-1];
        
        
////        if (ASHBBSType1P == model.bbs_type) {
//            UITableViewCell *tcell = [tableView dequeueReusableCellWithIdentifier:@"ASH1PTableViewCell" forIndexPath:indexPath];
//            if(!tcell){
//                 tcell = [[[NSBundle mainBundle]loadNibNamed:@"" owner:cellNames[model.bbs_type] options:nil] firstObject];
//                __weak ASHBBS1PCell *cell = (ASHBBS1PCell *)tcell;
//                cell.title.text = model.bbs_description;
//                cell.name.text = model.bbs_title;
//                cell.time.text = model.bbs_time;
//                [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
//                tcell = cell;
//            }
//        return tcell;
////        }
        
        NSLog(@"model: %@------index:%ld",model,indexPath.row);
        
        UITableViewCell *tcell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
        if(!tcell){
            tcell = [[[NSBundle mainBundle]loadNibNamed:@"" owner:cellNames[model.bbs_type] options:nil] firstObject];
        }
        //        ASHBBS1PCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[model.bbs_type] forIndexPath:indexPath];
        //        cell.title.text = model.bbs_description;
        //        cell.name.text = model.bbs_title;
        //        cell.time.text = model.bbs_time;
        //        [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
        
        if (ASHBBSType1P == model.bbs_type) {
            __weak ASHBBS1PCell *cell = (ASHBBS1PCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            tcell = cell;
        }
        else if (ASHBBSType3P == model.bbs_type) {
            __weak ASH3PCell *cell =  (ASH3PCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic ];
            [cell.image2 ash_setImageWithURL:model.bbs_minPic];
            [cell.image3 ash_setImageWithURL:model.bbs_minPic];
            tcell = cell;
        }else if (ASHBBSType1V == model.bbs_type) {
//            "bbs_description" = "\U89c6\U9891\U89c6\U9891\U89c6\U9891\U89c6\U9891\U89c6\U9891";
//            "bbs_minPic" = "/cps/userfiles/1/_thumbs/images/cms/article/2018/05/team04.jpg";
//            "bbs_time" = "2018-05-14 20:36:55.0";
//            "bbs_title" = "\U89c6\U9891";
//            "bbs_type" = 3;
//            "bbs_url" = null;
//            id = 4;
//            "user_nick" = zhang;
            __weak ASH1VCell *cell =  (ASH1VCell *)tcell;
            cell.title.text = model.bbs_description;
            cell.name.text = model.bbs_title;
            cell.time.text = model.bbs_time;
            [cell.image1 ash_setImageWithURL:model.bbs_minPic];
            
            tcell = cell;
        }
        return tcell;
         
    }
    
    return nil;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASHBBSModel *model = _dataArr[indexPath.row];
    if (ASHBBSType1P == model.bbs_type||ASHBBSType3P == model.bbs_type) {
        ASHNewsTWDetailViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsTWDetailViewController"];
        
        ctl.lModel = model;
        
        [self.navigationController pushViewController:ctl animated:YES];
        
    }else if (ASHBBSType1V == model.bbs_type) {
        ASHNewsVideoDetailTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHNewsVideoDetailTableViewController"];
        ctl.lModel = model;
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
