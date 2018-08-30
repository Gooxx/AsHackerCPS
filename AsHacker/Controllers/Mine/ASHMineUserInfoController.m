//
//  ASHMineUserInfoController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/9.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineUserInfoController.h"

@interface ASHMineUserInfoController (){
    NSArray *_menuArr1;
    NSArray *_menuArr2;
    
    NSDictionary *_dataDic;
}
@property (nonatomic,strong) DatePickerView *datePicker;


@end

@implementation ASHMineUserInfoController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _menuArr1= @[@"头像",@"昵称",@"性别",@"年龄"];
    _menuArr2= @[@"收货地址",@"手机号",@"手机密码"];
   
    [self selectUserInfo];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(doDismiss)];
    self.navigationItem.leftBarButtonItem = backBtn;
}
//获取个人资料
-(void)selectUserInfo{
    
    [MOMNetWorking asynGETRequestByMethod:@"myinfo2" params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            NSDictionary *dict =[dic objectForKey:@"user"];
            _dataDic = dict;
            
            [self.tableView reloadData];
        }else{
            [MOMProgressHUD showSuccessWithStatus:@"登陆失败"];
        }
    }];
}
-(void)doDismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}
//真保存
-(void)doSave
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *arr = @[@[@"realName",@0,@1],@[@"SEX",@0,@2],@[@"AGE",@0,@3],@[@"ADDRESS",@1,@0],@[@"phoneNo",@1,@1]];

    for (NSInteger i=0; i<arr.count; i++) {
        UITableViewCell *tableViewCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[i][2] integerValue] inSection:[arr[i][1] integerValue]]];

        [params setObject:tableViewCell.detailTextLabel.text forKey:arr[i][0]];
        

    }
    if([[params objectForKey:@"phoneNo"] isEqualToString:@"未填写~·~"]){
        [params setObject:@"" forKey:@"phoneNo"];
    }
    NSDictionary *dict = _dataDic;
    NSString *name = [NSString stringWithFormat:@"%@----",[dict objectForKey:@"NAME"]];
   [params setObject:name forKey:@"NAME"];
    [MOMNetWorking asynRequestByMethod:@"saveMyInfo1" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret||3==ret) {
            NSString *token =[dic objectForKey:@"token"];
            [ASHMainUser setNick:[params objectForKey:@"realName"]];
            if([self checkNull:token]){
                [ASHMainUser setToken:token];
                
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }
    
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 78;
    }
    return 58;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0 ) {
        return _menuArr1.count;
        
    }else{
        return _menuArr2.count;
        
    }
    
}
-(BOOL)checkNull:(NSString *)str
{
    if (str&&![@"" isEqualToString:str]) {
        return YES;
    }
    return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    NSDictionary *dict = _dataDic;
    NSString *phone = [NSString stringWithFormat:@"%@",[dict objectForKey:@"PHONE_NO"]];
    NSString *name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"REAL_NAME"]];
//    NSString *name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"NAME"]];
    
    NSString *address = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ADDRESS"]];
    NSString *age = [NSString stringWithFormat:@"%@",[dict objectForKey:@"AGE"]];
    NSString *sex = [NSString stringWithFormat:@"%@",[dict objectForKey:@"SEX"]];
    
    NSString *icon =   [NSString stringWithFormat:@"%@",[dict objectForKey:@"AVATAR_HREF"]];
    
    cell.detailTextLabel.text = @"";
    cell.detailTextLabel.textColor = MOMLightGrayColor;
    if (indexPath.section==0) {
        
        cell.textLabel.text = _menuArr1[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextLabel.text = @"";
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 50, 50)];
            imageView.layer.cornerRadius = 25;
            imageView.layer.masksToBounds =YES;
            cell.accessoryView = imageView;
            
            [imageView ash_setImageWithURL:icon];
        }else  if (indexPath.row==1) {
            cell.detailTextLabel.text = name;
        }else  if (indexPath.row==2) {
            cell.detailTextLabel.text = sex;
        }else  if (indexPath.row==3) {
            cell.detailTextLabel.text = age;
        }
    }else if (indexPath.section==1) {
        cell.textLabel.text = _menuArr2[indexPath.row];
        
        if (indexPath.row==0) {
            cell.detailTextLabel.text = address;
           
        }else  if (indexPath.row==1) {
            cell.detailTextLabel.text = phone;
        }
    }
    
    if (!cell.detailTextLabel.text||[@"" isEqualToString:cell.detailTextLabel.text]) {
        cell.detailTextLabel.text = @"未填写~·~";
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section&&0==indexPath.row) {
//        [MOMProgressHUD showSuccessWithStatus:@"头像"];
        [self updateIcon];
    }else if (0==indexPath.section&&2==indexPath.row) {
//        [MOMProgressHUD showSuccessWithStatus:@"改手机密码"];
        [self showSex:nil];
    }else if (0==indexPath.section&&3==indexPath.row) {
//        [MOMProgressHUD showSuccessWithStatus:@"改手机密码"];
        [self showAge:nil];
    }else if (1==indexPath.section&&1==indexPath.row) {
        ASHMinePhoneViewController *minePhoneViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHMinePhoneViewControllerTrue"];
        //        mineUserEditController.title = _menuArr[indexPath.row];
        
        minePhoneViewController.cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.navigationController pushViewController:minePhoneViewController animated:YES];
        

    }else if (1==indexPath.section&&2==indexPath.row) {
//        [MOMProgressHUD showSuccessWithStatus:@"改手机密码"];
        
        MOMPasswordUpdateController *passwordUpdateController = [self.storyboard instantiateViewControllerWithIdentifier:@"MOMPasswordUpdateController"];
        //        mineUserEditController.title = _menuArr[indexPath.row];
        
//        minePhoneViewController.cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.navigationController pushViewController:passwordUpdateController animated:YES];
        
    }else{
        ASHMineUserEditController *mineUserEditController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineUserEditController"];
        
        UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.section==0) {
            mineUserEditController.title = _menuArr1[indexPath.row];
        }else{
            mineUserEditController.title = _menuArr2[indexPath.row];
        }
        if ([cell.detailTextLabel.text isEqualToString:@"未填写~·~"]) {
            mineUserEditController.detailValue = @"";
        }else{
            mineUserEditController.detailValue = cell.detailTextLabel.text;
        }
        mineUserEditController.delegate =self;
        mineUserEditController.cell = cell;//[tableView cellForRowAtIndexPath:indexPath];
        [self.navigationController pushViewController:mineUserEditController animated:YES];
    }
    
}

