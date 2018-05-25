//
//  LDGMessageTransformTool.m
//  ZhiBo
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGMessageTransformTool.h"

@interface LDGMessageTransformTool ()<GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (strong, nonatomic) UserInfo *userInfo;
@property (strong, nonatomic) NSTimer *heartTimer;
@property (strong, nonatomic) NSMutableData *cacheParseData;


@end

@implementation LDGMessageTransformTool
-(NSMutableData *)cacheParseData {
    if (!_cacheParseData) {
        _cacheParseData = [[NSMutableData alloc] init];
    }
    return _cacheParseData;
}

/**
 链接上服务器，创建
 */
- (instancetype)initWithConnectServer{
    if (self = [super init]) {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.name = @"liudiange";
        userInfo.level = 1;
        self.userInfo = userInfo;
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        [self.socket connectToHost:@"192.168.100.193" onPort:7878 error:nil];
    }
    return self;
}

#pragma mark - 发送消息的方法
/**
 进入房间的消息是 : 0
 离开房间的消息是 : 1
 发送文本消息是 : 2
 发送礼物消息是 : 3
 */
/**
 进入房间
 */
- (void)joinRoom{
    
    NSMutableData *needSendData = [self calculatorData:MessageTypeJoinRoom bodyData:self.userInfo.data maxM:2];
    // 没有超时时间 -1 代表没有超时时间
    [self.socket writeData:needSendData withTimeout:TIME_OUT tag:MessageTypeJoinRoom];
}
/**
 离开房间
 */
- (void)leaveRoom {
    
    NSMutableData *needSendData = [self calculatorData:MessageTypeLeaveRoom bodyData:self.userInfo.data maxM:2];
    
    // 没有超时时间 -1 代表没有超时时间
    [self.socket writeData:needSendData withTimeout:TIME_OUT tag:MessageTypeLeaveRoom];
    
}
/**
 发送文本消息
 
 @param text text
 */
- (void)sendTextMessage:(NSString *)text{
    
    TextMessage *textM = [[TextMessage alloc] init];
    textM.user = self.userInfo;
    textM.text = text;
    NSMutableData *needSendData = [self calculatorData:MessageTypeText bodyData:textM.data maxM:2];
    [self.socket writeData:needSendData withTimeout:TIME_OUT tag:MessageTypeText];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self parseData:needSendData socket:self.socket];
    });
}

/**
 发送礼物的消息
 
 @param imageUrl 图片的url
 @param giftName 图片的名字
 @param giftCount 礼物的数量
 */
- (void)sendGiftMessage:(NSString *)imageUrl giftName:(NSString *)giftName giftCount:(NSString *)giftCount{
    
    GiftMessage *giftM = [[GiftMessage alloc] init];
    giftM.user = self.userInfo;
    giftM.giftname = giftName;
    giftM.giftURL = imageUrl;
    giftM.giftCount = giftCount;
    NSMutableData *needSendData = [self calculatorData:MessageTypeGift bodyData:giftM.data maxM:2];
    [self.socket writeData:needSendData withTimeout:TIME_OUT tag:MessageTypeGift];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self parseData:needSendData socket:self.socket];
    });

}

/**
 这个方法是封包    组装数据的格式是。type + length + bodyData
 
 @param type 类型
 @param bodyData 要发送的数据
 @param maxM 最大的发送数据M数量
 @return 整理好的data
 */
- (NSMutableData *)calculatorData:(MessageType)type bodyData:(NSData *)bodyData maxM:(int)maxM{
    // 需要返回的data
    NSMutableData *needSendData = [[NSMutableData alloc] init];
    // 类型的data 固定4个字节
    int typeInt = (int)type;
    NSMutableData *typeData = [NSMutableData dataWithBytes:&typeInt length:2];
    // 发送数据的长度data 也是固定4个字节
    int lenth = (int)bodyData.length;
    NSMutableData *legthData = [NSMutableData dataWithBytes:&lenth length:4];
    // 进行拼接,注意顺序不能错
    [needSendData appendData:typeData];
    [needSendData appendData:legthData];
    [needSendData appendData:bodyData];
    return needSendData;
}
/**
 心跳包的事件  为了保持客户端和服务端长期的链接
 */
