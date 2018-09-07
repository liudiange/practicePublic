//
//  UIView+DGEmptyView.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIView+DGEmptyView.h"
#import <objc/message.h>
#import "DGDefaultView.h"
#import <AFNetworking/AFNetworking.h>

@interface UIView ()

@property (assign, nonatomic) DGEmptyViewType emptyType;
@property (assign, nonatomic) CGFloat defaultY;
@property (strong, nonatomic) DGCheckBlock myCheckBlock;
@property (strong, nonatomic) DGHandleBlock myHandleBlock;
@property (assign, nonatomic) BOOL isHaveListenNetWork;
@property (assign, nonatomic) DGEmptyViewType currentType;

@end
@implementation UIView (DGEmptyView)
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
                    handleBlock:(DGHandleBlock)handleBlock{
    
    // 在这里添加网络监听的代码
    [self listenNetWorkStatus];
    // 进行赋值
    self.currentType = emptyType;
    self.emptyType = emptyType;
    self.defaultY = defaultY;
    self.myCheckBlock = checkBlock;
    self.myHandleBlock = handleBlock;
    // 判断当前网络 给当前类型进行赋值
    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        self.emptyType = DGEmptyViewTypeNoNetWork;
    }
}
/**
 是否需要添加emptyView
 
 @param isNeedAdd bool值
 */
- (void)DG_eddEmptyView:(BOOL)isNeedAdd{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       if (self.DGEmptyView) [self.DGEmptyView removeFromSuperview];
    });
    if (!isNeedAdd) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.emptyType == DGEmptyViewTypeNoNetWork) {
                [self creatDefaultView];
            }
        });
      return;
    }
    BOOL isThrough = NO;
    if (self.myCheckBlock) {
       isThrough = self.myCheckBlock();
    }
    if (isThrough) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self creatDefaultView];
    });
}
/**
 创建defaultview
 */
- (void)creatDefaultView{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        DGDefaultView *defaultView = [[[NSBundle mainBundle]loadNibNamed:@"DGDefaultView" owner:nil options:nil] lastObject];
        CGRect frame = self.frame;
        frame.origin.y = self.defaultY;
        frame.size.height = self.frame.size.height - self.defaultY;
        defaultView.frame = frame;
        
        switch (self.emptyType) {
            case DGEmptyViewTypeNoNetWork: // 没有网络
            {
                [defaultView DG_setEmptyViewType:DGEmptyViewTypeNoNetWork];
            }
                break;
            case DGEmptyViewTypeNoData: // 没有数据的类型
            {
                [defaultView DG_setEmptyViewType:DGEmptyViewTypeNoData];
                
            }
                break;
            case DGEmptyViewTypeCustom: // 自己定义的类型
            {
                [defaultView DG_setEmptyViewType:DGEmptyViewTypeCustom];
                
            }
                break;
            default:
                break;
        }
        [self addSubview:defaultView];
        [self bringSubviewToFront:defaultView];
        self.DGEmptyView = defaultView;
        [self handleClickAction];
    }];
}

#pragma mark 其他事件的响应
/**
 监听网络状态的变化
 */
- (void)listenNetWorkStatus{
    
    if (self.isHaveListenNetWork) return;
 
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知状态");
                self.emptyType = DGEmptyViewTypeNoNetWork;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"没有网络");
                self.emptyType = DGEmptyViewTypeNoNetWork;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"蜂窝数据");
                self.emptyType = self.currentType;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"开始切换到WiFi了");
                self.emptyType = self.currentType;
            }
                break;
                
            default:
            {
                 NSLog(@"也就是没有什么网络情况进入");
                self.emptyType = self.currentType;
            }
                break;
        }
    }];
    
    self.isHaveListenNetWork = YES;
}
/**
 处理点击重新加载数据
 */
- (void)handleClickAction{
    
    DGDefaultView *defaultView = (DGDefaultView *)self.DGEmptyView;
    defaultView.clickButtonBlock = ^{
        if (self.myHandleBlock) {
            self.myHandleBlock(self.emptyType);
        }
    };
}
#pragma mark - 相关的get 和 set方法
-(void)setCurrentType:(DGEmptyViewType)currentType{
    
    NSNumber *value = [NSNumber numberWithUnsignedInteger:currentType];
    objc_setAssociatedObject(self, @selector(currentType), value, OBJC_ASSOCIATION_ASSIGN);
}
-(DGEmptyViewType)currentType{
    
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return [value unsignedIntegerValue];
    
}
-(void)setIsHaveListenNetWork:(BOOL)isHaveListenNetWork{
    
    NSNumber *numberBool = [NSNumber numberWithBool:isHaveListenNetWork];
    objc_setAssociatedObject(self, @selector(isHaveListenNetWork), numberBool, OBJC_ASSOCIATION_ASSIGN);
    
}
-(BOOL)isHaveListenNetWork{
    
    NSNumber *numberBool = objc_getAssociatedObject(self, _cmd);
    return [numberBool boolValue];
    
}

-(void)setMyHandleBlock:(DGHandleBlock)myHandleBlock{
    
    objc_setAssociatedObject(self, @selector(myHandleBlock), myHandleBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(DGHandleBlock)myHandleBlock{
    return objc_getAssociatedObject(self, _cmd);
}
/**
 检查的block

 @param myCheckBlock 检查的block
 */
-(void)setMyCheckBlock:(DGCheckBlock)myCheckBlock{
    
    objc_setAssociatedObject(self, @selector(myCheckBlock), myCheckBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(DGCheckBlock)myCheckBlock{
    
    return objc_getAssociatedObject(self, _cmd);
}
/**
 设置距离顶部的距离

 @param defaultY 距离顶部的距离
 */
-(void)setDefaultY:(CGFloat)defaultY{
    
    NSNumber *value = [NSNumber numberWithFloat:defaultY];
    objc_setAssociatedObject(self, @selector(defaultY), value, OBJC_ASSOCIATION_ASSIGN);
}
-(CGFloat)defaultY{
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return [value floatValue];
}
/**
 设置类型

 @param emptyType 类型
 */
-(void)setEmptyType:(DGEmptyViewType)emptyType{
    NSNumber *value = [NSNumber numberWithUnsignedInteger:emptyType];
    objc_setAssociatedObject(self, @selector(emptyType), value, OBJC_ASSOCIATION_ASSIGN);
}
-(DGEmptyViewType)emptyType{
    
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return [value unsignedIntegerValue];
    
}
/**
 设置添加的view

 @param DGEmptyView view
 */
-(void)setDGEmptyView:(UIView *)DGEmptyView{
    
     objc_setAssociatedObject(self, @selector(DGEmptyView), DGEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(UIView *)DGEmptyView{
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
