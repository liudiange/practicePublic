//
//  LDGContentCollectionView.m
//  表情键盘控件封装
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGContentCollectionView.h"
#import "UIView+XMGVIew.h"



@interface LDGContentCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIScrollView *titleScrollerView;
@property (strong, nonatomic) UICollectionView *contentCollectionView;
@property (strong, nonatomic) UIView *indicatorView;
@property (strong, nonatomic) UIPageControl *pageControll;
@property (assign, nonatomic) NSInteger currentSection;

@end
@implementation LDGContentCollectionView
-(NSMutableArray *)titles {
    if (!_titles) {
        _titles = [[NSMutableArray alloc] init];
    }
    return _titles;
}
/**
 用这种方式创建一个view
 
 @param frame 边距
 @param titleH 标题的高度
 @param isShouldBottom 是否标题显示在底部
 @param titles 标题的数组
 @param collectionLayout 传递进来的layout
 @param commonModel 其他的相关设置属性
 @return 对象本身
 */
- (instancetype)initWithFrame:(CGRect)frame titleH:(CGFloat)titleH isShouldBottom:(BOOL)isShouldBottom titles:(NSArray <NSString *> *)titles layout:(LDGContentFlowLayout *)collectionLayout withCommonModel:(LDGCommonModel *)commonModel{
    if (self = [super initWithFrame:frame]) {
        self.titleViewHeight = titleH;
        self.titles = [titles mutableCopy];
        self.isShouldBottom = isShouldBottom;
        self.commonModel = commonModel;
        self.collectionLayout = collectionLayout;
        [self setUp];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       // [self setUp];
    }
    return self;
}
-(void)awakeFromNib {
    [super awakeFromNib];
}
/**
 初始化
 */
- (void)setUp{
    self.currentSection = -1;
    // 创建titleview
    [self creatTitleView];
    // 创建bottomview
    [self creatBottomView];
}
/**
 创建titleview
 */
- (void)creatTitleView{
    
    // 创建titleview
    CGFloat scrollerViewY = self.isShouldBottom == YES ? (self.frame.size.height - self.titleViewHeight) : (0);
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollerViewY, self.frame.size.width, self.titleViewHeight)];
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.bounces = NO;
    scrollerView.backgroundColor = self.commonModel.titleViewColor ? (self.commonModel.titleViewColor):([UIColor whiteColor]);
    [self addSubview:scrollerView];
    self.titleScrollerView = scrollerView;
    if (self.titles.count <= self.commonModel.averageCount) {
        // 创建lable
        for (NSInteger index = 0; index < self.titles.count; index++) {
            NSString *titleStr = self.titles[index];
            CGFloat width = 0;
            if (self.commonModel.titleTextFont) {
                width = [self calculatorWidth:titleStr font:self.commonModel.titleTextFont height:self.titleViewHeight];
            }else{
                width = [self calculatorWidth:titleStr font:[UIFont systemFontOfSize:17.0] height:self.titleViewHeight];
            }
            CGRect rect;
            CGFloat lableWidth = self.titleScrollerView.xmg_width/self.titles.count;
            rect.size = CGSizeMake(lableWidth, self.titleViewHeight);
            rect.origin = CGPointMake(index *lableWidth, 0);
            UILabel *lable = [[UILabel alloc] initWithFrame:rect];
            lable.text = titleStr;
            self.commonModel.titleTextColor ? (lable.textColor = self.commonModel.titleTextColor) : (lable.textColor = [UIColor blackColor]);
            self.commonModel.titleTextFont ? (lable.font = self.commonModel.titleTextFont) : (lable.font = [UIFont systemFontOfSize:17.0]);
            lable.textAlignment = NSTextAlignmentCenter;
            [scrollerView addSubview:lable];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)];
            lable.userInteractionEnabled = YES;
            [lable addGestureRecognizer:tapGes];
            lable.tag = index;
        }
    }else{
        // 创建lable
        for (NSInteger index = 0; index < self.titles.count; index++) {
            NSString *titleStr = self.titles[index];
            CGFloat width = 0;
            if (self.commonModel.titleTextFont) {
                width = [self calculatorWidth:titleStr font:self.commonModel.titleTextFont height:self.titleViewHeight];
            }else{
                width = [self calculatorWidth:titleStr font:[UIFont systemFontOfSize:17.0] height:self.titleViewHeight];
            }
            CGRect rect;
            rect.size = CGSizeMake(width + 50, self.titleViewHeight);
            if (index == 0) {
                rect.origin = CGPointMake(0, 0);
            }else {
                UILabel *previousLable = scrollerView.subviews[index - 1];
                rect.origin = CGPointMake(CGRectGetMaxX(previousLable.frame), 0);
            }
            UILabel *lable = [[UILabel alloc] initWithFrame:rect];
            lable.text = titleStr;
            self.commonModel.titleTextColor ? (lable.textColor = self.commonModel.titleTextColor) : (lable.textColor = [UIColor blackColor]);
            self.commonModel.titleTextFont ? (lable.font = self.commonModel.titleTextFont) : (lable.font = [UIFont systemFontOfSize:17.0]);
            lable.textAlignment = NSTextAlignmentCenter;
            [scrollerView addSubview:lable];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)];
            lable.userInteractionEnabled = YES;
            [lable addGestureRecognizer:tapGes];
            lable.tag = index;
        }
    }
    UILabel *lastLable = [scrollerView.subviews lastObject];
    self.titleScrollerView.contentSize = CGSizeMake(CGRectGetMaxX(lastLable.frame), 0);
    //  创建指示器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = self.commonModel.indicatorColor ? (self.commonModel.indicatorColor):([UIColor greenColor]);
    UILabel *firstLable = (UILabel *)[self.titleScrollerView.subviews firstObject];
    CGFloat shouldWidth = 0;
    if (self.commonModel.titleTextFont) {
        shouldWidth = [self calculatorWidth:firstLable.text font:self.commonModel.titleTextFont height:self.titleViewHeight];
    }else{
        shouldWidth = [self calculatorWidth:firstLable.text font:[UIFont systemFontOfSize:17.0] height:self.titleViewHeight];
    }
    indicatorView.xmg_width = self.commonModel.indicatorWith > 0 ? (self.commonModel.indicatorWith) : (shouldWidth + self.commonModel.indicatorAddWidth );
    indicatorView.xmg_height = self.commonModel.indicatorHeight > 0 ? (self.commonModel.indicatorHeight) : (3.0);
    indicatorView.xmg_top = self.titleScrollerView.xmg_height - indicatorView.xmg_height;
    indicatorView.xmg_centerX = firstLable.xmg_centerX;
    [self.titleScrollerView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    // 显示隐藏与否
    self.commonModel.isNotNeedIndicatorView ? (self.indicatorView.hidden = YES) : (self.indicatorView.hidden = NO);
}
/**
 计算字体的宽度
 
 @param str 计算的文字
 @param font 字体
 @param height 高度
 @return 返回的宽度
 */
