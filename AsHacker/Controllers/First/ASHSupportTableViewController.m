//
//  ASHSupportTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHSupportTableViewController.h"

@interface ASHSupportTableViewController (){
    NSArray *_dataArr;
    
    NSMutableArray *_supportArr;//支持金额的列表
    
    NSMutableArray *_supportViewArr;//支持view的列表

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIView *supportView;
@end

@implementation ASHSupportTableViewController


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    UIButton *btn = [[HcCustomKeyboard  customKeyboard] showListBtn];
    if (!btn.selected) {//处理一下操蛋的伸缩属性
        NSInteger high = 40*_supportViewArr.count;
        CGRect rect = [[HcCustomKeyboard  customKeyboard] mBackView].frame;
        rect.size.height =  rect.size.height-high;
        rect.origin.y = rect.origin.y+high;
        [[HcCustomKeyboard  customKeyboard] mBackView].frame = rect;
        
        CGRect rect2 = [[HcCustomKeyboard  customKeyboard] mainView].frame;
        rect2.origin.y = rect2.origin.y-high;
        [[HcCustomKeyboard  customKeyboard] mainView].frame = rect2;
        
        
        CGRect rect3 = self.tableView.frame;
        rect3.size.height =  rect3.size.height+high;
        //    rect3.origin.y = rect3.origin.y-high;
        self.tableView.frame = rect3;
    }
    for (NSInteger i=0; i<_supportViewArr.count; i++) {
        UIView *tempView = _supportViewArr[i];
        tempView.hidden= YES;
        [tempView removeFromSuperview];
    }
    
    [_supportArr removeAllObjects];
    [_supportViewArr removeAllObjects];
    NSMutableArray *arr = _supportArr;
    NSString *sunStr  = [NSString stringWithFormat:@"%.0f",[[arr valueForKeyPath:@"@sum.floatValue"]floatValue]];
    [[HcCustomKeyboard  customKeyboard]totlaLabel].text = [NSString stringWithFormat:@"总共：%@元",sunStr];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[HcCustomKeyboard  customKeyboard].showListBtn addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _supportArr = [NSMutableArray array];
    _supportViewArr = [NSMutableArray array];
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"ASHSupportMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"ASHSupportMainTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    [self refreshData];
    
