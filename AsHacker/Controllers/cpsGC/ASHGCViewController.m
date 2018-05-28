//
//  ASHGCViewController.m
//  AsHackerCPS
//
//  Created by 陈涛 on 2018/5/22.
//  Copyright © 2018年 Sinanbell. All rights reserved.
//

#import "ASHGCViewController.h"

@interface ASHGCViewController ()
@property(nonatomic,strong)NSArray *dataArr;
@end

static NSString * const collectionCell = @"cpsCarCollectCell";
static NSString * const tableCell = @"cpsCarCell";

@implementation ASHGCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    NSString * name = @"Info";
//    NSString *PLIST = @"plist";
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
//    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,PLIST]];
//
//    NSLog(@"plist path:%@---path1:%@",path,path1);
//
////    [PListUtil plistArrayByName:'Info.plist'];
//    id aaa = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    id aaa1 = [[NSMutableDictionary alloc] initWithContentsOfFile:path1];
    [self loadData:^(NSDictionary *dict) {
        
    }];
}
-(NSArray *)dataArr{
    return _dataArr?_dataArr:[NSArray array];
}
- (void)loadData:(void (^)(NSDictionary *dict))otherAction {
    __weak typeof(self)weakSelf = self;
    
//    [MOMNetWorking asynRequestByMethod:@"" params:@"" publicParams:@"" callback:^(id result, NSError *error) {
//
//    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [manager POST:@"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度条uploadProgress------------:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            [MOMProgressHUD dismiss];
        NSError *error=nil;
        //成功 cb是对方传递过来的对象 这里是直接调用
        //            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        string = [string stringByReplacingOccurrencesOfString:@"<script language=\"javascript\" type=\"text/javascript\">window.top.window.jQuery(\"#temporary_iframe_id\").data(\"deferrer\").resolve(" withString:@""];
//        string = [string stringByReplacingOccurrencesOfString:@");</script>" withString:@""];
//        string = [string stringByReplacingOccurrencesOfString:@"\"\"\"" withString:@"\""];
        //            string = [string stringByReplacingOccurrencesOfString:@"0\"\"" withString:@""];
        
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSSLog(@"URLStr-----obj:%@",obj);
        
        NSArray *array = [obj objectForKey:@"letters"];
        NSMutableArray *mul_array = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            ASHCarInfoModel *model = [ASHCarInfoModel ModelWithDict:dic];
            [mul_array addObject:model];
        }
        
//        ASHCarInfoModel *carInfoModel =[ASHCarInfoModel ModelWithDict:obj];
        NSSLog(@"obj------------:%@",mul_array);
        
         weakSelf.dataArr = [mul_array copy];
        [self.tableView reloadData];
        
//        callback(obj,error);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            [MOMProgressHUD dismiss];
        NSSLog(@"failure-----------网络请求失败了");
//        callback(nil,error);
    }];
    
   
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    
    
    return cell;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ASHCarInfoModel *model = [self.dataArr objectAtIndex:section];
    return model.brands.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
    
    ASHCarInfoModel *carInfoModel = [self.dataArr objectAtIndex:indexPath.section];
    CarBrandModel *brand = [carInfoModel.brands objectAtIndex:indexPath.row];
    if ([brand isKindOfClass:[CarBrandModel class]]) {
//        UIImage *image = [UIImage imageNamed: [(CarBrandModel *)brand icon]];
        
//        cell.imageView.image =image;
        [cell.imageView ash_setImageWithURL:[(CarBrandModel *)brand icon]];
        
        [cell.imageView limitImage:[(CarBrandModel *)brand icon] withSize:CGSizeMake(30, 30)];
    }
   
    cell.textLabel.text =  [(CarBrandModel *)brand name];
    //    static NSString *cellName =
    //    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[indexPath.row] forIndexPath:indexPath];
    //    NSDictionary *dic = _dataArr[indexPath.row];
    //    [cell showMainData:dic];
    return cell;
}


- (void)bindModel:(id)model {
    
//    __weak typeof(self)wself = self;
//    NSString *url = @"";
//    if ([model isKindOfClass:[CarBrandModel class]]) {
//        url = [(CarBrandModel *)model icon];
//    }
//    [_icon ash]
//    [_icon sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        wself.icon.image = image;
//    }];
//
//    if ([model isKindOfClass:[CarBrandModel class]]) {
//        self.contentLabel.text = [(CarBrandModel *)model name];
//    }else{
//        self.contentLabel.text = @"";
//    }
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
