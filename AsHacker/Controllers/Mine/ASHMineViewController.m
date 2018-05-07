//
//  ASHMineViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/24.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineViewController.h"

@interface ASHMineViewController (){
//    NSString *_iconURLStr;
}

@end

@implementation ASHMineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (_iconURLStr) {
//        [_iconIV ash_setImageWithURL:_iconURLStr];
//    }else{
//    if(![icon isEqualToString:[ASHMainUser head]]){
//        
//    }
    

        [_iconIV ash_setImageWithURL:[ASHMainUser head] ];
    
    
//    }
    NSString *nick = [ASHMainUser nick];
    _nickLabel.text = nick;
    
    
    if ([ASHMainUser userId]&&![@"" isEqualToString:[ASHMainUser userId]]) {
        _detailLabel.text = [NSString stringWithFormat:@"已观看%ld条视频",[ASHMainUser watchedNum]];
    }else{
        _detailLabel.text = [NSString stringWithFormat:@"登录/注册"];
    }
    
    CGRect numRect = _numLabel.frame;
    NSInteger height = ([ASHMainUser watchedNum]*224)/300;
    numRect.size.height = height>224?224:height;
    numRect.origin.y = 224-numRect.size.height+10;
    _numLabel.frame = numRect;
    

    [self userInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _mainScroll.contentSize = CGSizeMake(MOMScreenBounds.size.width, 623);
    if (MOMScreenBounds.size.height<623) {
        _mainScroll.contentSize = CGSizeMake(MOMScreenBounds.size.width, MOMScreenBounds.size.height<623?623:MOMScreenBounds.size.height-30);
    }else{
        _mainScroll.scrollEnabled = NO;
    }
    
    _iconIV.layer.masksToBounds = YES;
    _iconIV.layer.cornerRadius = 12;
    _iconIV.userInteractionEnabled = YES;
    _nickView.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateIcon)];
    [_iconIV addGestureRecognizer:iconG];
    
    UITapGestureRecognizer *nickG =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateUserInfo)];
    [_nickView addGestureRecognizer:nickG];
    
    
}
- (void)updateIcon{
    if (![ASHMainUser userId]||[@"" isEqualToString:[ASHMainUser userId]]) {
        //        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser
        
    }else{
        UIActionSheet *action               = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
        [action showInView:self.view];
    }
   
    
}

- (void)updateUserInfo{
    if (![ASHMainUser userId]||[@"" isEqualToString:[ASHMainUser userId]]) {
        //        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",_dataDic[@"VIDEO_ID"],@"videoId", nil];
        
        
    }else{
        
    
       ASHMineUserInfoController *mineUserInfoController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineUserInfoController"];
        [self.navigationController pushViewController:mineUserInfoController animated:YES];
    }
    
}
- (IBAction)showCollect:(id)sender {
    if (![ASHMainUser userId]||[@"" isEqualToString:[ASHMainUser userId]]) {
        //        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",_dataDic[@"VIDEO_ID"],@"videoId", nil];
        
        
    }else{
     
    }
    
//    ASHMineCollectListController *mineCollectListController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineCollectListController"];
//    [self.navigationController pushViewController:mineCollectListController animated:YES];
    


   
}
- (IBAction)showActive:(id)sender {
    if (![ASHMainUser userId]||[@"" isEqualToString:[ASHMainUser userId]]) {
        //        params = [NSDictionary dictionaryWithObjectsAndKeys:[ASHMainUser userId],@"userId",_dataDic[@"VIDEO_ID"],@"videoId", nil];
        
        
    }else{
       
    
    }
}

