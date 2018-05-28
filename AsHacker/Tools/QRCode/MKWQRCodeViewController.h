//
//  MKWQRCodeViewController.h
//  MKWatch
//
//  Created by goooo on 15/8/18.
//  Copyright (c) 2015年 goooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol QRCodeDelegate <NSObject>

@optional
-(void)QRCode:(NSString *)code;
@end

@interface MKWQRCodeViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic) id<QRCodeDelegate> delegate;
@end
