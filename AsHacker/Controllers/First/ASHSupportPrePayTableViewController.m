//
//  ASHSupportPrePayTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/11/5.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHSupportPrePayTableViewController.h"
#import <AFNetworking/AFNetworking.h>
static AFHTTPSessionManager *manager;
@interface ASHSupportPrePayTableViewController (){
    NSMutableArray *_areaArr; //地址
//    NSArray *_areaArr; //地址
    
    NSInteger _selectAdress; //选中的地址
    
    NSInteger _selectPay; //选中的支付方式
    
    NSDictionary *_payDic;
}

@end

@implementation ASHSupportPrePayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _areaArr = [NSMutableArray array];
    _areaArr = [_dataDic objectForKey:@"addresses"];
    
    
    if (_dataDic&&[_dataDic objectForKey:@"TITLE"]) {
        self.navigationItem.title = [_dataDic objectForKey:@"TITLE"];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return _areaArr.count<3?_areaArr.count+1:_areaArr.count;
    }else if (section ==2){
        return 2;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 10;
    }else{
      return 40;
    }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 300, 20)];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    NSString *title = @"";
        if (section ==0) {
            title = @"";
        }else if (section ==1){
            title = @"确认收货信息";
        }else if (section ==2){
            title = @"付款方式";
        }
    label.text = title;
    
    return view;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//头

        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        cell.detailLabel.text = [NSString stringWithFormat:@"  %@",_comment];
        
        float percent = [[_dataDic objectForKey:@"percent"]floatValue];
        NSString *totalamount = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"total"]];
        NSString *tStr = [NSString stringWithFormat:@"共计 %@元",totalamount];
        
        NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:tStr];
        [retMsTR addAttribute:NSForegroundColorAttributeName
                        value:MOMOrangeColor
                        range:[tStr rangeOfString:totalamount]];
        cell.zjLabel.attributedText = retMsTR;
        cell.progressView.progress = percent/100.0;
        //支持
        NSArray *retArr = [_dataDic objectForKey:@"projectReturns"];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
        for (NSInteger i=0; i<retArr.count; i++) {
            NSDictionary *tDic = retArr[i];
            NSString *amount = [NSString stringWithFormat:@"%@",[tDic objectForKey:@"AMOUNT"]];
            NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
            //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
            NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:tStr];
            [retMsTR addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[tStr rangeOfString:amount]];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
            //设置行间距
            [paragraphStyle1 setLineSpacing:7];
            //NSParagraphStyleAttributeName;(段落)
            [retMsTR addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [retMsTR length])];
            [attrStr appendAttributedString:retMsTR];
        }
        cell.titleLabel.attributedText = attrStr;
        
        
        return cell;
    }else if (indexPath.section == 1) {//地址
        if (_areaArr.count<3&&indexPath.row==_areaArr.count) {
            ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
            return cell;
        }
        NSDictionary *dic = _areaArr[indexPath.row];
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.showDetailBtn.tag = indexPath.row;
        [cell.showDetailBtn addTarget:self action:@selector(doEdit:) forControlEvents:UIControlEventTouchUpInside];
        if(indexPath.row == _selectAdress){
            cell.picIV.image = [UIImage imageNamed:@"对勾无"];
            
        }else{
            cell.picIV.image = [UIImage imageNamed:@"对勾无灰"];
        }
        NSString *namephone = [NSString stringWithFormat:@"%@   %@",[dic objectForKey:@"NAME"],[dic objectForKey:@"PHONE"]];
        NSString *address = [dic objectForKey:@"ADDRESS"];
        
        cell.titleLabel.text = namephone;
        cell.detailLabel.text = address;
        return cell;
    }else if (indexPath.section == 2) {//支付选项
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"支付宝支付";
             cell.titleLabel.textColor = MOMRGBColor(29, 140, 229);
        }else if (indexPath.row == 1) {
            cell.titleLabel.text = @"微信支付";
            cell.titleLabel.textColor = MOMRGBColor(31, 177, 125);///[UIColor greenColor];
        }
        
        if(indexPath.row == _selectPay){
            cell.picIV.image = [UIImage imageNamed:@"对勾无"];
        }else{
            cell.picIV.image = [UIImage imageNamed:@"对勾无灰"];
        }
        return cell;
    }else{
        
    }
    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
    }else if (section == 1) {
        if (_areaArr.count<3&&indexPath.row==_areaArr.count) {
            ASHSupportSettingAreaViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHSupportSettingAreaViewController"];
            ctl.delegate = self;
            [self.navigationController pushViewController:ctl animated:YES];
        }else{
            _selectAdress = indexPath.row;
//            [self.tableView reloadData];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
    }else if (section == 2) {
        _selectPay = indexPath.row;
//        [self.tableView reloadData];
         [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}
#pragma mark - 绑定事件
-(void)doEdit:(UIButton *)sender
{
    _selectAdress = sender.tag;
    NSDictionary *dic = _areaArr[_selectAdress];
    ASHSupportSettingAreaViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHSupportSettingAreaViewController"];
    ctl.delegate = self;
    ctl.dataDic = dic;
    [self.navigationController pushViewController:ctl animated:YES];
    
    
//    NSDictionary *dic = _areaArr[_selectAdress];
//    NSString *ID = [dic objectForKey:@"ID"];
//    NSDictionary *params = @{@"ID":ID};
//    [MOMNetWorking asynRequestByMethod:@"delAddress" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
////            NSString *iddd  = [dic objectForKey:@"ID"];
////            NSDictionary *addDic = @{@"ID":iddd,
////                                     @"USER_ID":@1,
////                                     @"NAME":name,
////                                     @"PHONE":phone,
////                                     @"ADDRESS":address,
////                                     @"PREFERENCE":@0};
////            if (!ID||[@"" isEqualToString:ID]) {
////                [_areaArr addObject:addDic];
////            }else{
////                [_areaArr setObject:addDic atIndexedSubscript:_selectAdress];
////            }
////            
////            [self.tableView reloadData];
//        }
//        
//        
//    }];

}


//saveAddress
//请求头：Content-Type: application/x-www-form-urlencoded
//authorization，同4
//请求方法：post
//上传参数：ID=留空 & huanAvatar=0 & NAME=姓名 & PHONE=电话 & ADDRESS=地址
-(void)doAddAddressWithDic:(NSDictionary *)dic{
    NSString *address = [dic objectForKey:@"address"];
    NSString *name = [dic objectForKey:@"name"];
    NSString *phone = [dic objectForKey:@"phone"];
    NSString *ID = [dic objectForKey:@"ID"];
    [self doAddAddress:address phone:phone name:name ID:ID];
}
    
-(void)doAddAddress:(NSString *)address phone:(NSString *)phone name:(NSString *)name  ID:(NSString *)ID{
        NSDictionary *params = @{@"huanAvatar":@0,@"NAME":name,@"PHONE":phone,@"ADDRESS":address,@"ID":ID};
        [MOMNetWorking asynRequestByMethod:@"saveAddress" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                NSString *iddd  = [dic objectForKey:@"ID"];
                NSDictionary *addDic = @{@"ID":iddd,
                @"USER_ID":@1,
                @"NAME":name,
                @"PHONE":phone,
                @"ADDRESS":address,
                @"PREFERENCE":@0};
                if (!ID||[@"" isEqualToString:ID]) {
                     [_areaArr addObject:addDic];
                }else{
                    [_areaArr setObject:addDic atIndexedSubscript:_selectAdress];
                }
               
                [self.tableView reloadData];
            }

            
        }];
    
}
//    17. 设置某个收货地址为首选地址
//    入口：/m/api/prefer
//    请求头：Content-Type: application/x-www-form-urlencoded
//    authorization，同4
//    请求方法：post
//    上传参数：ID=地址ID
-(void)doSetCurrentAddrss
{
    NSString *addressId = _areaArr[_selectAdress];
    NSDictionary *params = @{@"ID":addressId};
    [MOMNetWorking asynRequestByMethod:@"prefer" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
//        }
    }];
}