-(void)heartAction{
    
//    NSMutableData *needSendData = [self calculatorData:MessageTypeHeart bodyData:nil maxM:2];
//    [self.socket writeData:needSendData withTimeout:TIME_OUT tag:MessageTypeHeart];
}
#pragma mark - 接受到消息的方法
/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    [sock readDataWithTimeout:TIME_OUT tag:tag];
}
/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
 **/
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    LDGLog(@"说明已经链接成功了");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!self.heartTimer) {
            self.heartTimer = [NSTimer timerWithTimeInterval:HEART_TIME target:self selector:@selector(heartAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] run];
            [[NSRunLoop currentRunLoop] addTimer:self.heartTimer forMode:NSDefaultRunLoopMode];
        }
    });
    [sock readDataWithTimeout:TIME_OUT tag:0];
}
/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [self parseData:data socket:sock];
}
/**
 拆除包  防止沾包

 @param data data
 @param sock sock
 */
- (void)parseData:(NSData *)data socket:(GCDAsyncSocket *)sock{
    // 首先付给要处理的data
    [self.cacheParseData appendData:data];
    // 找到我们当初存储的长度
    NSData *lengthData = [self.cacheParseData subdataWithRange:NSMakeRange(2, 4)];
    int shouldLength = 0;
    [lengthData getBytes:&shouldLength length:4];
    shouldLength += 6;
    while (self.cacheParseData.length > 6) {
        if (shouldLength > self.cacheParseData.length) { // 说明这个包是不完整的
            [sock readDataWithTimeout:TIME_OUT tag:0];
            break;
        }else{  // 说明这个包至少是大于等于一个完整包的长度
            NSData *needParseData = [self.cacheParseData subdataWithRange:NSMakeRange(0, shouldLength)];
            // 在这里开始正式解决这个包
            [self parseData:needParseData dataLength:shouldLength - 6];
            [self.cacheParseData replaceBytesInRange:NSMakeRange(0, shouldLength) withBytes:nil length:0];
            [sock readDataWithTimeout:TIME_OUT tag:0];
        }
    }
}

/**
 进入到这个方法说明是一个完整的包，并且是能够解析的

 @param data data
 @param shouldHaveLength 消息的长度
 */
- (void)parseData:(NSData *)data dataLength:(int)shouldHaveLength{
    
    // 类型
    NSData *typeData = [data subdataWithRange:NSMakeRange(0, 2)];
    int type = 0;
    [typeData getBytes:&type length:2];
    // 消息体
    NSData *bodyData = [data subdataWithRange:NSMakeRange(6, shouldHaveLength)];
    switch (type) {
        case MessageTypeHeart:
        {
            LDGLog(@"心跳包的消息");
        }
            break;
        case MessageTypeJoinRoom:
        {
            UserInfo *userI = [UserInfo parseFromData:bodyData error:nil];
            if ([self.toolDelegate respondsToSelector:@selector(haveJoinRoom:)]) {
                [self.toolDelegate haveJoinRoom:userI];
            }
        }
            break;
        case MessageTypeLeaveRoom:
        {
            UserInfo *userI = [UserInfo parseFromData:bodyData error:nil];
            if ([self.toolDelegate respondsToSelector:@selector(haveLeaveRoom:)]) {
                [self.toolDelegate haveLeaveRoom:userI];
            }
        }
            break;
        case MessageTypeText:
        {
            TextMessage *textM = [TextMessage parseFromData:bodyData error:nil];
            if ([self.toolDelegate respondsToSelector:@selector(haveAcceptTextMessage:)]) {
                [self.toolDelegate haveAcceptTextMessage:textM];
            }
        }
            break;
        case MessageTypeGift:
        {
            GiftMessage *giftM = [GiftMessage parseFromData:bodyData error:nil];
            if ([self.toolDelegate respondsToSelector:@selector(haveAcceptGiftMessage:)]) {
                [self.toolDelegate haveAcceptGiftMessage:giftM];
            }
        }
            break;
        default:
        {
            LDGLog(@"不知道是啥子消息");
        }
            break;
    }
}


@end
