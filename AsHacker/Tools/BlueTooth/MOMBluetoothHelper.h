//
//  MOMBluetoothHelper.h
//  LivingArea
//
//  Created by goooo on 16/3/25.
//  Copyright © 2016年 mom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#define Main_UUID  @"7C27A67C-8E46-4AE6-8BC0-8A0865E7293F"
//（12）switchChar：开始/停止按钮，UUID：19B10001-E8F2-537E-4F6C-D104768A1214，方式：Read/Write
#define Write_UUID  @"19B10001-E8F2-537E-4F6C-D104768A1214"

////（1）acclXChar：100倍X轴加速度（单位：m/s2），UUID：FF125EA1-E5B1-4323-9913-957826EB5059，方式：Read/Notify
//#define aX_UUID  @"FF125EA1-E5B1-4323-9913-957826EB5059"
////（2）acclYChar：100倍Y轴加速度（单位：m/s2），UUID：24676112-6E73-4159-90E1-147288DD11DD，方式：Read/Notify
//#define aY_UUID  @"24676112-6E73-4159-90E1-147288DD11DD"
////（3）acclZChar：100倍Z轴加速度（单位：m/s2），UUID：593DCD1B-749B-4697-8DC3-709EED98887B，方式：Read/Notify
//#define aZ_UUID  @"593DCD1B-749B-4697-8DC3-709EED98887B"
////（4）gyroXChar：100倍X轴角速度（单位：度/s），UUID：2A19，方式：Read/Notify
//#define gX_UUID  @"2A19"
//
////（5）gyroYChar：100倍Y轴角速度（单位：度/s），UUID：2A20，方式：Read/Notify
//#define gY_UUID  @"2A20"
////（6）gyroZChar：100倍Z轴角速度（单位：度/s），UUID：2A21，方式：Read/Notify
//#define gZ_UUID  @"2A21"


//（7）yawChar：100倍偏转角（单位：度），UUID：93071DD4-F234-4A05-AFE1-E31FEE32DE3C，方式：Read/Notify
#define yaw_UUID  @"93071DD4-F234-4A05-AFE1-E31FEE32DE3C"
//（8）pitchChar：100倍俯仰角（单位：度），UUID：3918E336-40EA-4279-BA4B-BEDFF4FE966A，方式：Read/Notify
#define pitch_UUID  @"3918E336-40EA-4279-BA4B-BEDFF4FE966A"
//（9）rollChar：100倍翻滚角（单位：度），UUID：B79F84F0-239E-4492-90E2-89283A45621B，方式：Read/Notify
#define roll_UUID  @"B79F84F0-239E-4492-90E2-89283A45621B"
//（10）velocityChar：100倍速度（单位：m/s），UUID：2A22，方式：Read/Notify
#define velocity_UUID  @"FF125EA1-E5B1-4323-9913-957826EB5059"
//（11）rotationChar：100倍起跳旋转角（单位：度 ），UUID：2A23，方式：Read/Notify
#define rotation_UUID  @"24676112-6E73-4159-90E1-147288DD11DD"



struct MOMBluetooth{
    float a;
    float b;
};
typedef struct MOMBluetooth MOMBluetooth;

inline  MOMBluetooth  MOMBluetoothMake(float a, float b){
    MOMBluetooth bt;
    bt.a = a;
    bt.b = b;
    return bt;
}

typedef  void(^MOMBluetoothBlock)(CBCharacteristic *characteristic);

@interface MOMBluetoothHelper : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *centralManger;

@property (strong,nonatomic) CBPeripheral *peripheral;

@property (strong,nonatomic) NSTimer *timer;

@property (strong,nonatomic) NSArray *UUIDArr;

@property (nonatomic) MOMBluetooth bluetoothObj;

@property (strong,nonatomic) MOMBluetoothBlock bluetoothBlock;




-(void)start;
-(void)stop;

@end
