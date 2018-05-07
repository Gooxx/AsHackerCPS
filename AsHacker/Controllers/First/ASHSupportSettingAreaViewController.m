//
//  ASHSupportSettingAreaViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHSupportSettingAreaViewController.h"

@interface ASHSupportSettingAreaViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextView *areaTV;

@end

@implementation ASHSupportSettingAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    NSDictionary *dic = _dataDic;
    NSString *address = [dic objectForKey:@"address"];
    NSString *name = [dic objectForKey:@"name"];
    NSString *phone = [dic objectForKey:@"phone"];
//    NSString *ID = [dic objectForKey:@"ID"];
    
    _nameTF.text = name;
    _phoneTF.text = phone;
    _areaTV.text = address;
    
}

-(void)doSave:(UIBarButtonItem *)sender
{
        NSString *name = _nameTF.text;
        NSString *phone = _phoneTF.text;
        NSString *address = _areaTV.text;
        NSString *ID = [_dataDic objectForKey:@"ID"];

        if(name&&phone&&address&&![@"" isEqualToString:name]&&![@"" isEqualToString:phone]&&![@"" isEqualToString:address]){
            if ([_delegate respondsToSelector:@selector(doAddAddressWithDic:)]) {
                [_delegate performSelector:@selector(doAddAddressWithDic:) withObject:@{@"address":address,@"name":name,@"phone":phone,@"ID":ID?ID:@""}];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [MOMProgressHUD showSuccessWithStatus:@"请完整填写信息"];
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
