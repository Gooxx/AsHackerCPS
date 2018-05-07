//
//  ASHFirstDetailSupportViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHFirstDetailSupportViewController.h"

@interface ASHFirstDetailSupportViewController ()


@end

@implementation ASHFirstDetailSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ASHFirstDetailSupportTableViewCell" bundle:nil] forCellReuseIdentifier:@"bbcell"];
    
    self.tableView.estimatedRowHeight = 120.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    UIImage *image = [UIImage imageNamed:@"报名参与"];
//    float h = (image.size.height*SCREEN_WIDTH)/image.size.width;
    
//    float h1 = self.mainIV.frame.size.height;
////    UIImage *image = self.mainIV.image;
////    float h2 = (image.size.height*SCREEN_WIDTH)/image.size.width;
//    CGRect rect =  self.view.frame;
//    rect.size.height = h1;
////    rect.origin.y = 57;
//    self.view.frame = rect;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASHFirstDetailSupportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbcell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