- (CGFloat)calculatorWidth:(NSString *)str font:(UIFont *)font height:(CGFloat)height{
    NSDictionary *dic = @{
                          NSFontAttributeName : font
                          };
    return [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
}
/**
  标题view 文字的点击事件
  
  @param tapGes 点击手势
  */
- (void)tapGesAction:(UITapGestureRecognizer *)tapGes{
    
    NSInteger indexSection = tapGes.view.tag;
    NSInteger totalCount = 0;
    for (NSInteger index = 0; index < indexSection; index ++) {
        NSInteger count = ([self.contentCollectionView numberOfItemsInSection:index] - 1)/(self.collectionLayout.layoutColumns * self.collectionLayout.layoutCows) + 1;
        totalCount += count;
    }
    [self.contentCollectionView setContentOffset:CGPointMake(totalCount * self.contentCollectionView.frame.size.width, 0) animated:YES];
}
/**
 创建底部的试图
 */
- (void)creatBottomView {
    
    //  创建collectionview
    CGFloat collectionViewY = self.isShouldBottom == YES ? (0) : (self.titleViewHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, self.frame.size.width, self.frame.size.height - self.titleViewHeight - 20) collectionViewLayout:self.collectionLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = self.commonModel.collectionViewBackColor ? (self.commonModel.collectionViewBackColor) : ([UIColor whiteColor]);
    [self addSubview:collectionView];
    self.contentCollectionView = collectionView;
    //  创建pagecontrol
    CGFloat pageControlY = self.isShouldBottom == YES ? (self.frame.size.height - self.titleViewHeight - 20) : (self.frame.size.height - 20);
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageControlY, self.frame.size.width, 20)];
    pageControl.backgroundColor = collectionView.backgroundColor;
    pageControl.pageIndicatorTintColor = self.commonModel.pageControllCommonColor ? (self.commonModel.pageControllCommonColor) : ([UIColor whiteColor]);
    pageControl.currentPageIndicatorTintColor = self.commonModel.pageControllSelectColor ? (self.commonModel.pageControllSelectColor) : ([UIColor greenColor]);
    pageControl.currentPage = 0;
    pageControl.defersCurrentPageDisplay = YES;
    [self addSubview:pageControl];
    self.pageControll = pageControl;
    self.pageControll.numberOfPages = 0;

}
/**
 注册class
 
 @param cellClass cellClass
 @param identifier identifier
 */
