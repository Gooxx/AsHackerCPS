//
//  ASHMySupportTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMySupportTableViewController.h"
#import "ASHMySupportDetailTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
static AFHTTPSessionManager *manager;
@interface ASHMySupportTableViewController (){
    NSArray *_projectReturns;
    
     NSDictionary *_payDic;
}

@end

@implementation ASHMySupportTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"ASHMySupportDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"tcell"];
    _projectReturns = [NSArray array];
    
    [self refreshData];
}

-(void)refreshData{
    NSDictionary *params = @{@"STATE_TIME":[_dataDic objectForKey:@"STATE_TIME"],@"PROJECT_ID":[_dataDic objectForKey:@"PROJECT_ID"]};
    [MOMNetWorking asynRequestByMethod:@"statedetail" params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        if (MOMResultSuccess==ret) {
            _dataDic = [result objectForKey:@"support"];
            _projectReturns = [result objectForKey:@"projectReturns"];
            
            [self.tableView reloadData];
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - Table view data source
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0==indexPath.section) {
//        return 300;
//    }else{
//        return UITableViewAutomaticDimension;
//    }
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ASHMySupportDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
         [cell.showDetailBtn addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
        [cell showDetailData:_dataDic];
        return cell;
    }else if (indexPath.section==1) {
       
        
        if (indexPath.row==0) {
             ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.detailLabel.text = [_dataDic objectForKey:@"COMMENT"]?[_dataDic objectForKey:@"COMMENT"]:@"做好事只留名！";
            float percent = [[_dataDic objectForKey:@"percent"]floatValue];
            NSString *totalamount = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"AMOUNT"]];
            NSString *tStr = [NSString stringWithFormat:@"共计 %@元",totalamount];
            
            NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:tStr];
            [retMsTR addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[tStr rangeOfString:totalamount]];
            cell.zjLabel.attributedText = retMsTR;
            cell.progressView.progress = percent/100.0;
            //支持
            NSArray *retArr = _projectReturns;//[_dataDic objectForKey:@"projectReturns"];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
            for (NSInteger i=0; i<retArr.count; i++) {
                NSDictionary *tDic = retArr[i];
                NSString *amount = [NSString stringWithFormat:@"%@",[tDic objectForKey:@"RETURN_AMOUNT"]];
                NSString *tStr = [NSString stringWithFormat:@"%@元  %@ \n",amount,[tDic objectForKey:@"TITLE"]];
                //        [retMsTR appendFormat:@"%@元  %@",[tDic objectForKey:@"AMOUNT"],[tDic objectForKey:@"TITLE"]];
                NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:tStr];
                [retMsTR addAttribute:NSForegroundColorAttributeName
                                value:MOMOrangeColor
                                range:[tStr rangeOfString:amount]];
                NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
                //设置行间距
                [paragraphStyle1 setLineSpacing:15];
                //NSParagraphStyleAttributeName;(段落)
                [retMsTR addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [retMsTR length])];
                [attrStr appendAttributedString:retMsTR];

            }
            cell.titleLabel.attributedText = attrStr;
            
            NSString *payState = [_dataDic objectForKey:@"SUPPORT_STATE"];
            if ([@"已支付" isEqualToString:payState]) {
                cell.showDetailBtn.hidden = NO;
                 [cell.showDetailBtn addTarget:self action:@selector(showRepay) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.showDetailBtn.hidden = YES;
            }
            return cell;
        }else if (indexPath.row==1) {
            ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            
                NSDictionary *dic = _dataDic;
                NSString *ddh = [NSString stringWithFormat:@"订单号：%@",[dic objectForKey:@"ORDER_NO"]]; // 订单号
                NSString *xdsj = [NSString stringWithFormat:@"下单时间：%@",[dic objectForKey:@"ORDER_TIME"]]; // 下单时间
                NSString *jydh = [NSString stringWithFormat:@"交易单号：%@",[dic objectForKey:@"TRANSACTION_NO"]];// 支付宝或微信支付交易流水号
                
                NSString *zffs = [NSString stringWithFormat:@"支付方式：%@",[dic objectForKey:@"PAY_TYPE"]]; // 支付类型（支付宝、微信支付）
                NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@\n%@\n%@",ddh,xdsj,jydh,zffs]];
                NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
                //设置行间距
                [paragraphStyle1 setLineSpacing:15];
                //NSParagraphStyleAttributeName;(段落)
                [retMsTR addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [retMsTR length])];
                cell.detailLabel.attributedText = retMsTR;
            
               NSString *payState = [dic objectForKey:@"SUPPORT_STATE"];
                cell.typelLabel.text = [NSString stringWithFormat:@"%@",payState]; // yzhifu weizhifu
            if ([@"待支付" isEqualToString:payState]) {
                NSString *beginTime = [dic objectForKey:@"FUND_BEGIN_DATE"];
                NSString *endTime = [dic objectForKey:@"FUND_END_DATE"];
//                BOOL ended = [MOMTimeHelper validateWithStartTime:beginTime withExpireTime:endTime];
                int datesInt =  [MOMTimeHelper comparetoDay:endTime];
                if (datesInt>3) {
                    cell.showDetailBtn.hidden = NO;
                    [cell.showDetailBtn addTarget:self action:@selector(showPay) forControlEvents:UIControlEventTouchUpInside];
                }
//                if (!ended) {
//                    cell.supportBtn.selected = YES;
//                }else{
//                    cell.supportBtn.selected = NO;
//                }

//                cell.showDetailBtn.hidden = NO;
//                [cell.showDetailBtn addTarget:self action:@selector(showPay) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.showDetailBtn.hidden = YES;
            }
            
            
                return cell;
        }else if (indexPath.row==2) {
            ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            
            NSDictionary *dic = _dataDic;
            NSString *phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SHOUHUO_PHONE"]]; // 收货人电话
            NSString *namephone = [NSString stringWithFormat:@"收货人：%@",[dic objectForKey:@"SHOUHUO_NAME"]]; // 收货人
           
            NSString *adress = [NSString stringWithFormat:@"收货地址：%@",[dic objectForKey:@"SHOUHUO_ADDRESS"]]; //收货地址
            
            NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@\n%@",namephone,phone,adress]];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
            //设置行间距
            [paragraphStyle1 setLineSpacing:15];
            //NSParagraphStyleAttributeName;(段落)
            [retMsTR addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [retMsTR length])];
            cell.detailLabel.attributedText = retMsTR;
            
