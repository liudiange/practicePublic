//
//  LDGGiftEmoticonView.h
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGGiftEmoticonModel.h"

@interface LDGGiftEmoticonView : UIView
@property (strong, nonatomic) void (^sendGift)(LDGGiftEmoticonModel *model);


@end
