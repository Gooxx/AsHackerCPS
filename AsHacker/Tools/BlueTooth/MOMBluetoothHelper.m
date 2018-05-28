//
//  MOMBluetoothHelper.m
//  LivingArea
//
//  Created by goooo on 16/3/25.
//  Copyright © 2016年 mom. All rights reserved.
//

#import "MOMBluetoothHelper.h"

@interface MOMBluetoothHelper ()

@property(strong,nonatomic)CBCharacteristic *writeC;
@end

@implementation MOMBluetoothHelper
//+(void)bluetooth: 
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.centralManger = [[CBCentralManager alloc] initWithDelegate:self
                                                                  queue:nil];
        CBUUID *gyroServiceUUID = [CBUUID UUIDWithString:Main_UUID];
        
//        CBUUID * gyroXCharUUID = [CBUUID UUIDWithString:gX_UUID];
//        CBUUID * gyroYCharUUID = [CBUUID UUIDWithString:gY_UUID];
//        CBUUID * gyroZCharUUID = [CBUUID UUIDWithString:gZ_UUID];
        CBUUID * yawCharUUID   = [CBUUID UUIDWithString:yaw_UUID];
        CBUUID * pitchCharUUID = [CBUUID UUIDWithString:pitch_UUID];
        CBUUID * rollCharUUID  = [CBUUID UUIDWithString:roll_UUID];
        
        CBUUID *writeServiceUUID = [CBUUID UUIDWithString:Write_UUID];
        
//        CBUUID *gXUUID = [CBUUID UUIDWithString:gX_UUID];
//        CBUUID *gYUUID = [CBUUID UUIDWithString:gY_UUID];
//        CBUUID *gZUUID = [CBUUID UUIDWithString:gZ_UUID];
        CBUUID *velocityUUID = [CBUUID UUIDWithString:velocity_UUID];
        CBUUID *rotationUUID = [CBUUID UUIDWithString:rotation_UUID];
        
//        CBUUID *gyroServiceUUID = [CBUUID UUIDWithString:@"7C27A67C-8E46-4AE6-8BC0-8A0865E7293F"];
//        
//        CBUUID * gyroXCharUUID = [CBUUID UUIDWithString:@"FF125EA1-E5B1-4323-9913-957826EB5059"];
//        CBUUID * gyroYCharUUID = [CBUUID UUIDWithString:@"24676112-6E73-4159-90E1-147288DD11DD"];
//        CBUUID * gyroZCharUUID = [CBUUID UUIDWithString:@"593DCD1B-749B-4697-8DC3-709EED98887B"];
//        CBUUID * yawCharUUID   = [CBUUID UUIDWithString:@"93071DD4-F234-4A05-AFE1-E31FEE32DE3C"];
//        CBUUID * pitchCharUUID = [CBUUID UUIDWithString:@"3918E336-40EA-4279-BA4B-BEDFF4FE966A"];
//        CBUUID * rollCharUUID  = [CBUUID UUIDWithString:@"B79F84F0-239E-4492-90E2-89283A45621B"];
//        
//        CBUUID *writeServiceUUID = [CBUUID UUIDWithString:@"19B10001-E8F2-537E-4F6C-D104768A1214"];
//        
//        CBUUID *gXUUID = [CBUUID UUIDWithString:@"2A19"];
//        CBUUID *gYUUID = [CBUUID UUIDWithString:@"2A20"];
//        CBUUID *gZUUID = [CBUUID UUIDWithString:@"2A21"];
//        CBUUID *velocityUUID = [CBUUID UUIDWithString:@"2A22"];
//        CBUUID *rotationUUID = [CBUUID UUIDWithString:@"2A23"];
        
        self.UUIDArr = @[writeServiceUUID,yawCharUUID,pitchCharUUID,rollCharUUID,velocityUUID,rotationUUID];
//        self.UUIDArr = @[gyroXCharUUID,gyroYCharUUID,gyroZCharUUID,yawCharUUID,pitchCharUUID,rollCharUUID,writeServiceUUID,
//                         gXUUID,gYUUID,gZUUID,velocityUUID,rotationUUID];
        

        //    gyroXChar：实际X轴角速度值
        //    gyroYChar：实际Y轴角速度值
        //    gyroZChar：实际Z轴角速度值
        //    yawChar：放大10倍的偏航角（放大以保留一位小数精度，以便char的结构传输，这样可以不用传输小数点）
        //    pitchChar：放大10倍的俯仰角
        //    rollChar：放大10倍的翻滚角
    }
    return self;
}