//修改头像
- (void)updateIcon{
        UIActionSheet *action               = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
        [action showInView:self.view];
}
//弹出年龄
- (void)showAge:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"年龄" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加确定按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"00后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.detailTextLabel.text = action.title;
        [self doSave];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"90后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.detailTextLabel.text = action.title;
        [self doSave];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"80后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.detailTextLabel.text = action.title;
        [self doSave];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"70后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.detailTextLabel.text = action.title;
       [self doSave];
    }]];
    //增加取消按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:true completion:nil];
    
    
    
}
//弹出性别
- (void)showSex:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加确定按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.detailTextLabel.text = action.title;
        [self doSave];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.detailTextLabel.text = action.title;
        [self doSave];
    }]];
    //增加取消按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
    
    
}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    UITableViewCell *tableViewCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    tableViewCell.detailTextLabel.text = city.cityName;
    tableViewCell.detailTextLabel.textColor = ![self checkNull:city.cityName]?MOMRGBColor(73, 73, 73):MOMRGBColor(197, 197, 197);
    [ASHMainTempUser setAreaName:city.cityName];
    tableViewCell.accessoryType =UITableViewCellAccessoryNone;
    [tableViewCell.accessoryView removeFromSuperview];
    tableViewCell.accessoryView = nil;
//    [self.cityPickerButton setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2){
        return ;
    }
    
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //设置代理
    imagePicker.delegate = self;
    //设置图片选择属性
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) { //照相
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){//真机打开
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }else{// 模拟器打开
            
            NSLog(@"模拟器打开");
            return;
            
        }
        
    }else{//相册
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    // 进去选择器
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *infoImage = info[UIImagePickerControllerEditedImage];
    if (infoImage) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.detailTextLabel.text = @"";
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 50, 50)];
        imageView.image = infoImage;
        imageView.layer.cornerRadius = 25;
        imageView.layer.masksToBounds =YES;
        cell.accessoryView = imageView;
        [self saveChangeData:infoImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - delegate
- (void)saveChangeData:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    if(imageData == nil)
    {
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];

    NSString  *_fileName = [NSString stringWithFormat:@"%@-%@",[ASHMainUser userId],@"1"];// username;
    NSString *saveURL = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",_fileName]];
    [imageData writeToFile:saveURL atomically:YES];
    
    [ASHMainUser setHead:saveURL];
//    11. 上传用户头像
//    入口：/m/api/uploadAvatar
//    请求头：Content-Type: multipart/form-data
//    authorization，同接口4
//    请求方法：post
//    上传参数：file-input=头像文件
//    返回：{"statusCode":0,"data":"/img/avatar/小伙子_20171005183151.thumb.JPG"}  // 成功
//    {statusCode: 1}  // 用户未登录
//    401 Unauthorized 用户不正确
    [MOMNetWorking requestPictureByMethod:@"uploadAvatar" fileURL:saveURL params:@{@"file-input":_fileName} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSString *string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"obj------------:%@",dic);
        NSInteger ret = [[dic objectForKey:@"statusCode"] integerValue];
        if (MOMResultSuccess==ret) {
            [ASHMainUser setHead:[dic objectForKey:@"data"]];
        }
    }];
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