    if (_dataDic&&[_dataDic objectForKey:@"TITLE"]) {
        self.navigationItem.title = [_dataDic objectForKey:@"TITLE"];
    }
    [[HcCustomKeyboard  customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    [[HcCustomKeyboard  customKeyboard].showListBtn addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - Table view data source
-(void)showSupportDetail:(UIButton *)sender{
//    CGRect rect = _supportView.frame;
//    rect.size.height = 500;
//    _supportView.frame = rect;
    
//    _supportView = view;
    [self.view endEditing:YES];
//    self.tableView scrollsToTop
//    [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_dataArr count]-1 inSection:1];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:
                                            [self.tableView numberOfRowsInSection:1]-1 inSection:1]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];

//    self.tableView.tableFooterView = _supportView;
//    [[HcCustomKeyboard  customKeyboard]textViewShowView:self customKeyboardDelegate:self];
}
//-(void)preEdit:(UIButton *)sender{
//    [[HcCustomKeyboard  customKeyboard]textViewShowView:self customKeyboardDelegate:self];
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section ==0) {
        return 1;
    }else if (section ==1){
        return _dataArr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//    ASHFirstDetailSupportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbcell" forIndexPath:indexPath];
        ASHSupportMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHSupportMainTableViewCell" forIndexPath:indexPath];
//        [cell.showDetailBtn addTarget:self action:@selector(doEdit:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dic = _dataDic;//_dataArr[indexPath.row];
        [cell.picIV ash_setImageWithURL:[dic objectForKey:@"COVER_HREF"]];//封面图
        cell.titleLabel.text = [dic objectForKey:@"TITLE"]; //标题
        [cell.iconIV ash_setImageWithURL:[dic objectForKey:@"LOGO_HREF"]];
        
        NSString *name = [dic objectForKey:@"ORGANIZATION_NAME"];
        
        if (name&&![name isKindOfClass:[NSNull class]]) {
            cell.nameLabel.text = name;
        }else{
            cell.nameLabel.text = @"";
        }
        
        cell.timelLabel.text = [NSString stringWithFormat:@" %@ %@\t",[dic objectForKey:@"CITY"],[dic objectForKey:@"BEGIN_DATE"]];
       
        
        cell.typelLabel.text = [dic objectForKey:@"PROJECT_STATE"];
        
        NSString *rsStr = [NSString stringWithFormat:@"已有%@人支持该活动",[[dic objectForKey:@"ENROLL_COUNT"] stringValue]];
        cell.mbjeLabel.text = rsStr;
        float ta =  [[dic objectForKey:@"TOTAL_AMOUNT"]floatValue];;
        float ra = [[dic objectForKey:@"REAL_AMOUNT"]floatValue];
        NSString *zjStr = [NSString stringWithFormat:@"筹得金额:%@",[[dic objectForKey:@"REAL_AMOUNT"] stringValue]];
        
        float blf = (ra/ta);
        
        cell.progressView.progress = blf;
        NSString *blStr = [NSString stringWithFormat:@"已达到:%.0f %%",blf*100];
        
        NSString *mbjeStr = [NSString stringWithFormat:@"目标金额:%@",[[dic objectForKey:@"TOTAL_AMOUNT"] stringValue]];
        
        
        cell.tsLabel.text = mbjeStr;
        cell.rsLabel.text = zjStr;
        cell.zjLabel.text = blStr;
        
//        cell.mbjeLabel.text = mbjeStr;
        return cell;
    }else{
        ASHFIrstSupport09TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bcell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.addBtn.tag = indexPath.row;
        [cell.addBtn addTarget:self action:@selector(addJE:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.jeLabel.text =[NSString stringWithFormat:@"%@元 %@",[dic objectForKey:@"AMOUNT"],[dic objectForKey:@"TITLE"]];
        
//        cell.detailLabel.text = [dic objectForKey:@"INTRO"];
        
        NSMutableAttributedString *infoattrStr = [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"INTRO"]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
        //               //设置行间距
        [paragraphStyle1 setLineSpacing:14];
        //NSParagraphStyleAttributeName;(段落)
        [infoattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoattrStr length])];
        
        cell.detailLabel.attributedText = infoattrStr;
        
        return cell;
    }

}
#pragma mark - 触发事件
//支持
-(void)doSupport:(NSString *)text
{
    
    //    projectId=项目ID & returnAmount=所选回报金额（逗号分割） & COMMENT=评论 & total=本次支持的总金额
    if ([@"想对他们说些什么~" isEqualToString:text]||[@"" isEqualToString:text]) {
        text = @"做好事只留名！";
    }
    NSMutableArray *arr = _supportArr;
    NSString *returnAmountStr = [arr componentsJoinedByString:@","];
    NSString *sunStr  = [NSString stringWithFormat:@"%.2f",[[arr valueForKeyPath:@"@sum.floatValue"]floatValue]];
    NSString *method = [NSString stringWithFormat:@"saveReturns"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[_dataDic objectForKey:@"PROJECT_ID"],@"projectId",returnAmountStr,@"returnAmount",sunStr,@"total",text,@"COMMENT", nil];
    [MOMNetWorking asynRequestByMethod:method params:params publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            ASHSupportPrePayTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHSupportPrePayTableViewController"];
            ctl.dataDic = result;
            ctl.comment = text;
            ctl.title = [_dataDic objectForKey:@"TITLE"];
            [self.navigationController pushViewController:ctl animated:YES];
        }
    }];
}
//数据源
-(void)refreshData{
    
    _dataArr =  [NSMutableArray array];
    NSString *method = [NSString stringWithFormat:@"projectreturn/%@",[_dataDic objectForKey:@"PROJECT_ID"]];
    [MOMNetWorking asynRequestByMethod:method params:nil publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            _dataArr = [dic objectForKey:@"projectReturns"];
            [self.tableView reloadData];
        }
    }];
}

