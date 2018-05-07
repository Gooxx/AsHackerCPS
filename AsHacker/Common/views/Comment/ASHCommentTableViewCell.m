//
//  ASHCommentTableViewCell.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/12.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHCommentTableViewCell.h"

@implementation ASHCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.masksToBounds =YES;
    self.iconIV.layer.cornerRadius = self.iconIV.bounds.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)doZan:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    sender.highlighted = sender.selected;
    
    NSString *znumStr = _znumLabel.text;
    NSInteger znum = [znumStr integerValue];
    if (sender.selected) {//赞了

        _znumLabel.text = [NSString stringWithFormat:@"%ld",znum+1];

         NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_pingId,@"pingId", nil];
        if (_pingId&&![@"" isEqualToString:_pingId]) {
            [MOMNetWorking asynRequestByMethod:@"zan_comment" params:params publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
                NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
                NSDictionary *dic = result;
                if (MOMResultSuccess==ret) {//成功  更新数字
                    //                NSString *count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
                    //                _znumLabel.text = count;
                    
                }else{//失败  回复一下数字
                    _znumLabel.text = [NSString stringWithFormat:@"%ld",znum];
                    
                }
            }];
        }else{
            
        }
        
        

    }else{//取消赞
        
        _znumLabel.text = [NSString stringWithFormat:@"%ld",znum-1];
    }
    
    
}

@end
