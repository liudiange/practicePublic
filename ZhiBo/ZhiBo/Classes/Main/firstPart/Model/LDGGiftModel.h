//
//  LDGGiftModel.h
//  礼物的动画
//
//  Created by apple on 2018/5/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGGiftModel : NSObject

@property (copy, nonatomic) NSString *senderName;
@property (copy, nonatomic) NSString *senderIconUrl;
@property (copy, nonatomic) NSString *giftName;
@property (copy, nonatomic) NSString *giftUrl;


/**
 判断是否是同一个模型

 @param giftModel 传递的model
 @return yes 是
 */
- (BOOL)isEqualsModel:(LDGGiftModel *)giftModel;


@end
