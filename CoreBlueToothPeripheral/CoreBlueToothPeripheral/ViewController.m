//
//  ViewController.m
//  CoreBlueToothPeripheral
//
//  Created by apple on 2018/2/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController ()<CBPeripheralManagerDelegate>

/**
创建外设管理器
 */
@property (strong, nonatomic) CBPeripheralManager *periphalManager;
/**
 特征
 */
@property (strong, nonatomic) CBMutableCharacteristic *characteristics;
@property (weak, nonatomic) IBOutlet UITextField *textField;



@end

@implementation ViewController
static NSString *SERVER_ID = @"serverId";
static NSString *CHARACTERISTICS_ID = @"characteristicsId";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.periphalManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
}
#pragma mark - delegate 的回调

/**
 外设蓝牙状态的改变

 @param peripheral 外设管理器
 */
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        [self showAlertTitle:@"蓝牙关闭了"];
    }else if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        // 创建服务和特征
        [self creatServerAndChacteristics];
    }
}

/**
 当中心设备读取这个设备的时候调用这个方法

 @param peripheral 外设管理器
 @param request 请求
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    
    request.value = [self.textField.text dataUsingEncoding:NSUTF8StringEncoding];
    //开始回应请求
    [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
}

/**
 当中心设备开始写入数据的时候，外部设备开始调用这个方法

 @param peripheral 外部设备管理器
 @param requests 请求
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests{
    CBATTRequest *request = requests.lastObject;
    self.textField.text = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
}

/**
 中心设备订阅成功了

 @param peripheral 外部设备的管理器
 @param central 中心
 @param characteristic 特征
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    [self showAlertTitle:@"中心设备订阅成功了"];
}
/**
 中心设备订阅成功了
 
 @param peripheral 外部设备的管理器
 @param central 中心
 @param characteristic 特征
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
     [self showAlertTitle:@"中心设备取消订阅了"];
}
/**
 创建服务和特征
 */
- (void)creatServerAndChacteristics{
    
    // 创建服务
    CBUUID *serverId = [CBUUID UUIDWithString:SERVER_ID];
    CBMutableService *server = [[CBMutableService alloc] initWithType:serverId primary:YES];
    // 创建特征
    CBUUID *characteristicsId = [CBUUID UUIDWithString:CHARACTERISTICS_ID];
    CBMutableCharacteristic *characteristics = [[CBMutableCharacteristic alloc] initWithType:characteristicsId properties:CBCharacteristicPropertyRead |CBCharacteristicPropertyWrite |CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable|CBAttributePermissionsWriteable];
    // 将特征添加到服务上
    server.characteristics = @[characteristics];
    // 将服务添加到管理器上
    [self.periphalManager addService:server];
    // 保存特征值
    self.characteristics = characteristics;
}
#pragma mark - 其他的方法的响应
/**
 展示提示的方法

 @param alertTitle 提示的文字
 */
- (void)showAlertTitle:(NSString *)alertTitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertTitle preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];

}

/**
 主动给中心设备发送数据

 @param sender 按钮
 */
- (IBAction)sendAction:(UIButton *)sender {
    
   BOOL successBool = [self.periphalManager updateValue:[self.textField.text dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.characteristics onSubscribedCentrals:nil];
    if (successBool) {
        [self showAlertTitle:@"发送成功了"];
    }else {
        [self showAlertTitle:@"发送失败"];
    }
}






@end
