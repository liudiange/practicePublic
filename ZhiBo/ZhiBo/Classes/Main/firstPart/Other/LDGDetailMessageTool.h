//
//  LDGDetailMessageTool.h
//  ZhiBo
//
//  Created by apple on 2018/6/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGDetailMessageTool : NSObject
/**
 处理文本消息

 @param textM 消息的message
 @return 我们想要的字符串
 */
+ (NSAttributedString *)handleTextMessage:(TextMessage *)textM;

/**
 处理礼物的消息

 @param giftM 礼物
 @return 对象本身
 */
+ (NSAttributedString *)handleGiftMessage:(GiftMessage *)giftM;

@end
