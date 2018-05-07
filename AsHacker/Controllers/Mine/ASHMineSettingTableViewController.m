//
//  ASHMineSettingViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineSettingTableViewController.h"

@interface ASHMineSettingTableViewController (){
//    NSArray *_menuArr;
     NSArray *_menuArr1;
     NSArray *_menuArr2;
}


@end

@implementation ASHMineSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _WIFIBtn.selected = [ASHMainUser isEnableWIFIDownload];
    
//    _menuArr= @[@"清除缓存",@"意见建议",@"关于筹小鸭",@"收货地址",@"手机号",@"登录密码"];
    
    _menuArr1= @[@"清除缓存",@"意见建议",@"关于筹小鸭"];
    _menuArr2= @[];//@[@"收货地址",@"手机号",@"登录密码"];
    
}
- (IBAction)deleteCache:(id)sender {
    
       
    [MOMProgressHUD showWithDuration:5 animations:^{
        
    } completion:^(BOOL finished) {
//        [MOMProgressHUD showSuccessWithStatus:@"清除缓存成功"];
        [[[UIAlertView alloc]initWithTitle:@"" message:@"清除缓存成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }];

}

- (IBAction)logout:(id)sender {
    [ASHMainUser setUserId:nil];
    [ASHMainUser cleanInfo];
    
    
    [MOMProgressHUD showSuccessWithStatus:@"退出登录成功"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0 ) {
        return _menuArr1.count;

    }else{
        return _menuArr2.count;

    }
//    return _menuArr1.count+_menuArr2.count;
}

-(BOOL)checkNull:(NSString *)str
{
    if (str&&![@"" isEqualToString:str]) {
        return YES;
    }
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        cell.detailTextLabel.text = @"";
        cell.textLabel.text = _menuArr1[indexPath.row];
    }else if (indexPath.section==1) {
        cell.textLabel.text = _menuArr2[indexPath.row];
        
        if (indexPath.row==1) {
            cell.detailTextLabel.text = [ASHMainUser areaName];
        }else if (indexPath.row==0) {
            cell.detailTextLabel.text = [ASHMainUser getPhoneNumber];
        }else{
            cell.detailTextLabel.text = @"";
        }
    }

    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0&&indexPath.row==2) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"aboutCTL"] animated:YES];
        
    }else if (indexPath.section==0&&indexPath.row==0) {
        [MOMProgressHUD showWithDuration:3.0 animations:^{
            
        } completion:^(BOOL finished) {
            [MOMProgressHUD showSuccessWithStatus:@"清楚缓存成功"];
        }];
        
    }else if (indexPath.section==0&&indexPath.row==1) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ASHMineReplyViewController"] animated:YES];
        
    }

}
- (IBAction)doLogout:(id)sender {
    [ASHMainUser cleanInfo];
    [self.navigationController popViewControllerAnimated:YES];
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
