//
//  LDGEmoticonView.h
//  ZhiBo
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGEmoticonModel.h"
@interface LDGEmoticonView : UIView

@property (copy, nonatomic) void (^CollectionSelected)(LDGEmoticonModel *emoticonModel);

@end
