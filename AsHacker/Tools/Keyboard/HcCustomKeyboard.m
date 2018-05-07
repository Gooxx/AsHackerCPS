//
//  HcCustomKeyboard.m
//  Custom
//
//  Created by 黄诚 on 14/12/18.
//  Copyright (c) 2014年 huangcheng. All rights reserved.
//

#import "HcCustomKeyboard.h"
#import <UIKit/UIKit.h>

//屏幕宽度
#define WIDTH_SCREEN [UIScreen mainScreen].applicationFrame.size.width
//屏幕高度
#define HEIGHT_SCREEN [UIScreen mainScreen].applicationFrame.size.height

//#define WIDTH_SCREEN ([UIScreen mainScreen].bounds.size.width)
//#define HEIGHT_SCREEN ([UIScreen mainScreen].bounds.size.height)


@implementation HcCustomKeyboard
@synthesize mDelegate;

static HcCustomKeyboard *customKeyboard = nil;

-(void)cleancustomKeyboard
{
    customKeyboard = nil;
}
+(HcCustomKeyboard *)customKeyboard
{
    @synchronized(self)
    {
        if (customKeyboard == nil)
        {
            customKeyboard = [[HcCustomKeyboard alloc] init];
        }
        return customKeyboard;
    }
}
+(id)allocWithZone:(struct _NSZone *)zone //确保使用者alloc时 返回的对象也是实例本身
{
    @synchronized(self)
    {
        if (customKeyboard == nil)
        {
            customKeyboard = [super allocWithZone:zone];
        }
        return customKeyboard;
    }
}
+(id)copyWithZone:(struct _NSZone *)zone //确保使用者copy时 返回的对象也是实例本身
{
    return customKeyboard;
}
-(instancetype)init{
    self.mBackView = [[[NSBundle mainBundle]loadNibNamed:@"HcCustomKeyboard" owner:nil options:nil]firstObject];
    return  self;
}
- (IBAction)doTalk:(id)sender {
    [mDelegate talkBtnClick:self.mTextView];
}
-(void)textViewShowView:(UIViewController *)viewController customKeyboardDelegate:(id)delegate
{
    self.mViewController =viewController;
    self.mDelegate =delegate;
    self.isTop = NO;//初始化的时候设为NO
    _lineArr = [NSMutableArray array];
    
    self.mBackView.frame=CGRectMake(0, HEIGHT_SCREEN-50-100+5, WIDTH_SCREEN, 100+100);
    [self.mViewController.view addSubview:self.mBackView];

    [self.mViewController.view bringSubviewToFront:self.mBackView];

    self.mTextView.text = @"想对他们说些什么~";
    
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.mTextView resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.mTextView.text = nil;
    return YES;
}

-(void)forTalk //评论按钮
{
    NSLog(@"89089080938201390129");
    
    
}
-(void)hideView //点击屏幕其他地方 键盘消失
{
    NSLog(@"屏幕消失");
    [self.mTextView resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification*)notification //键盘出现
{
    self.isTop =YES;
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%f-%f",_keyboardRect.origin.y,_keyboardRect.size.height);
    
    if (!self.mHiddeView)
    {

        self.mHiddeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_SCREEN,HEIGHT_SCREEN)];
        
        self.mHiddeView.backgroundColor =[UIColor blackColor];
        self.mHiddeView.alpha =0.0f;
        [self.mViewController.view addSubview:self.mHiddeView];
        
        UIButton *hideBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        hideBtn.backgroundColor =[UIColor clearColor];
        hideBtn.frame = self.mHiddeView.frame;
        [hideBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [self.mHiddeView addSubview:hideBtn];
        if([self.mTextView.text isEqualToString:@"想对他们说些什么~"]){
            self.mTextView.text = @"";
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mHiddeView.alpha =0.4f;
        self.mBackView.frame =CGRectMake(0, HEIGHT_SCREEN-_keyboardRect.size.height-5+38-CGRectGetHeight(self.mBackView.frame), WIDTH_SCREEN, CGRectGetHeight(self.mBackView.frame));
        [self.mViewController.view bringSubviewToFront:self.mBackView];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)keyboardWillHide:(NSNotification*)notification //键盘下落
{    
    self.isTop =NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.mBackView.frame =CGRectMake(0, HEIGHT_SCREEN-5-CGRectGetHeight(self.mBackView.frame), WIDTH_SCREEN, CGRectGetHeight(self.mBackView.frame));
            self.mHiddeView.alpha =0.0f;
        } completion:^(BOOL finished) {
            [self.mHiddeView removeFromSuperview];
            self.mHiddeView =nil;
//          self.mTextView.text =@"想对他们说些什么~"; //键盘消失时，恢复TextView内容
    }];
}
- (void)textDidChanged:(NSNotification *)notif //监听文字改变 换行时要更改输入框的位置
{
    NSLog(@"文字改变");
}

-(void)dealloc //移除通知
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}



@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
