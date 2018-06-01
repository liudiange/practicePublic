//
//  LDGGiftModel.m
//  礼物的动画
//
//  Created by apple on 2018/5/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGGiftModel.h"

@implementation LDGGiftModel
/**
 判断是否是同一个模型
 
 @param giftModel 传递的model
 @return yes 是
 */
- (BOOL)isEqualsModel:(LDGGiftModel *)giftModel{
    if ([self.senderName isEqualToString:giftModel.senderName] && [self.giftName isEqualToString:giftModel.giftName]) {
        return YES;
    }
    return NO;
}


@end
