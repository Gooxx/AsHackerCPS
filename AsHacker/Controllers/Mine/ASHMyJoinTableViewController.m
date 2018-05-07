//
//  ASHMyJoinTableViewController.m
//  AsHacker
//
//  Created by 陈涛 on 2017/9/21.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import "ASHMyJoinTableViewController.h"
#import "ASHMySupportDetailTableViewCell.h"
@interface ASHMyJoinTableViewController ()

@end

@implementation ASHMyJoinTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    NSDictionary *dic = _dataDic;//_dataArr[indexPath.row];
    self.navigationItem.title = @"筹小鸭"; //标题  name
   [self.tableView registerNib:[UINib nibWithNibName:@"ASHMySupportDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"tcell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section) {
        return UITableViewAutomaticDimension;
    }else{
        return 500;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        ASHMySupportDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
        [cell.showDetailBtn addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dic = _dataDic;//_dataArr[indexPath.row];
        [cell showDetailData:dic];
        return cell;
    }else{
        ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *dic = _dataDic;//_dataArr[indexPath.row];
        NSString *code =  [NSString stringWithFormat:@"入场码：%@",[dic objectForKey:@"ENTER_CODE"]];
        cell.titleLabel.text = code;
        
        UIImage *image =  [ASHMyJoinTableViewController qrImageForString:code imageSize:100 logoImageSize:100];
        cell.picIV.image = image;
        
        return cell;
    }
    
}
-(void)showDetail
{
    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ASHFirstDetailTableViewController *ctl = [storyboard instantiateViewControllerWithIdentifier:@"ASHFirstDetailTableViewController"];
    ctl.dataDic = _dataDic;
    
    [self.navigationController pushViewController:ctl animated:YES];
}

- (IBAction)deleteJoin:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"组织者已登记了你的报名信息，确定要取消报名吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消报名" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [MOMNetWorking asynRequestByMethod:@"quit" params:@{@"projectId":[_dataDic objectForKey:@"PROJECT_ID"]} publicParams:MOMNetPublicParamUserId callback:^(id result, NSError *error) {
            
            NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
            NSDictionary *dic = result;
            if (MOMResultSuccess==ret) {
                [MOMProgressHUD showSuccessWithStatus:@"取消报名成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MOMProgressHUD showSuccessWithStatus:@"取消报名失败，请重试"];
            }
            
        }];
    }]];

    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];

}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //logo图
    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