//增加支持
-(void)addJE:(UIButton *)sender
{
//    [MOMProgressHUD showSuccessWithStatus:@"支持几块钱"];
    
    NSDictionary *dic = _dataArr[sender.tag];
    NSString *amount= [dic objectForKey:@"AMOUNT"];
    NSString *title= [dic objectForKey:@"TITLE"];
    [_supportArr addObject:amount];
    
    NSMutableArray *arr = _supportArr;
    NSString *sunStr  = [NSString stringWithFormat:@"%.0f",[[arr valueForKeyPath:@"@sum.floatValue"]floatValue]];
    
    [[HcCustomKeyboard  customKeyboard]totlaLabel].text = [NSString stringWithFormat:@"总共：%@元",sunStr];
    
    
    UIButton *btn = [[HcCustomKeyboard  customKeyboard] showListBtn];
    NSInteger high = 40;
    if (btn.selected) {//隐藏
        UIView *dView =[[UIView alloc]initWithFrame:CGRectMake(0, 0-high, SCREEN_WIDTH, high)];
        UILabel *dLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, high)];
        dLabel.text = [NSString stringWithFormat:@"%@元   %@",amount,title];
        dLabel.font = [UIFont systemFontOfSize:12];
        dLabel.tintColor = MOMLightGrayColor;
        
        UIButton *dBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80-0, 0, 80, high)];
        dBtn.tag = sender.tag;
        [dBtn setImage:[UIImage imageNamed:@"叉号"] forState:UIControlStateNormal];
        [dBtn addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
        [dView addSubview:dLabel];
        [dView addSubview:dBtn];
        [_supportViewArr addObject:dView];
        [[[HcCustomKeyboard  customKeyboard] mBackView] addSubview:dView];
        
    }else{//显示
        CGRect rect = [[HcCustomKeyboard  customKeyboard] mBackView].frame;
        rect.size.height =  rect.size.height+high;
        rect.origin.y = rect.origin.y-high;
        [[HcCustomKeyboard  customKeyboard] mBackView].frame = rect;
        
        CGRect rect2 = [[HcCustomKeyboard  customKeyboard] mainView].frame;
        rect2.origin.y = rect2.origin.y+high;
        [[HcCustomKeyboard  customKeyboard] mainView].frame = rect2;
        
        CGRect rect3 = self.tableView.frame;
        rect3.size.height =  rect3.size.height-high;
        self.tableView.frame = rect3;
        
        
        UIView *dView =[[UIView alloc]initWithFrame:CGRectMake(0, rect2.origin.y-high, SCREEN_WIDTH, high)];
        UILabel *dLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, high)];
        dLabel.text = [NSString stringWithFormat:@"%@元   %@",amount,title];
        dLabel.font = [UIFont systemFontOfSize:12];
        dLabel.tintColor = MOMLightGrayColor;
        
        UIButton *dBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80-0, 0, 80, high)];
        dBtn.tag = sender.tag;
        [dBtn setImage:[UIImage imageNamed:@"叉号"] forState:UIControlStateNormal];
        [dBtn addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
        [dView addSubview:dLabel];
        [dView addSubview:dBtn];
        
        [_supportViewArr addObject:dView];
        [[[HcCustomKeyboard  customKeyboard] mBackView] addSubview:dView];
    }
  
    
}
-(void)doDelete:(UIButton *)sender
{
    UIView *tView = sender.superview;
    NSInteger num = [_supportViewArr indexOfObject:tView];
    [_supportArr removeObjectAtIndex:num];
    [_supportViewArr removeObject:tView];
    [sender.superview removeFromSuperview];
    NSMutableArray *arr = _supportArr;
    NSString *sunStr  = [NSString stringWithFormat:@"%.0f",[[arr valueForKeyPath:@"@sum.floatValue"]floatValue]];
    [[HcCustomKeyboard  customKeyboard]totlaLabel].text = [NSString stringWithFormat:@"总共：%@元",sunStr];
    
    NSInteger high = 40;
    for (NSInteger i=0; i<_supportViewArr.count; i++) {
        UIView *tempView = _supportViewArr[i];
        tempView.frame = CGRectMake(0, i*high, SCREEN_WIDTH, high);
    }
    CGRect rect = [[HcCustomKeyboard  customKeyboard] mBackView].frame;
    rect.size.height =  rect.size.height-high;
    rect.origin.y = rect.origin.y+high;
    [[HcCustomKeyboard  customKeyboard] mBackView].frame = rect;
    
    CGRect rect2 = [[HcCustomKeyboard  customKeyboard] mainView].frame;
    rect2.origin.y = rect2.origin.y-high;
    [[HcCustomKeyboard  customKeyboard] mainView].frame = rect2;
    
    
    CGRect rect3 = self.tableView.frame;
    rect3.size.height =  rect3.size.height+high;
    self.tableView.frame = rect3;

}