-(void)start
{
//    if (!self.centralManger) {
//        self.centralManger = [[CBCentralManager alloc] initWithDelegate:self
//                                                                  queue:nil];
//    }
//    NSData *data = [[NSData alloc] init];
//    NSString *str = @"0";
    if (_writeC) {
//        NSData *data = [@"1" dataUsingEncoding:NSASCIIStringEncoding];
        NSData *data = [@"1" dataUsingEncoding:NSUTF8StringEncoding];
        
        [self.peripheral writeValue:data forCharacteristic:_writeC type:CBCharacteristicWriteWithResponse];
    }
    
    
//    NSData *d2 = [[PBABluetoothDecode sharedManager] HexStringToNSData:@"0x02"];
//    [self.peripheral writeValue:d2 forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//    CBUUID *gyroServiceUUID = [CBUUID UUIDWithString:@"7C27A67C-8E46-4AE6-8BC0-8A0865E7293F"];
}
-(void)stop
{
//    NSData *d2 = [[PBABluetoothDecode sharedManager] HexStringToNSData:@"0"];
//    [self.peripheral writeValue:d2 forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    if (_writeC) {
        
//        NSData *data = [@"0" dataUsingEncoding:NSASCIIStringEncoding];
        NSData *data = [@"0" dataUsingEncoding:NSUTF8StringEncoding];
        
        [self.peripheral writeValue:data forCharacteristic:_writeC type:CBCharacteristicWriteWithResponse];
        
    }
    
    
//    [self.centralManger cancelPeripheralConnection:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn) {
        CBUUID *CBID=  [CBUUID UUIDWithString:@"7C27A67C-8E46-4AE6-8BC0-8A0865E7293F"];
        [self.centralManger scanForPeripheralsWithServices:@[CBID]
                                                   options:nil];
        
        //        [self.centralManger scanForPeripheralsWithServices:nil
        //                                                   options:nil];
        
        
        NSLog(@">>>BLE状态正常");
    }else{
        NSLog(@">>>设备不支持BLE或者未打开");
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSLog(@">>>>扫描周边设备，id:%@, rssi: %@",[peripheral.identifier UUIDString],RSSI);
    
    peripheral.delegate=self;
    self.peripheral=peripheral;
    [self.centralManger connectPeripheral:self.peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"和周边设备连接成功。");
    [peripheral discoverServices:nil];
    NSLog(@"扫描周边设备上的服务..");
}

- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"发现服务时发生错误: %@",error);
        return;
    }
    
    NSLog(@"发现服务 ..");
    
    for (CBService *service in peripheral.services) {
        
        
        
        [peripheral discoverCharacteristics:self.UUIDArr forService:service];
    }
}

-(void)discoverCharacteristics{
    //    [peripheral discoverCharacteristics:nil forService:service];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"发现服务 %@, 特性数: %d", service.UUID, [service.characteristics count]);
    NSLog(@"服务：%@",service.UUID);
//        for (CBCharacteristic *characteristic in service.characteristics)
//            {
//                   //发现特征
//                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:Write_UUID]]) {
//                                NSLog(@"监听：%@",characteristic);//监听特征
////                                [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                    }
//                     
//                }
    for (CBCharacteristic *c in service.characteristics) {
        [peripheral readValueForCharacteristic:c];
        [self.peripheral setNotifyValue:YES forCharacteristic:c];
        
        //        NSString *str = [[NSString alloc]initWithData:c.value encoding:NSUTF8StringEncoding];
        
        NSData *data = c.value;
        //        NSNumber *intValue = 0;
        NSInteger intValue=0;
        [data getBytes:&intValue length: sizeof(intValue)];
        
        //        guard let d = data else { return 0 }
        //        var intValue: Int16 = 0
        //        d.getBytes(&intValue, length: sizeof(Int16))
        //        return intValue
        NSLog(@"特性值： %@----%ld",c.UUID,intValue);
        
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:Write_UUID]])
        {
             NSLog(@"=====================================ok");
            _writeC = c;
        }
    
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.peripheral setNotifyValue:NO forCharacteristic:c];
//        });
    }
    
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSData *data = characteristic.value;
    // Parse data ...
    
    NSInteger intValue=0;
    [data getBytes:&intValue length: sizeof(intValue)];
    
    //        guard let d = data else { return 0 }
    //        var intValue: Int16 = 0
    //        d.getBytes(&intValue, length: sizeof(Int16))
    //        return intValue
//    NSLog(@"特性值update---：%ld",intValue);
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:rotation_UUID]]) {//当前坡度
//         NSLog(@"特性值update---：%ld",intValue);
    }
    
    
    
    _bluetoothBlock(characteristic);
    
}

// 向设备写数据
//[self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];

@end
