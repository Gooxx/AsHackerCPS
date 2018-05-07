//
//  ASHAlertView.m
//  AsHacker
//
//  Created by 陈涛 on 2017/5/19.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHAlertView.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
@implementation ASHAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] firstObject];
    self.frame =MOMScreenBounds;
    self.center=CGPointMake(WIDTH/2, HEIGHT/2);

    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtClick)];
    [self addGestureRecognizer:tapG];
    return self;
}
+(instancetype)alterMainMenuView
{
    
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] objectAtIndex:1];
     alertView.frame =MOMScreenBounds;
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);

    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
    return alertView;
}

+(instancetype)alterMainMenuViewIn:(UIView *)view
{
    
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] objectAtIndex:1];
    
    alertView.frame =MOMScreenBounds;
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);
    [view addSubview:alertView];
    
   UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
   
    return alertView;
}

+(instancetype)alterDetailMenuView
{
    
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] objectAtIndex:2];

    alertView.frame =MOMScreenBounds;
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);

    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
    return alertView;
}


+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                            image:(NSString *)image
{
   
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] firstObject];
    alertView.backgroundColor=[UIColor clearColor];
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);
    
    [alertView.removeBtn addTarget:alertView action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
    return alertView;
}

+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
{
    
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] objectAtIndex:1];
    alertView.backgroundColor=[UIColor clearColor];
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);
    
    [alertView.removeBtn addTarget:alertView action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
    //        self.frame=frame;
    //    }
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
    return alertView;
}

+(instancetype)alterQRCodeViewWithCode:(NSString *)code
{
    ASHAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"ASHAlertView" owner:self options:nil] objectAtIndex:5];
//    alertView.backgroundColor=[UIColor clearColor];
    alertView.frame =MOMScreenBounds;
    alertView.center=CGPointMake(WIDTH/2, HEIGHT/2);
    
    
    alertView.mainIV.image = [ASHQRCodeHelper qrImageForString:code imageSize:200 logoImageSize:200];
    [alertView.removeBtn addTarget:alertView action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
    //        self.frame=frame;
    //    }
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:alertView action:@selector(cancelBtClick)];
    [alertView addGestureRecognizer:tapG];
    return alertView;

}
//2
- (IBAction)alert_doShare:(id)sender {
    if ([_delegate respondsToSelector:@selector(doShare:)]) {
        [_delegate performSelector:@selector(doShare:) withObject:sender];
    }
    [self removeFromSuperview];
}
- (IBAction)alert_doReport:(id)sender {
    if ([_delegate respondsToSelector:@selector(doReport:)]) {
        [_delegate performSelector:@selector(doReport:) withObject:sender];
    }
    [self removeFromSuperview];
}


//1
- (IBAction)showAll:(id)sender {
    if ([_delegate respondsToSelector:@selector(showAll:)]) {
        [_delegate performSelector:@selector(showAll:) withObject:sender];
    }
    [self removeFromSuperview];
    
}
- (IBAction)showDoing:(id)sender {
    if ([_delegate respondsToSelector:@selector(showDoing:)]) {
        [_delegate performSelector:@selector(showDoing:) withObject:sender];
    }
    [self removeFromSuperview];
}
- (IBAction)showEnd:(id)sender {
    if ([_delegate respondsToSelector:@selector(showEnd:)]) {
        [_delegate performSelector:@selector(showEnd:) withObject:sender];
    }
    [self removeFromSuperview];
}

//0
- (IBAction)doApply:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(doJoin2:)]) {
        [_delegate performSelector:@selector(doJoin2:) withObject:sender];
    }
    [self removeFromSuperview];
}
- (IBAction)doDisplay:(id)sender {
//    [self removeFromSuperview];
    
    [self removeFromSuperview];
//    [ASHMainUser setShowTip:NO];
}
- (IBAction)beVolunteer:(id)sender {
    if ([_delegate respondsToSelector:@selector(beVolunteer:)]) {
        [_delegate performSelector:@selector(beVolunteer:) withObject:sender];
    }
    [self removeFromSuperview];
}
#pragma mark----取消按钮点击事件
-(void)cancelBtClick
{
    [self removeFromSuperview]; 
//    [self.superview removeFromSuperview];
//    self.cancel_block();
}
//    -(void)cancelBtClick:(UIView *)view
//{
//    //    [self removeFromSuperview];
//    [view removeFromSuperview];
//    //    self.cancel_block();
//}
@end
