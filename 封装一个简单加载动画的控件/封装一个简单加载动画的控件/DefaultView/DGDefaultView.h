//
//  DGDefaultView.h
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DGEmptyView.h"


@interface DGDefaultView : UIView

@property (strong, nonatomic) void (^clickButtonBlock)(void);
/**
 设置属性

 @param type 设置相关的type
 */
- (void)DG_setEmptyViewType:(DGEmptyViewType)type;




@end