- (IBAction)showDownload:(id)sender {
//    ASHMineDownloadTableViewController *mineDownloadTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mineDownloadTableViewController"];
//    [self.navigationController pushViewController:mineDownloadTableViewController animated:YES];
    

    
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
   
//    _iconImage = infoImage;
//    
    if (infoImage) {
        
        _iconIV.image = infoImage;
        //        [_iconIV setImage:_iconImage forState:UIControlStateNormal];
        [self saveChangeData:_iconIV.image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - delegate
- (void)saveChangeData:(UIImage *)image {
    
    //    [UserInfo sharedUserInfo].nickName = self.nickNameLabel.text;
    //    [UserInfo sharedUserInfo].yourName = self.nameLabel.text;
    //    [UserInfo sharedUserInfo].imageData = UIImagePNGRepresentation(self.headerImageView.image);
    //    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    //    UIImage *image = self.headerImageView.image;
    NSData *imageData = UIImagePNGRepresentation(image);
    if(imageData == nil)
    {
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    
    //    if (imageData.length>1024*1024*2) {
    //        [[[UIAlertView alloc]initWithTitle:@"" message:MyLocalizedString(@"请上传小于1M的照片") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    //        return;
    //    }
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    //    NSString *username = [ud objectForKey:@"username"];
    //    NSString *watchId = [ud objectForKey:@"watch_id"];
//    NSString *username = [MOMCurrentUser userId];
    //        NSString *watchId = [MOMCurrentUser ];
    
    NSString  *_fileName = [NSString stringWithFormat:@"%@-%@",[ASHMainUser userId],@"1"];// username;
    
    NSString *saveURL = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",_fileName]];
    [imageData writeToFile:saveURL atomically:YES];
    
    [ASHMainUser setHead:saveURL];
//    _iconURLStr = saveURL;
//    [ud setObject:saveURL forKey:@"picture"];
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //    method=uploadPicture
//    //    username=用户名（测试时可用admin或123456账号）
//    //    galleryId=美术展ID
//    //    pictureNo=画作ID
//    //    id=本次评论ID（可选参数）
//    //    file=上传的文件
//    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[ASHMainUser userId] forKey:@"userId"];
//
//    
    [MOMNetWorking requestPictureByMethod:@"upload_avatar" fileURL:saveURL params:params publicParams:MOMNetPublicParamKey|MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        //        NSDictionary *dic = result;
        //        MOMResult ret = [[dic objectForKey:@"statusCode"] integerValue];
        //        NSString *code = [dic objectForKey:@"id"];
        
        NSString *string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"obj------------:%@",obj);
        //        callback(ret,code,error);
        
//        if (_iconImage) {
//            //            [self saveChangeData:_image1];
//            //        }else{
//            [[[UIAlertView alloc]initWithTitle:@"" message:@"发布成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//            
//            [MOMCurrentUser setHead:@""];
//            [MOMCurrentUser setLocalHead:saveURL];
//        }
//        
//        [MOMProgressHUD dismiss];
    }];
//
    
    NSLog(@"保存");
    
}

-(void)userInfo{
    NSDictionary *params = @{@"userId":[ASHMainUser userId]};
    NSString *userId =  [ASHMainUser userId];
    if (userId&&![@"" isEqualToString:userId]) {
        [MOMNetWorking asynRequestByMethod:@"user_detail" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = [result objectForKey:@"user"];
            if (MOMResultSuccess==ret) {
                NSInteger watchNum =  [[result objectForKey:@"watched"]integerValue];
                
                [ASHMainUser setWatchedNum:watchNum];
                
                NSString *nick =  [dic objectForKey:@"REAL_NAME"];
                NSString *icon =  [dic objectForKey:@"AVATAR_HREF"];
                NSString *sex =  [dic objectForKey:@"GENDER"];
                if (nick&&![@"" isEqualToString:nick]) {
                  [ASHMainUser setNick:nick];
                    
                    _nickLabel.text = nick;
                   
                }
                
                
                
                if (icon&&![@"" isEqualToString:icon]) {
                    if(![icon isEqualToString:[ASHMainUser head]]){
                        [ASHMainUser setHead:icon];
                        [_iconIV ash_setImageWithURL:[ASHMainUser head] ];
                    }
                   
                }
                
                if (sex&&![@"" isEqualToString:sex]) {
                    [ASHMainUser setSex:sex];
                }
//                [ASHMainUser setNick:[dic objectForKey:@"REAL_NAME"]];
//                
//                [ASHMainUser setHead:[dic objectForKey:@"AVATAR_HREF"]];
//                [ASHMainUser setSex:[dic objectForKey:@"GENDER"]];
                [ASHMainUser setPhoneNumber:[dic objectForKey:@"PHONE"]];
                [ASHMainUser setAge:[dic objectForKey:@"BIRTHDATE"]];
                [ASHMainUser setAreaName:[dic objectForKey:@"CITY"]];
                [ASHMainUser setCompany:[dic objectForKey:@"COMPANY"]];
                [ASHMainUser setPost:[dic objectForKey:@"TITLE"]];
                
                
               
                //    }
            
                
                
                _detailLabel.text = [NSString stringWithFormat:@"已观看%ld条视频",[ASHMainUser watchedNum]];
                
                CGRect numRect = _numLabel.frame;
                NSInteger height = ([ASHMainUser watchedNum]*224)/300;
                numRect.size.height = height>224?224:height;
                numRect.origin.y = 224-numRect.size.height+10;
                _numLabel.frame = numRect;
                //            "USER_ID":"123",
                //            "REAL_NAME":"李刚",
                //            "PHONE":"18622567903",
                //            "GENDER":"男",
                //            "BIRTHDATE":"1980-05-12",
                //            "CITY":"上海",
                //            "COMPANY":"国贸大厦",
                //            "TITLE":"销售总监",
                //            "AVATAR_HREF":"http://ip:80/avatar/123.jpg",  // 头像URL
                //            "LOGIN_TIME":"2017-04-23 21:37:57",
                //            "REMOTE_ADDRESS":"127.0.0.1",
                //            "LOGOUT_TIME":"2017-04-23 21:38:50",
                //            "IF_USING":"否"
                
                //            _dataArr = [dic objectForKey:@"data"];
                //            [self.tableView reloadData];
                //            [self dismissViewControllerAnimated:YES completion:^{
                //
                //            }];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
   
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