- (void)ldgContentRegisterClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    [self.contentCollectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
/**
 xib注册
 
 @param nib nib
 @param identifier identifier
 */
- (void)ldgContentRegisterNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier{
    [self.contentCollectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}
/**
 刷新数据
 */
- (void)ldgContentReloadData{
    if (!self.contentCollectionView) {
        [self setUp];
    }
    [self.contentCollectionView reloadData];
    if (self.pageControll.numberOfPages == 0 && [self.contentViewDataSource respondsToSelector:@selector(numberOfSectionsInldgContentCollectionView:)] && [self.contentViewDataSource respondsToSelector:@selector(ldgContentCollectionView:numberOfItemsInSection:)]) {
        NSInteger numberCount = [self.contentViewDataSource ldgContentCollectionView:self.contentCollectionView numberOfItemsInSection:0];
        numberCount == 0 ? (self.pageControll.numberOfPages = 0):(self.pageControll.numberOfPages = (numberCount - 1)/(self.collectionLayout.layoutColumns * self.collectionLayout.layoutCows) + 1);
    }
}

/**
 传递必须的参数过后开始创建
 */
-(void)startSetUp{
    [self setUp];
}
#pragma mark - collection的datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ([self.contentViewDataSource respondsToSelector:@selector(numberOfSectionsInldgContentCollectionView:)]) {
       return [self.contentViewDataSource numberOfSectionsInldgContentCollectionView:collectionView];
    }
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.contentViewDataSource respondsToSelector:@selector(ldgContentCollectionView:numberOfItemsInSection:)]) {
        return [self.contentViewDataSource ldgContentCollectionView:collectionView numberOfItemsInSection:section];
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.contentViewDataSource respondsToSelector:@selector(ldgContentCollectionView:cellForItemAtIndexPath:)]) {
        return [self.contentViewDataSource ldgContentCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    return nil;
}
#pragma mark - collectionView 的 delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.contnetViewDelegate respondsToSelector:@selector(ldgContentCollectionView:didSelectItemAtIndexPath:)]) {
        [self.contnetViewDelegate ldgContentCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}
/**
 手指拖动结束
 
 @param scrollView scrollerview
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self changePageControlAndTitleIndicatorView];
    
}
/**
 设置偏移量结束的调用
 
 @param scrollView scrollerview
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self changePageControlAndTitleIndicatorView];
}

/**
 改变pagecpntrol 和 indicatorview
 */
-(void)changePageControlAndTitleIndicatorView{
    
    // 拿到滚动结束的时候 第一个item的点
    CGPoint wantPoint = CGPointMake(self.contentCollectionView.contentOffset.x + self.collectionLayout.sectionInset.left + 1, self.collectionLayout.sectionInset.top + 1.0);
    NSIndexPath *indexPath = [self.contentCollectionView indexPathForItemAtPoint:wantPoint];
    NSInteger wantItemCounts = [self.contentCollectionView numberOfItemsInSection:indexPath.section];
    // page 相关的计算
    if (self.currentSection != indexPath.section) {
        // 小算法
        self.pageControll.numberOfPages = (wantItemCounts - 1)/(self.collectionLayout.layoutCows * self.collectionLayout.layoutColumns) + 1;
        // 选中某一个条目滚动到屏幕的中间
        UILabel *lable = (UILabel *)self.titleScrollerView.subviews[indexPath.section];
        if (self.titles.count > self.commonModel.averageCount) {
            CGFloat shouldOffsetx = lable.frame.origin.x + lable.frame.size.width * 0.5 - self.titleScrollerView.frame.size.width * 0.5;
            if (shouldOffsetx <= 0) {
                shouldOffsetx = 0;
            }
            [self.titleScrollerView setContentOffset:CGPointMake(shouldOffsetx, 0) animated:YES];
        }
        // 指示器
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat shouldWidth = 0;
            if (self.commonModel.titleTextFont) {
                shouldWidth = [self calculatorWidth:lable.text font:self.commonModel.titleTextFont height:self.titleViewHeight];
            }else{
                shouldWidth = [self calculatorWidth:lable.text font:[UIFont systemFontOfSize:17.0] height:self.titleViewHeight];
            }
            self.indicatorView.xmg_width = self.commonModel.indicatorWith > 0 ? (self.commonModel.indicatorWith) : (shouldWidth + self.commonModel.indicatorAddWidth);
            self.indicatorView.xmg_centerX = lable.xmg_centerX;
        }];
    }
    self.currentSection = indexPath.section;
    self.pageControll.currentPage = indexPath.item/(self.collectionLayout.layoutCows * self.collectionLayout.layoutColumns);
}
@end
