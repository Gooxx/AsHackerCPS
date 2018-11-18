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

@property(nonatomic,strong)NSArray *bandArr;
@property(nonatomic,strong)NSArray *topArr;

@property(nonatomic,strong)NSMutableArray *indexArray;//去重后的首字母
@property(nonatomic,strong)NSMutableArray *letterResultArr;//按照首字母排序后的集合
@end

static NSString * const collectionCell = @"cpsCarCollectCell";
static NSString * const tableCell = @"ASHBandTableViewCell";

@implementation ASHGCViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self updateData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 自适应高的cell
    self.tableView.estimatedRowHeight = 150.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self updateData];
    
    
}


-(void)updateData{
    [MOMNetWorking asynRequestByMethod:@"topCarList.do" params:nil publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"ret"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
            
//            _dataArr = [dic objectForKey:@"listCar"];
//            listCar
//            "car_name": "A6",
//            "id": "2",
//            "show_pic": ""
            NSArray *arr  =[dic objectForKey:@"listBrand"];
            
            
            _topArr  =[dic objectForKey:@"listCar"];
            
            CarBrandModel *carBandModel = [CarBrandModel ModelsWithArray:arr];
            self.indexArray =[NSMutableArray arrayWithObject:@"top"];
           [self.indexArray addObjectsFromArray:[ChineseString IndexArray:carBandModel]];
            self.letterResultArr =[NSMutableArray arrayWithObject:@[[CarBrandModel new]]];;
            [self.letterResultArr addObjectsFromArray:[ChineseString LetterSortArray:carBandModel]] ;
            
            
            [self.tableView  reloadData];
            
//            NSArray*indexArray = [arr arraywithpin  arrayWithPinYinFirstLetterFormat];
//
//            self.dataArr= [NSMutableArrayarrayWithArray:indexArray];
            
//            listBrand
//            "brand_cnName": "阿尔法·罗密欧",
//            "brand_enName": "aerfa·luomiou",
//            "brand_logo": "http://39.105.46.149/cps/fileUpload/brand/carImg2.jpg",
//            "id": "3"
            
        }
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
    return _topArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = _topArr;
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    ASHGCTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.carLabel.text =[dic objectForKey:@"car_name"];
    [cell.carIV ash_setImageWithURL:[dic objectForKey:@"show_pic"]];
    
    
    return cell;
}


#pragma mark -Table View Data Source Methods
#pragma mark -设置右方表格的索引数组

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{



        return [self.indexArray objectAtIndex:section];

}

-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.letterResultArr objectAtIndex:section]count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0&&indexPath.row==0) {
        return 250;
    }else{
        return UITableViewAutomaticDimension;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarBrandModel *model =[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    ASHGCarTableViewController *ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"ASHGCarTableViewController"];
    ctl.bandId = model.id;
    [self.navigationController pushViewController:ctl animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        ASHGCTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASHGCTopTableViewCell" forIndexPath:indexPath];
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
        return cell;
    }else{
        
        ASHBandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
        
        CarBrandModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.nameLabel.text =model.brand_cnName;
        [cell.iconIV ash_setImageWithURL:[model brand_logo]];
        //    cell.textLabel.text =  [(CarBrandModel *)brand name];
        //    static NSString *cellName =
        //    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[indexPath.row] forIndexPath:indexPath];
        //    NSDictionary *dic = _dataArr[indexPath.row];
        //    [cell showMainData:dic];
        return cell;
    }
    return nil;
//    BookItemViewCell *cell = [BookItemViewCell cellWithTableView:tableView];
//    cell.book=[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    cell.delegate=self;
//    return cell;
}


/*
#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];

    for(char c = 'A';c<='Z';c++)

        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];

    return toBeReturned;
    
//    NSMutableArray*resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
//
//    for(NSDictionary*dict in self.dataArray) {
//
//        NSString*title = dict[@"firstLetter"];
//
//        [resultArrayaddObject:title];
//
//    }
//
//    return resultArray;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    
    if([title isEqualToString:UITableViewIndexSearch])
        
    {
        [tableView setContentOffset:CGPointZero animated:NO];
//        [tableView  setContentOff set:CGPointZero animated:NO];//tabview移至顶部
        
        return NSNotFound;
        
    }
    
    else
        
    {
        return [[UILocalizedIndexedCollation currentCollation]sectionForSectionIndexTitleAtIndex:index]-1;
//        return[[UILocalizedIndexedCollation currentCollation]sectionForSectionIndexTitleAtIndex:index] -1;// -1添加了搜索标识
        
    }
    
   
//    NSInteger count = 0;
//
//    for(NSString *character in _bandArr)
//
//    {
//
//        if([character isEqualToString:title])
//
//            {
//
//            return count;
//
//            }
//
//        count ++;
//
//    }
//
//    return 0;
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    if([arrayOfCharacters count]==0)
//
//        {
//
//        return @"";
//
//        }
//
//        return [arrayOfCharacters objectAtIndex:section];
//
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _bandArr.count;//1;//self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    ASHCarInfoModel *model = [self.dataArr objectAtIndex:section];
//    return _bandArr.count;//model.brands.count;
    if(section ==0) {
        
        return 1;
        
    }else{
        
        NSDictionary*dict =_bandArr[section];
        
        NSMutableArray*array = dict[@"content"];
        
        return [array count];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
    
//    ASHCarInfoModel *carInfoModel = [self.dataArr objectAtIndex:indexPath.section];
//    CarBrandModel *brand = [carInfoModel.brands objectAtIndex:indexPath.row];
//    if ([brand isKindOfClass:[CarBrandModel class]]) {
//        UIImage *image = [UIImage imageNamed: [(CarBrandModel *)brand icon]];
        
//        cell.imageView.image =image;
//        [cell.imageView ash_setImageWithURL:[(CarBrandModel *)brand icon]];
//
//        [cell.imageView limitImage:[(CarBrandModel *)brand icon] withSize:CGSizeMake(30, 30)];
//    }
    cell.textLabel.text = @"1";
//    cell.textLabel.text =  [(CarBrandModel *)brand name];
    //    static NSString *cellName =
    //    ASHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNames[indexPath.row] forIndexPath:indexPath];
    //    NSDictionary *dic = _dataArr[indexPath.row];
    //    [cell showMainData:dic];
    return cell;
}

*/
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
