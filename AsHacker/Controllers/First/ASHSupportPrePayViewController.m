//
//  ASHSupportPrePayViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/10/8.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHSupportPrePayViewController.h"

@interface ASHSupportPrePayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *areaView1;
@property (weak, nonatomic) IBOutlet UIView *areaView2;
@property (weak, nonatomic) IBOutlet UIView *areaView3;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel1;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel2;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel3;


@property (weak, nonatomic) IBOutlet UIButton *areaBtn1;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn2;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn3;

@property (weak, nonatomic) IBOutlet UIButton *addAddressBtn;

@end

@implementation ASHSupportPrePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        if(0==i){
            _detailLabel.text = _comment;
            

            NSString *totalamount = [tDic objectForKey:@"TOTAL_AMOUNT"];
            NSString *tStr = [NSString stringWithFormat:@"共计 %@元",totalamount];
        
            NSMutableAttributedString *retMsTR =[[NSMutableAttributedString alloc]initWithString:tStr];
            [retMsTR addAttribute:NSForegroundColorAttributeName
                            value:MOMOrangeColor
                            range:[tStr rangeOfString:totalamount]];
            [attrStr appendAttributedString:retMsTR];
            _totalLabel.attributedText = retMsTR;
        }
    }
    
    _label.attributedText = attrStr;
   
    
    
     NSArray *addArr = [_dataDic objectForKey:@"addresses"];
    for (NSInteger i=0; i<addArr.count; i++) {
        NSDictionary *tDic = addArr[i];
//        UILabel *btn = [_areaBtn1 viewWithTag:i];
        NSString *tStr = [NSString stringWithFormat:@"%@   %@ \n%@",[tDic objectForKey:@"NAME"],[tDic objectForKey:@"PHONE"],[tDic objectForKey:@"ADDRESS"]];
        if (0==i) {
            _areaView1.hidden = NO;
            _areaLabel1.text = tStr;
            
//            _areaBtn1.hidden = NO;
//            [_areaBtn1 setTitle:tStr forState:UIControlStateNormal];
            
        }if (1==i) {
//            _areaBtn2.hidden = NO;
//            [_areaBtn2 setTitle:tStr forState:UIControlStateNormal];

            _areaView2.hidden = NO;
            _areaLabel2.text = tStr;
        }if (2==i) {
//            _areaBtn3.hidden = NO;
//            [_areaBtn3 setTitle:tStr forState:UIControlStateNormal];

            _areaView3.hidden = NO;
            _areaLabel3.text = tStr;
        }else{
            
        }
    }
}
- (IBAction)addAddress:(id)sender {
    [MOMProgressHUD showSuccessWithStatus:@"添加地址"];
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
