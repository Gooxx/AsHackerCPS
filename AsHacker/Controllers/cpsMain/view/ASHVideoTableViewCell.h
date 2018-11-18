//
//  ASHVideoTableViewCell.h
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/9/19.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASHVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (nonatomic, copy  ) void(^playBlock)(UIButton *);

@end
