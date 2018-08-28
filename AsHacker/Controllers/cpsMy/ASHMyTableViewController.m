//
//  ASHMyTableViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/23.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHMyTableViewController.h"

@interface ASHMyTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet UILabel *observeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property(nonatomic,strong)NSArray *menuArr;
@end
static NSString * const tableCell = @"cpsMyCellCPS";
@implementation ASHMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"my_bg"]];
    
    
    self.menuArr = [PListUtil plistMyMenus];
    
    
//    [self.iconIV ash_setImageWithURL:[ASHMainUser head]];
//    self.nickLabel.text = [ASHMainUser nick];
//    self.infoLabel.text = [ASHMainUser showInfo];
//
//    self.publishLabel.text  = [ASHMainUser bbsCount];
//    self.observeLabel.text = [ASHMainUser followCount];
//    self.fansLabel.text = [ASHMainUser fansCount];
    
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMe:)];
    [self.iconIV addGestureRecognizer:tapG];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.iconIV ash_setImageWithURL:[ASHMainUser head]];
    self.nickLabel.text = [ASHMainUser nick];
    self.infoLabel.text = [ASHMainUser showInfo];
    
    self.publishLabel.text  = [ASHMainUser bbsCount];
    self.observeLabel.text = [ASHMainUser followCount];
    self.fansLabel.text = [ASHMainUser fansCount];
}
- (IBAction)doEdit:(id)sender {
    [self showMe:nil];
}

-(void)showMe:(UITapGestureRecognizer *)sender
{
    id ctl =  [self.storyboard instantiateViewControllerWithIdentifier:@"ASHLoginViewController"];
    [self.navigationController pushViewController:ctl animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = self.menuArr[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
    
    NSArray *arr = self.menuArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    NSString *name =  [dic objectForKey:@"name"];
    NSString *img =  [dic objectForKey:@"img"];
    cell.textLabel.text = name;
//    [cell.imageView limitImage:img withSize:CGSizeMake(54, 48)];
    cell.imageView.image = [UIImage imageNamed:img];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.menuArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    NSString *name =  [dic objectForKey:@"name"];
    NSString *url =  [dic objectForKey:@"url"];
    UIViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:url];
    
    
    [self.navigationController pushViewController:ctl animated:YES];
//    self.navigationController.navigationBar.hidden = NO;
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
