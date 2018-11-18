//
//  ASHMyAttentionTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/6/1.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHMyAttentionTableViewController.h"

@interface ASHMyAttentionTableViewController ()

@end
//static NSString *const kTABLE_CELL = @"ASHAttentionTableViewCell";
@implementation ASHMyAttentionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataUP)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDataDown)];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDataUP];
}
//数据源
-(void)refreshDataUP{
    
    [self refreshDataWithIndex:1];
}

-(void)refreshDataDown{
    double count = self.dataArr.count;
    NSInteger num = ceil(count/PAGE_COUNT);
    [self refreshDataWithIndex:num+1];
}

-(void)refreshDataWithIndex:(NSInteger)index{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!self.dataArr) {
        self.dataArr =  [NSMutableArray array];
        
    }
    [self.tableView reloadData];
    
    //    NSString *rowCountStr = [NSString stringWithFormat:@"%ld",_dataArr.count>0?_dataArr.count:0];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger count = self.dataArr.count;
    //    NSInteger num =  count/PAGE_COUNT;
    
    [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"pageIndex"];
    //    [params setObject:[NSString stringWithFormat:@"%ld",num+1] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"count"];
    [params setObject:@"1" forKey:@"type"];
    
    
    [MOMNetWorking asynRequestByMethod:@"userRelation.do" params:params publicParams:MOMNetPublicParamUserId|MOMNetPublicParamToken callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        
        if (MOMResultSuccess==ret) {
            NSDictionary *dic = [result objectForKey:@"list"];
            //            _dataArr = [dic objectForKey:@"list"];
            //            _dataArr = [ASHBBSModel ModelsWithArray:[dic objectForKey:@"list"]];
            NSMutableArray *arr = [NSMutableArray arrayWithArray:self.dataArr];
//            NSArray *arr = [ASHBBSModel ModelsWithArray:[dic objectForKey:@"list"]];
            self.dataArr = [arr arrayByAddingObjectsFromArray:arr];
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    id    主键
//    user_nick    用户昵称
//    user_head    用户头像
//    friend_flag    用户关系标识
    
    NSDictionary *dic =  self.dataArr[indexPath.row];
    ASHAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHAttentionTableViewCell" forIndexPath:indexPath];
    cell.nameLabel.text = [dic objectForKey:@"user_nick"];
    [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"user_head"]];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
