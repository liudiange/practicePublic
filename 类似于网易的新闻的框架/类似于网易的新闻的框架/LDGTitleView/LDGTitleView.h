//
//  LDGTitleView.h
//  类似于网易的新闻的框架
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGCommonModel.h"

@interface LDGTitleView : UIView

// 这些属性的使用 是系统方式创建 或者xib方式创建
@property (strong, nonatomic) LDGCommonModel *commonModel;
@property (strong, nonatomic) NSArray <NSString *>*titles;
@property (strong, nonatomic) NSArray<UIViewController *>*bottomControllers;
@property (assign, nonatomic) CGFloat titleViewHeight;
@property (strong, nonatomic) UIViewController *currentController;
/**
 创建view。必须用这个方法创建
 
 @param frame 当前view的frame
 @param titleViewHeight titleview的高度
 @param titles 标题数组
 @param bottomControllers 所有控制器的数组
 @param currentController 当前的控制器
 @param commonModel 相关的属性的模型设置
 @return 对象本身
 */
- (instancetype)initWithTitleViewFrame:(CGRect)frame titleHeight:(CGFloat)titleViewHeight titles:(NSArray<NSString *>*)titles bottomControllers:(NSArray<UIViewController *>*)bottomControllers currentController:(UIViewController *)currentController commonModel:(LDGCommonModel *)commonModel;

@end
