//
//  LDGMessageTransformTool.h
//  ZhiBo
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

typedef NS_ENUM(NSUInteger,MessageType){
    MessageTypeJoinRoom   = 0,
    MessageTypeLeaveRoom  = 1,
    MessageTypeText       = 2,
    MessageTypeGift       = 3,
    MessageTypeHeart      = 100
};

#define TIME_OUT 20
#define HEART_TIME 10
@protocol LDGMessageTransformToolDelegate<NSObject>


/**
  已经接收到进入到 房间消息了

 @param userI userI
 */
- (void)haveJoinRoom:(UserInfo *)userI;

/**
 已经接收到推出到 房间消息了

 @param userI userI
 */
- (void)haveLeaveRoom:(UserInfo *)userI;
/**
 已经接收到收到礼物的消息了

 @param giftM giftM
 */
- (void)haveAcceptGiftMessage:(GiftMessage *)giftM;

/**
 已经接受到文本消息了。大师兄

 @param textM 文本消息的model
 */
- (void)haveAcceptTextMessage:(TextMessage *)textM;
@end

@interface LDGMessageTransformTool : NSObject

@property (weak, nonatomic) id<LDGMessageTransformToolDelegate> toolDelegate;
/**
 进入房间的消息是  : 0
 离开房间的消息是  : 1
 发送文本消息是   : 2
 发送礼物消息是   : 3
 */
/**
 链接上服务器
 */
- (instancetype)initWithConnectServer;
/**
 进入房间
 */
- (void)joinRoom;
/**
 离开房间
 */
- (void)leaveRoom;
/**
 发送文本消息

 @param text text
 */
- (void)sendTextMessage:(NSString *)text;

/**
 发送礼物的消息

 @param imageUrl 图片的url
 @param giftName 图片的名字
 @param giftCount 礼物的数量
 */
- (void)sendGiftMessage:(NSString *)imageUrl giftName:(NSString *)giftName giftCount:(NSString *)giftCount;








@end
