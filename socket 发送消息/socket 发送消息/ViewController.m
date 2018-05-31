//
//  ViewController.m
//  socket 发送消息
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *socket;

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    GCDAsyncSocket *socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.socket = socket;
    // 链接主机和端口号。也就是说开始链接上服务器
    [self.socket connectToHost:@"192.168.0.1" onPort:2355 error:nil];
    
}
#pragma mark - delegate
/**
 已经链接上服务器了

 @param sock socket
 @param host 主机地址
 @param port 端口号
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"开始链接上服务了");
    // 开始写入数据
    NSData *data = [NSData data];
    
    [sock writeData:data withTimeout:20 tag:0];
}
/**
 已经写入成功了

 @param sock socket
 @param tag 标示
 */
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    switch (tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    NSLog(@"某某消息已经发送成功了");
}
/**
 开始读取数据

 @param sock socket
 @param data 数据
 @param tag tag
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    switch (tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    NSLog(@"已经读取到数据了");
}





@end
