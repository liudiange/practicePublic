//
//  LDGCommonModel.h
//  类似于网易的新闻的框架
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LDGCommonModel : NSObject
/**
 titleView的背景颜色，默认为白色
 */
@property (strong, nonatomic) UIColor *titleViewColor;
/**
 title的字体颜色，默认是系统的颜色
 */
@property (strong, nonatomic) UIColor *titleTextColor;
/**
 title文字的字体
 */
@property (strong, nonatomic) UIFont *titleTextFont;
/**
 TITLEview的y坐标，默认为0
 */
@property (assign, nonatomic) CGFloat titleViewY;
/**
 是否不需要显示文字下面的指示器，默认是有的
 */
@property (assign, nonatomic) BOOL isNotNeedIndicatorView;
/**
 指示器的宽度，默认是根据字体的宽度一样，修改这个属性是固定宽度了 由用户指定了
 */
@property (assign, nonatomic) CGFloat indicatorWith;
/**
 这个属性的使用是 指示器的宽度和文字的宽度一样的时候 根据自己的需求 增加或者减少宽度
 */
@property (assign, nonatomic) CGFloat indicatorAddWidth;
/**
 指示器的高度
 */
@property (assign, nonatomic) CGFloat indicatorHeight;
/**
 指示器的颜色
 */
@property (strong, nonatomic) UIColor *indicatorColor;
/**
 存放模型数据的
 */
@property (strong, nonatomic) NSMutableArray *modelArray;
#pragma mark - 表情引用到的
/**
 collectionView的背景颜色
 */
@property (strong, nonatomic) UIColor *collectionViewBackColor;
/**
 pagecontroll 的常规颜色
 */
@property (strong, nonatomic) UIColor *pageControllCommonColor;
/**
 pagecontroll 的当前选中颜色
 */
@property (strong, nonatomic) UIColor *pageControllSelectColor;
/**
 指定的均分个数。需要大于或者等于标题的个数 ，才能实现均分
 */
@property (assign, nonatomic) NSInteger averageCount;


@end
