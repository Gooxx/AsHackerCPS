//
//  ASHVideotapeViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/8/31.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHVideotapeViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface ASHVideotapeViewController (){
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput <GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    GPUImageView *filterView;
    NSURL *movieURL;
}

@end

@implementation ASHVideotapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    //输出方向为竖屏
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //滤镜
    filter = [[GPUImageSepiaFilter alloc] init];
//    //显示view
//    filterView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 400)];
    filterView.backgroundColor = [UIColor redColor];
    [self.view addSubview:filterView];
    
    //组合
    [videoCamera addTarget:filter];
    [filter addTarget:filterView];
    
    //相机开始运行
    [videoCamera startCameraCapture];
    
    //设置写入地址
//    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LiveMovied.m4v"];
    NSString *pathToMovie = [@"Documents/" stringByAppendingFormat:@"Movie%d.m4v",(int)[[NSDate date] timeIntervalSince1970]];
    
    movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    //设置为liveVideo
    movieWriter.encodingLiveVideo = YES;
    [filter addTarget:movieWriter];
    //设置声音
//    videoCamera.audioEncodingTarget = movieWriter;
//    [movieWriter startRecording];
    //延迟2秒开始
        [self performSelector:@selector(starWrite) withObject:nil afterDelay:2];
    //延迟12秒结束
    
    [self performSelector:@selector(stopWrite) withObject:nil afterDelay:12];
}
    

- (void)starWrite{
    dispatch_async(dispatch_get_main_queue(), ^{
        [movieWriter startRecording];
    });
    
}
- (void)stopWrite{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        videoCamera.audioEncodingTarget = nil;
        [filter removeTarget:movieWriter];
        [movieWriter finishRecording];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:movieURL])
        {
            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     if (error) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     } else {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     }
                 });
             }];
        }
        
        
        
    });
    
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