//            "IF_FAHUO":"未发货",  // 是否已发货
            cell.typelLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IF_FAHUO"]]; // yzhifu weizhifu
            return cell;
        }
        
        
    }
    
    
    return nil;
}
    //展示详情
-(void)showDetail
{
//    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
//    ASHFirstDetailTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
//    ctl.dataDic = _dataDic;
//    
//    [self.navigationController pushViewController:ctl animated:YES];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://www.chouduck.com/wxpay/core/query.php?out_trade_no=201712182200499788"];
    NSString *utfurlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:utfurlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error=nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSSLog(@"---------=筹小鸭------obj:%@ ----error：%@",string,error);
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSSLog(@"URLStr:------obj:%@",obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            [MOMProgressHUD dismiss];
        NSSLog(@"failure-----------网络请求失败了");
    }];

    
    
}
//退款
-(void)showRepay
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确定要取消支持并退款吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加确定按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消支持" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([@"微信" isEqualToString:[_dataDic objectForKey:@"PAY_TYPE"]]) {
            NSString *orderId = [_dataDic objectForKey:@"ORDER_NO"];
            
            NSInteger amount = [[_dataDic objectForKey:@"AMOUNT"]integerValue]*100;
             NSString *urlStr = [NSString stringWithFormat:@"http://www.chouduck.com/apppay/core/refund.php?out_trade_no=%@&total_fee=%ld&refund_fee=%ld",orderId,amount,amount];
            [MOMNetWorking asynGETPayRequestByMethod:urlStr params:nil publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
                NSLog(@"------------result:%@ --- error:%@",result,error);
                [self.navigationController popViewControllerAnimated:YES];
//                if([@"" isEqualToString:[dic objectForKey:@"result_code"]]){
                    [MOMProgressHUD showSuccessWithStatus:@"取消支持"];
//                }else{
//                    [MOMProgressHUD showSuccessWithStatus:@"取消支持失败，请联系管理员"];
//                }
                
            }];
            
        }else{
            NSString *orderId = [_dataDic objectForKey:@"ORDER_NO"];
            float amount = [[_dataDic objectForKey:@"AMOUNT"]floatValue];
            NSString *urlStr = [NSString stringWithFormat:@"http://www.chouduck.com/alipay/pagepay/refund.php?out_trade_no=%@&refund_amount=%f&refund_reason=筹小鸭",orderId,amount];
            NSString *utfurlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager GET:utfurlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error=nil;
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSSLog(@"http://www.chouduck.com/alipay/pagepay/refund.php?out_trade_no=%@&refund_amount=%f&refund_reason=筹小鸭------obj:%@ ----error：%@",string,error);
                 [self.navigationController popViewControllerAnimated:YES];
                [MOMProgressHUD showSuccessWithStatus:@"取消支持"];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //            [MOMProgressHUD dismiss];
                NSSLog(@"failure-----------网络请求失败了");
            }];

        }
        
       

    }]];

    
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
    
    

    
    
}

//继续付款
-(void)showPay
{
    if ([@"微信" isEqualToString:[_dataDic objectForKey:@"PAY_TYPE"]]) {
        [self doWeixinPay];
    }else{
        [self doAlipayPay];
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
        //            [MOMProgressHUD dismiss];
        NSError *error=nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSSLog(@"------obj:%@",string);
        
        NSString *appScheme = @"com.chouduck.chouduck";
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        //            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
        //                                     orderInfoEncoded, signedString];
        
        
        [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@" mysupportcontroller reslut = %@",resultDic);
//            if (9000== [[resultDic objectForKey:@"resultStatus"]integerValue]) {
//                [self jumpToNewPage];
//            }else{
//                [self.navigationController popViewControllerAnimated:YES];
//            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            [MOMProgressHUD dismiss];
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
