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
static NSString *const kTABLE_CELL = @"cpsAttentionCell";
@implementation ASHMyAttentionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTABLE_CELL forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
