//
//  AsHackerTests.m
//  AsHackerTests
//
//  Created by 陈涛 on 2017/3/20.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOMNetWorking.h"
#import "MOMTimeHelper.h"
@interface AsHackerTests : XCTestCase

@end

@implementation AsHackerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testJK
{
    
    int datesInt =  [MOMTimeHelper comparetoDay:@"2017-12-10"];
    NSLog(@"datesInt---%ld",datesInt);
//   int  i=   [MOMTimeHelper comparetoDay:@"2017-06-26"];
//    int  i1=   [MOMTimeHelper comparetoDay:@"2017-06-25"];
//    int  i2=   [MOMTimeHelper comparetoDay:@"2017-06-27"];
//    int  i3=   [MOMTimeHelper comparetoDay:@"2017-07-26"];
//    NSString *endDate = @"2017-06-26";//[aDic objectForKey:@"END_DATE"];
//    NSDateFormatter *format = [[NSDateFormatter alloc]init];
//    [format setDateFormat:@"yyyy-MM-dd"];
//    //        NSString *todayStr =  [format stringFromDate:[NSDate new]];
//    NSDate *compareDate = [format dateFromString:endDate];
//    //        NSDate *todayDate =  [NSDate new];
//    
//    
//    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
////    timeInterval = -timeInterval;
//    //        long temp = 0;
//    //        NSString *result;
//    if (timeInterval/60/60/24<=1&&timeInterval/60/60/24>=0) {
//        
//    }

//    userId=2007034183&method=pay&payType=支付宝&eventType=自然发生&eventId=21&enrollMoney=0.01

//[MOMNetWorking asynRequestByMethod:@"pay" params:@{@"userId":@"2007034183",@"eventType":@"自然发生",
//                                                   @"payType":@"支付宝",
//                                                   @"eventId":@"21",
//                                                   @"enrollMoney":@"0.01"
//                                                   } publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//    NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//    NSDictionary *dic = result;
//    if (MOMResultSuccess==ret) {
//        
//    }
//}];
////    [{"key":"PROJECT_ID","value":"47","description":""}]
//        [MOMNetWorking asynRequestByMethod:@"enroll" params:@{@"PROJECT_ID":@"54"} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
//            
//        }
//    }];
    
    
//    [MOMNetWorking asynRequestByMethod:@"getIfVolunteer" params:@{@"PROJECT_ID":@108} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
//        //            if (!result) {
//        //                 [[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络访问不成功，请点击屏幕重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil ]show];
//        //            }else{
//        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
//        NSDictionary *dic = result;
//        if (MOMResultSuccess==ret) {
////            _dataArr = [dic objectForKey:@"projects"];
////            [self.tableView reloadData];
//        }
//        //            }
//        
//    }];
}
- (void)testExample {
    [MOMNetWorking asynRequestByMethod:@"login" params:@{@"userId":@"111111"} publicParams:MOMNetPublicParamNone callback:^(id result, NSError *error) {
        NSInteger ret = [[result objectForKey:@"statusCode"] integerValue];
        NSDictionary *dic = result;
        if (MOMResultSuccess==ret) {
        }
    }];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
