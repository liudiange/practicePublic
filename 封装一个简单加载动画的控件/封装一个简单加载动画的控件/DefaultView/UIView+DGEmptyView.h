//
//  UIView+DGEmptyView.h
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSUInteger,DGEmptyViewType){
    
    DGEmptyViewTypeNoNetWork  = 0,
    DGEmptyViewTypeNoData  = 1,
    DGEmptyViewTypeCustom  = 2
};
typedef BOOL(^DGCheckBlock)(void);
typedef void(^DGHandleBlock)(DGEmptyViewType type);

@interface UIView (DGEmptyView)
/**
 返回的是否显示empyview以及处理事件
 
 @param emptyType 类型
 @param defaultY 距离顶部的距离 如果小于等于0那就是0
 @param checkBlock 是否允许显示emptyview
 @param handleBlock 具体的处理的事件
 */
- (void)DG_addEmptyViewWithType:(DGEmptyViewType)emptyType
                   withDefaultY:(CGFloat)defaultY
                     checkBlock:(DGCheckBlock)checkBlock
                    handleBlock:(DGHandleBlock)handleBlock;
/**
 是否需要添加emptyView

 @param isNeedAdd bool值
 */
- (void)DG_eddEmptyView:(BOOL)isNeedAdd;
/**
 添加的默认view，可能为空，供外部使用
 */
@property (strong, nonatomic) UIView *DGEmptyView;

@end
