//
//  MGSCXMusicSwipableView.h
//  探探动画
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSCXMusicSwipCostantDefine.h"

typedef enum : NSUInteger {
    MGSCXMusicSwipableViewDirectionLeft = 0,
    MGSCXMusicSwipableViewDirectionRight = 1,
    MGSCXMusicSwipableViewDirectionTop = 2,
    MGSCXMusicSwipableViewDirectionBottom = 3
} MGSCXMusicSwipableViewDirection;


@interface MGSCXMusicSwipableViewCell : UIView
/** 重用标示  */
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, strong) UIView *contentView;
/** 最后一张  */
@property (nonatomic, assign) BOOL isLast;
/** 第一张  */
@property (nonatomic, assign) BOOL isFirst;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
// 添加屏幕截图(此方法可用于动画过程中的cell内容视觉效果不变)
- (void)addSnapshotView:(UIView*)snapshotView;
- (void)removeSnapshotView;

- (void)removeFromSuperviewWithDirection:(MGSCXMusicSwipableViewDirection)direction;
@end



@class MGSCXMusicSwipableView;
/**
 *  数据源方法
 */
@protocol MGSCXMusicSwipableViewDataSource<NSObject>
@required
/**
 * 总卡片数
 */
- (NSInteger)swipeableViewNumberOfRowsInSection:(MGSCXMusicSwipableView *)swipeableView;

/**
 * 每张卡片内容
 */
- (MGSCXMusicSwipableViewCell *)swipeableView:(MGSCXMusicSwipableView *)swipeableView cellForIndex:(NSInteger)index;

@optional
/**
 * 一次显示最大卡片式数
 */
- (NSInteger)swipeableViewMaxCardNumberWillShow:(MGSCXMusicSwipableView *)swipeableView;
@end

/**
 *  代理方法
 */
@protocol MGSCXMusicSwipableViewDelegate <NSObject>
@optional
/**
 * 顶部卡片尺寸 (更换为设置顶部卡片四边距确定卡片位置尺寸)
 */
//- (CGSize)swipeableViewSizeForTopCard:(LZSwipeableView *)swipeableView;
/**
 *  顶部卡片实现时调用
 */
- (void)swipeableView:(MGSCXMusicSwipableView *)swipeableView didTopCardShow:(MGSCXMusicSwipableViewCell *)topCell;
/**
 *  最后一个卡片被移除时调用
 */
- (void)swipeableViewDidLastCardRemoved:(MGSCXMusicSwipableView *)swipeableView;
/**
 *  当前移除/添加的是哪一个卡片
 */
- (void)swipeableView:(MGSCXMusicSwipableView *)swipeableView didCardRemovedOrAddtIndex:(NSInteger)index withDirection:(MGSCXMusicSwipableViewDirection)direction;
/**
 *  添加一个卡片
 */
- (void)swipeableView:(MGSCXMusicSwipableView *)swipeableView didCardAddAtIndex:(NSInteger)index withDirection:(MGSCXMusicSwipableViewDirection)direction;



/**
 *  当前点击了哪张卡片
 */
- (void)swipeableView:(MGSCXMusicSwipableView *)swipeableView didTapCellAtIndex:(NSInteger)index;

/**
 *  最后一张卡片显示时调用
 */
- (void)swipeableView:(MGSCXMusicSwipableView *)swipeableView didLastCardShow:(MGSCXMusicSwipableViewCell *)cell;

/**
 *  创建替身cell，配合cell的添加屏幕截图方法使用，可实现动画时内容尺寸不变视觉效果
 */
- (__kindof MGSCXMusicSwipableViewCell *)swipeableView:(MGSCXMusicSwipableView *)swipeableView substituteCellForIndex:(NSInteger)index;

// 卡片头部视图代理方法
- (CGFloat)heightForHeaderView:(MGSCXMusicSwipableView *)swipeableView;
- (UIView *)headerViewForSwipeableView:(MGSCXMusicSwipableView *)swipeableView;

// 卡片底部视图代理方法
- (CGFloat)heightForFooterView:(MGSCXMusicSwipableView *)swipeableView;
- (UIView *)footerViewForSwipeableView:(MGSCXMusicSwipableView *)swipeableView;

@end


@interface MGSCXMusicSwipableView : UIView
@property (nonatomic, weak) id <MGSCXMusicSwipableViewDataSource> datasource;
@property (nonatomic, weak) id <MGSCXMusicSwipableViewDelegate> delegate;
/** 头部视图  */
@property (nonatomic, strong,readonly) UIView *headerView;
/** 底部视图  */
@property (nonatomic, strong,readonly) UIView *footerView;
/** 顶部卡片位置 默认都是20 */
@property (nonatomic, assign) UIEdgeInsets topCardInset;
// 卡片之间的水平和垂直间距 默认10
@property (nonatomic, assign) CGFloat bottomCardInsetVerticalMargin;
@property (nonatomic, assign) CGFloat bottomCardInsetHorizontalMargin;
// 开始在哪个位置
@property (assign, nonatomic) NSInteger beginIndex;
// LZSwipeableView的背景颜色
@property (strong, nonatomic) UIColor *containViewColor;
/**
 *  若是注册过cell，请在注册cell之后调用reloadData（第一次加载数据时调用）
 */
- (void)reloadData;
/**
 *  刷新数据源(加载更多数据时调用)
 */
- (void)refreshDataSource;

/**
 *  注册cell
 */
- (void)registerNibName:(NSString *)nibName forCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

// 重刷内部子控件位置
- (void)setLayoutSubViews;

/**
 *  去缓存池取可重用的cell
 */
- (__kindof MGSCXMusicSwipableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;



/**
 *  移除最顶层的card
 */
- (void)removeTopCardViewFromSwipe:(MGSCXMusicSwipableViewDirection)direction;


@end

