//
//  MOMPasswordUpdateController.m
//  LivingArea
//
//  Created by goooo on 15/11/3.
//  Copyright © 2015年 mom. All rights reserved.
//

#import "MOMPasswordUpdateController.h"

@interface MOMPasswordUpdateController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *nPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@end

@implementation MOMPasswordUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    
}

-(void)doSave:(UIBarButtonItem *)sender
{
    NSString *oldS = _oldPasswordTF.text;
    NSString *newS = _nPasswordTF.text;
    NSString *conS = _confirmPasswordTF.text;
    if (newS&&conS&&![@"" isEqualToString:newS]&&![@"" isEqualToString:conS]) {//oldS&&newS&&conS&&![@"" isEqualToString:oldS]&&
        if([newS isEqualToString:conS]){
            NSString *oldMd5 = @"";
            if(oldS&&newS&&conS&&![@"" isEqualToString:oldS]){
                oldMd5 = [MOMSecurityHelper md5:oldS];
            }
//            NSString *oldMd5 = [MOMSecurityHelper md5:oldS];
            NSString *newMd5 = [MOMSecurityHelper md5:newS];
            [self changePasswordOld:oldMd5 newPassword:newMd5];
//            [self changePasswordOld:oldS newPassword:newS];
        }else{
            [MOMProgressHUD showErrorWithStatus:@"两次填写的新密码不一致"];
        }
        
    }else{
        [MOMProgressHUD showErrorWithStatus:@"新密码不能为空"];
    }

}

//13. 更改老密码
//入口：/m/api/savePassword1
//请求头：Content-Type: application/x-www-form-urlencoded
//authorization，同接口4
//请求方法：post
//上传参数：password0=老密码 & password=新密码
//返回：{"statusCode":0}  // 成功
//{statusCode: 1}  // 用户未登录
//{statusCode: 2}  // 老密码不正确
//401 Unauthorized 用户不正确

-(void)changePasswordOld:(NSString *)oldPassword newPassword:(NSString *)newPassword{
    
    NSDictionary *params = @{@"password0":oldPassword,@"password":newPassword};
    [MOMNetWorking asynRequestByMethod:@"savePassword1" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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
