//
//  ViewController.m
//  CoreBlueToothCenter
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
// 中心设备管理器
@property (strong, nonatomic) CBCentralManager *centerManager;
// 外部设备
@property (strong, nonatomic) CBPeripheral *peripheral;
// 外部设备的特征
@property (strong, nonatomic) CBCharacteristic *characteristics;
// centerTextField
@property (weak, nonatomic) IBOutlet UITextField *centerTextField;

@end

@implementation ViewController
static NSString *SERVER_ID = @"CDD1";
static NSString *CHARACTERISTICS_ID = @"CDD2";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
  
}
#pragma mark - 中心设备的代理

/**
 蓝牙的设备情况

 @param central 中心设备的管理者
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBManagerStatePoweredOn) {
        [self showAlertTitle:@"蓝牙已经打开了"];
        // 开始扫描外部的设备
        CBUUID *uuid = [CBUUID UUIDWithString:SERVER_ID];
        [central scanForPeripheralsWithServices:@[uuid] options:nil];
    }
}

/**
 发现外部的设备

 @param central 中心设备
 @param peripheral 外部的设备
 @param advertisementData 接受到的数据
 @param RSSI 外部设备接收到的信号强度，以分贝为单位
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    self.peripheral = peripheral;
    // 开始链接
    [central connectPeripheral:peripheral options:nil];
}

/**
 与外部设备连接成功了

 @param central 中心设备
 @param peripheral 外部设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [self showAlertTitle:@"与外部设备连接成功了"];
    // 连接成功了就要停止扫描
    [central stopScan];
    // 设置外设的代理
    self.peripheral = peripheral;
    self.peripheral.delegate = self;
    // 根据uuid 来查找相关的服务
    [self.peripheral discoverServices:@[[CBUUID UUIDWithString:SERVER_ID]]];
}

/**
 连接失败了

 @param central 中心设备
 @param peripheral 外部设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    NSLog(@"连接失败");
    [self showAlertTitle:[NSString stringWithFormat:@"错误信息是: --  %@",error.description]];
}

/**
 断开连接

 @param central 中心设备
 @param peripheral 外部设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    // 断开自动的重新连接
    [central connectPeripheral:peripheral options:nil];
}
/**
 发现服务

 @param peripheral 外部设备
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    
    // 拿到服务
    CBService *server = peripheral.services.lastObject;
    // 开始发现特征
    [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:CHARACTERISTICS_ID]] forService:server];
}

/**
 发现特征回调用

 @param peripheral 外部特征
 @param service fuwu
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error{
    // 开始便利
    
    // 在这个我的外设只有一个特征
    self.characteristics = service.characteristics.lastObject;
    // 读取该特征的数据
    [peripheral readValueForCharacteristic:self.characteristics];
    // 订阅通知 用来观察这个特征的变化
    [peripheral setNotifyValue:YES forCharacteristic:self.characteristics];
}

/**
 订阅状态的改变

 @param peripheral 外部的设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        [self showAlertTitle:[NSString stringWithFormat:@"订阅特征改变的错误信息 --- %@",error.description]];
    }else{
        if (characteristic.isNotifying) {
            [self showAlertTitle:@"订阅成功"];
        }else{
            [self showAlertTitle:@"取消订阅"];
        }
    }
}

/**
 外设可以写入数据或者中心设备开始读取外部设备的数据

 @param peripheral 外部设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    self.centerTextField.text = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
}

/**
 写入数据回掉

 @param peripheral 外部的
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (!error) {
        [self showAlertTitle:@"中心设备写入数据成功"];
    }
}
#pragma mark - 其他的方法的响应

/**
 主动获取外设的数据
 */
- (IBAction)getPeriphicalData {
    // 外设主动读取。这样可以主动获取一次
    [self.peripheral readValueForCharacteristic:self.characteristics];
}

/**
 开始发送数据
 */
- (IBAction)sendAction {
    
    NSData *data = [self.centerTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    // 开始写入数据
    [self.peripheral writeValue:data forCharacteristic:self.characteristics type:CBCharacteristicWriteWithResponse];
}



/**
 展示提示的方法
 
 @param alertTitle 提示的文字
 */
- (void)showAlertTitle:(NSString *)alertTitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
