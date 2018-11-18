//
//  ASHGCarTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/26.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHGCarTableViewController.h"

@interface ASHGCarTableViewController ()
@property(nonatomic,strong)NSArray *dataArr;

@end
static NSString * const tableCell = @"ASHBandTableViewCell";
@implementation ASHGCarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateData];
}


-(void)updateData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
        [params setObject:_bandId forKey:@"brand_id"];
    
    
    [MOMNetWorking asynRequestByMethod:@"carListByBrand.do" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            
            //            _dataArr = [dic objectForKey:@"listCar"];
            //            listCar
            //            "car_name": "A6",
            //            "id": "2",
            //            "show_pic": ""
            NSArray *arr  =[dic objectForKey:@"listCar"];
            _dataArr = [ASHCarModel ModelsWithArray:arr];
            [self.tableView  reloadData];
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
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASHBandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
    ASHCarModel *model =  [self.dataArr objectAtIndex:indexPath.row];
    cell.nameLabel.text =model.car_name;
    [cell.iconIV ash_setImageWithURL:model.show_pic];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ASHCarModel *model = [self.dataArr objectAtIndex:indexPath.row];
//    ASHGCMainTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHGCMainTableViewController"];
    ASHMainViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMainViewController"];
    ctl.carId = model.id;
    [self.navigationController pushViewController:ctl animated:YES];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *ctl = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ASHCarModel *model =  [self.dataArr objectAtIndex:indexPath.row];
//    [ctl setCarId:model.id];
    [ctl setValue:model.id forKey:@"carId"];
}



@end