- (IBAction)doSave:(id)sender {
    [self doSetCurrentAddrss];
    if(_selectPay==0){
        [self doAlipayPay];
    }else{
        [self doWeixinPay];
    }
}

//
//选中商品调用支付宝极简支付
//
-(void)doZFBPay:(NSString *)orderNO
{
    NSDictionary *dic = _payDic;
//    NSString *orderNO = [dic objectForKey:@"ORDER_NO"];
    NSInteger amount = [[dic objectForKey:@"AMOUNT"] integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.chouduck.com/alipayapp/app.php?body=%@&subject=筹小鸭&out_trade_no=%@&fee=%ld",orderNO,orderNO,amount];
    NSString *utfurlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:utfurlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *error=nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSSLog(@"------obj:%@",string);
            NSString *appScheme = @"com.chouduck.chouduck";
            [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"supprotprepaycontroller  11111reslut = %@",resultDic);
//                memo = "";
//                result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2017082508373574\",\"auth_app_id\":\"2017082508373574\",\"charset\":\"UTF-8\",\"timestamp\":\"2017-11-22 11:46:25\",\"total_amount\":\"1.00\",\"trade_no\":\"2017112221001104990587418716\",\"seller_id\":\"2088721696549214\",\"out_trade_no\":\"201711221146136809\"},\"sign\":\"R4BoREk/hLUZ+4q5uWU9n4NirCfnqKz+81RsOWmJZCMr4hhfIgCfps7Lr93ZZnTrLDUedLAL2irifXHZrDa7usDcJveQ74UFtB7Pc3NDPQoOfm+fsUIiHjmrsaVHGptBc4T0lIWEnp05f5gLWwOya7HJ1QXtU7XXFGGFewETpDD1uV0FUfUSIf752waKOHCQ8EbmwVNeQRyCVFBhwXxQG0tZkHNJINeo/BckbSuB/WS+9iRfothdvspnSfjXyDv3v2gQ3GlFjCIarElgm6i5ebrgYOCsXRGgZAdb/MpShw2VuTtrYc4f2db/57G/Gtd5IL1OXmUbxUoOpiRL6uwcAA==\",\"sign_type\":\"RSA2\"}";
//                resultStatus = 9000;
                
                
//                memo = "\U7528\U6237\U4e2d\U9014\U53d6\U6d88";
//                result = "";
//                resultStatus = 6001;
                if (9000== [[resultDic objectForKey:@"resultStatus"]integerValue]) {
                    [self jumpToNewPage];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSSLog(@"failure-----------网络请求失败了");
    }];

}
- (void)doAlipayPay
{
    
    NSString *projectId = [_dataDic objectForKey:@"PROJECT_ID"];
    NSString *supportTime = [_dataDic objectForKey:@"STATE_TIME"];
    [MOMNetWorking asynRequestByMethod:@"alipay" params:@{@"STATE_TIME":supportTime,@"PROJECT_ID":projectId} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        //        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            NSDictionary *dic = [result objectForKey:@"support"];
            _payDic = dic;
            NSString *orderNO = [dic objectForKey:@"ORDER_NO"];
            if (orderNO&&![@"" isEqualToString:orderNO]) {
                [self doZFBPay:orderNO];
            }else{
                [MOMProgressHUD showSuccessWithStatus:@"订单异常，请联系管理员"];
            }
            
        }
    }];
 
}

