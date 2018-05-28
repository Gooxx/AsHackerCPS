//
//  MKWQRCodeViewController.m
//  MKWatch
//
//  Created by goooo on 15/8/18.
//  Copyright (c) 2015年 goooo. All rights reserved.
//

#import "MKWQRCodeViewController.h"
//#import "MKWQRCodeWriteViewController.h"
#import "Config.h"

@interface MKWQRCodeViewController ()

@end

@implementation MKWQRCodeViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title  = MyLocalizedString(@"添加设备");
    UIBarButtonItem *codeBtn = [[UIBarButtonItem alloc]initWithTitle:@"手动添加" style:UIBarButtonItemStylePlain target:self action:@selector(writeQRCode:)];
    self.navigationItem.rightBarButtonItem = codeBtn;
    self.view.backgroundColor = [UIColor whiteColor];

    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-140, 110, 280, 2)];
//    _line.image = [UIImage imageNamed:@"pd_r4_c3"];
    _line.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    [self checkAVAuthorizationStatus];
}

-(void)writeQRCode:(id)sender
{
//    MKWQRCodeWriteViewController *qcwController = [[MKWQRCodeWriteViewController alloc]init];
//    [self.navigationController pushViewController:qcwController animated:YES];
}
/**
 *  扫描动画
 */
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(self.view.center.x-140, 110+2*num, 280, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(self.view.center.x-140, 110+2*num, 280, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
/**
 *  返回上一级
 */
-(void)backAction
{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self setupCamera];
    //    [self checkAVAuthorizationStatus];
}
/**
 *  检验摄像头
 */
- (void)checkAVAuthorizationStatus{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSLog(@"AVAuthorizationStatus status:%d",status);
    //    if(status == AVAuthorizationStatusAuthorized) {
    [self setupCamera];
    //    }else{
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedStringFromTable(@"请在iPhone的 设置-隐私-相机 中允许访问相机。",@"MyLocalizable", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alert show];
    //    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //    [[AVCaptureMetadataOutput alloc]init] setMetadataObjectsDelegate:<#(id<AVCaptureMetadataOutputObjectsDelegate>)#> queue:<#(dispatch_queue_t)#>;
    
    [[AVCaptureSession alloc]init];
    
}
/**
 *  开启摄像头
 */
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        NSLog(@"扫描类型ok!");
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedStringFromTable(@"请在iPhone的 设置-隐私-相机 中允许访问相机。",@"MyLocalizable", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(self.view.center.x-140,110,280,280);
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
//    self.parentDelegate.username.text = stringValue;
    
    
//    MKWQRCodeWriteViewController *qcwController = [[MKWQRCodeWriteViewController alloc]init];
//    qcwController.watchId = stringValue;
//    qcwController.watchIdTF.text = stringValue;
//    [self.navigationController pushViewController:qcwController animated:YES];
    if (_delegate&&[_delegate respondsToSelector:@selector(QRCode:)]) {
        [_delegate QRCode:stringValue];
    }
    
     [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