-(void)showList:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {//去隐藏
        NSInteger high = 40*_supportViewArr.count;
        CGRect rect = [[HcCustomKeyboard  customKeyboard] mBackView].frame;
        rect.size.height =  rect.size.height-high;
        rect.origin.y = rect.origin.y+high;
        [[HcCustomKeyboard  customKeyboard] mBackView].frame = rect;
        
        CGRect rect2 = [[HcCustomKeyboard  customKeyboard] mainView].frame;
        rect2.origin.y = rect2.origin.y-high;
        [[HcCustomKeyboard  customKeyboard] mainView].frame = rect2;
        CGRect rect3 = self.tableView.frame;
        rect3.size.height =  rect3.size.height+high;
        self.tableView.frame = rect3;
        for (NSInteger i=0; i<_supportViewArr.count; i++) {
            UIView *tempView = _supportViewArr[i];
            tempView.hidden= YES;
        }
    }else{
        NSInteger high = 40*_supportViewArr.count;
        CGRect rect = [[HcCustomKeyboard  customKeyboard] mBackView].frame;
        rect.size.height =  rect.size.height+high;
        rect.origin.y = rect.origin.y-high;
        [[HcCustomKeyboard  customKeyboard] mBackView].frame = rect;
        
        CGRect rect2 = [[HcCustomKeyboard  customKeyboard] mainView].frame;
        rect2.origin.y = rect2.origin.y+high;
        [[HcCustomKeyboard  customKeyboard] mainView].frame = rect2;
        
        CGRect rect3 = self.tableView.frame;
        rect3.size.height =  rect3.size.height-high;
        //    rect3.origin.y = rect3.origin.y+high;
        self.tableView.frame = rect3;
        
        for (NSInteger i=0; i<_supportViewArr.count; i++) {
            UIView *tempView = _supportViewArr[i];
            tempView.hidden= NO;
             tempView.frame = CGRectMake(0, i*40, SCREEN_WIDTH, 40);
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)talkBtnClick:(UITextView *)textViewGet
{
    
    
    NSString *sd = [[HcCustomKeyboard  customKeyboard]mTextView].text;
    [MOMProgressHUD showSuccessWithStatus:sd];
    [self doSupport:sd];
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
 1、用的比较多的方法：点击背景View收起键盘或者直接使用也可以（你的View必须是继承于UIControl）
 
 [self.view endEditing:YES];
 2、万能方法：在任何地方都可以使用这种方法来关闭/收起键盘
 [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
 3、点击Return按扭时收起键盘
 - (BOOL)textFieldShouldReturn:(UITextField *)textField
 {
 return [textField resignFirstResponder];
 }
*/

@end
