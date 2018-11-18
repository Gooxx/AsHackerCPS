//
//  ASHMineUserEditController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/9.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMineUserEditController.h"

@interface ASHMineUserEditController ()
@property (weak, nonatomic) IBOutlet UITextField *detailTF;

@end

@implementation ASHMineUserEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    _detailTF.text = _detailValue;
}
-(void)doSave:(UIBarButtonItem *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (!_detailTF.text||[@"" isEqualToString:_detailTF.text]) {
        _cell.detailTextLabel.text = @"未填写~·~";
        _cell.detailTextLabel.textColor = [UIColor whiteColor];
    }else{
        _cell.detailTextLabel.text = _detailTF.text;
        _cell.detailTextLabel.textColor = MOMLightGrayColor;
        if ([_delegate respondsToSelector:@selector(doSave)]) {
            [_delegate performSelector:@selector(doSave)];
        }
        
    }
}

-(BOOL)checkNull:(NSString *)str
{
    if (str&&![@"" isEqualToString:str]) {
        return YES;
    }
    return NO;
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