//33. 手机APP微信支付
//入口：/m/api/wechatpay?STATE_TIME=支持时间&PROJECT_ID=项目ID
//请求头：authorization，同4
//请求方法：get
//上传参数：无
//返回：
//{"statusCode":0,"support":{...}}  // 里头有ORDER_NO
//{"statusCode":1} 用户未登录，能报名
//401 Unauthorized 用户不正确，能报名

//33. 手机APP微信支付
//入口：/m/api/wechatpay
//请求头：Content-Type: application/x-www-form-urlencoded
//authorization，同4
//请求方法：post
//上传参数：STATE_TIME=支持时间&PROJECT_ID=项目ID
//返回：
//{"statusCode":0,"support":{...}}  // 里头有ORDER_NO

-(void)doWeixinPay{
    NSString *projectId = [_dataDic objectForKey:@"PROJECT_ID"];
    NSString *supportTime = [_dataDic objectForKey:@"STATE_TIME"];
    [MOMNetWorking asynRequestByMethod:@"wechatpay" params:@{@"STATE_TIME":supportTime,@"PROJECT_ID":projectId} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            NSDictionary *dic = [result objectForKey:@"support"];
            _payDic = dic;
             NSString *orderNO = [dic objectForKey:@"ORDER_NO"];
            if (orderNO&&![@"" isEqualToString:orderNO]) {
                [self bizPay];
            }else{
                [MOMProgressHUD showSuccessWithStatus:@"订单异常，请联系管理员"];
            }
            
        }
    }];
}
- (void)bizPay {
    NSDictionary *dic = _payDic;
    NSString *orderNO = [dic objectForKey:@"ORDER_NO"];
    NSInteger amount = [[dic objectForKey:@"AMOUNT"] integerValue]*100;
    
     NSString *urlStr = [NSString stringWithFormat:@"http://www.chouduck.com/apppay/core/app.php?trade_no=%@&fee=%ld&body=%@",orderNO,amount,orderNO];

    [MOMNetWorking asynGETPayRequestByMethod:urlStr params:nil publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSLog(@"------------result:%@ --- error:%@",result,error);
        
        NSDictionary *dic = result;
        
        NSString *mchid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mch_id"]];
        NSString *prepayid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"prepay_id"]];
        NSString *noncestr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nonce_str"]];
        NSString *timestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
        
        NSNumber *ts = [dic valueForKey:@"timestamp"];
        NSString *sign = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sign"]];
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = mchid;//@"1489392132"; //mch_id
        request.prepayId= prepayid;//@"wx2017111123481643285343b50253775969"; //prepay_id
        request.package = [NSString stringWithFormat:@"%@",@"Sign=WXPay"]; //
        request.nonceStr= noncestr;//@"QMREszyoeUDPggnH"; // nonce_str
        request.timeStamp= (UInt32) ts.longValue;//[timestamp intValue];//1510415296; //timestamp
        request.sign= sign;//@"A83844973A453769DD7483714A97EB43"; //sign
        [WXApi sendReq:request];
      }];
}
-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
            //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
//            [self jumpToNewPage];
            break;
            
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
            break;
        }
        
        if (response.errCode==WXSuccess) {
            [self jumpToNewPage];
        }
    }
}
    
    -(void)jumpToNewPage
    {
        UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        ASHPayResultViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHPayResultViewController"];
                    ctl.dataDic = _dataDic;
        
        [self.navigationController pushViewController:ctl animated:YES];
    }
    
   // /微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
//-(void) onResp:(BaseResp*)resp
//    {
//        //启动微信支付的response
//        NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        if([resp isKindOfClass:[PayResp class]]){
//            //支付返回结果，实际支付结果需要去微信服务器端查询
//            switch (resp.errCode) {
//                case 0:
//                payResoult = @"支付结果：成功！";
//                break;
//                case -1:
//                payResoult = @"支付结果：失败！";
//                break;
//                case -2:
//                payResoult = @"用户已经退出支付！";
//                break;
//                default:
//                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                break;
//            }
//        }
//    }
    

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
