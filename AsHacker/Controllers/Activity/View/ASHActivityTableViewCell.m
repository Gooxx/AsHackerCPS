//
//  ASHActivityTableViewCell.m
//  AsHacker
//
//  Created by 陈涛 on 2017/4/7.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHActivityTableViewCell.h"

@implementation ASHActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        /*
        self.backgroundColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor blackColor];
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.size.height = 208;self.bounds.size.height;
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = rect;[UIScreen mainScreen].bounds;//CGRectMake(0, 0, 375, 278);
        [self.contentView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"视频详情渐变"];
        _mainIV = imageView;
        
        UIView *bgview = [[UIView alloc]initWithFrame:imageView.frame];
        bgview.backgroundColor= [[UIColor blackColor]colorWithAlphaComponent:0.2];
        [self.contentView addSubview:bgview];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 80, rect.size.width, 30);CGRectMake(70, 110, 235, 24);
        label.text = @"EVER HAD A NIGHT";
        label.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:24];
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
        
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 113, rect.size.width, 20);
        label.frame = CGRectMake(0, 140, 375, 18);
        label.text = @"Arlen / 2’14”";
        label.font = [UIFont fontWithName:@".PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1/1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _nameLabel = label;
        */
        /*
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 250, 25, 14);
        label.text = @"看过";
        label.font = [UIFont fontWithName:@".PingFangSC-Regular" size:12];
        label.textColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1/1.0];
        [self.contentView addSubview:label];
        _lookLabel = label;
        
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(270, 250, 18, 14);
        [btn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
        
        btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(330, 250, 18, 14);
        [btn setImage:[UIImage imageNamed:@"缓存"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        _downloadBtn = btn;
        
        */
        
        
        
       
        
    }
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
