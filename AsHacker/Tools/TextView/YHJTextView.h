//
//  YHJTextView.h
//  TextView~Placeholder
//
//  Created by 阳光 on 16/6/23.
//  Copyright © 2016年 com_qibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHJTextView : UITextView

//文字
@property(nonatomic,copy)NSString *myPlaceholder;

//文字颜色
@property(nonatomic,strong)UIColor *myPlaceholderColor;

@end
