//
//  LDGTitleView.m
//  类似于网易的新闻的框架
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGTitleView.h"


@interface LDGTitleView ()

@property (strong, nonatomic) UIScrollView *bottomScrollerView;
@property (strong, nonatomic) UIScrollView *titleScrollerView;

@end

@implementation LDGTitleView
-(NSArray *)titles {
    if (!_titles) {
        _titles = [[NSArray alloc] init];
    }
    return _titles;
}
-(NSArray *)bottomControllers {
    if (!_bottomControllers) {
        _bottomControllers = [[NSArray alloc] init];
    }
    return _bottomControllers;
}
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
- (instancetype)initWithTitleViewFrame:(CGRect)frame titleHeight:(CGFloat)titleViewHeight titles:(NSArray<NSString *>*)titles bottomControllers:(NSArray<UIViewController *>*)bottomControllers currentController:(UIViewController *)currentController commonModel:(LDGCommonModel *)commonModel{
    if (self = [super initWithFrame:frame]) {
        self.commonModel = commonModel;
        self.titles = titles;
        self.bottomControllers = bottomControllers;
        self.titleViewHeight = titleViewHeight;
        self.currentController = currentController;
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        // 初始化的相关的操作
        [self setUp];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
     // 初始化的相关的操作
    [self setUp];
}
/**
 初始化相关的操作
 */
- (void)setUp{
    
    NSAssert(!(self.bottomControllers.count != self.titles.count || self.titles.count == 0), @"数组不能为空或者标题的数组和控制器的数组不相等");
    // 便利所有的控制器
    for (UIViewController *controller in self.bottomControllers) {
        [self.currentController addChildViewController:controller];
    }
    // 创建bottomview
    [self creatBottomView];
    // 将第一个控制器添加到scrollerview
    [self addControllerInBottomView:[self.bottomControllers firstObject]];
    // 创建titleview
    [self creatTitleView];
}
/**
 创建bottomview
 */
- (void)creatBottomView{
    NSUInteger controllerCount = self.currentController.childViewControllers.count;
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollerView.pagingEnabled = YES;
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.bounces = NO;
    scrollerView.contentSize = CGSizeMake(self.frame.size.width * controllerCount, self.frame.size.height);
    [self addSubview:scrollerView];
    self.bottomScrollerView = scrollerView; 
}
/**
 创建titleview
 */
- (void)creatTitleView{
    
    // 创建titleview
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.commonModel.titleViewY, self.frame.size.width, self.titleViewHeight)];
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.bounces = NO;
    scrollerView.backgroundColor = [UIColor greenColor];
    [self addSubview:scrollerView];
    self.titleScrollerView = scrollerView;
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
        lable.backgroundColor = [UIColor whiteColor];
        lable.text = titleStr;
        self.commonModel.titleTextColor ? (lable.textColor = self.commonModel.titleTextColor) : (lable.textColor = [UIColor blackColor]);
        self.commonModel.titleTextFont ? (lable.font = self.commonModel.titleTextFont) : (lable.font = [UIFont systemFontOfSize:17.0]);
        lable.textAlignment = NSTextAlignmentCenter;
        [scrollerView addSubview:lable];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)];
        [lable addGestureRecognizer:tapGes];
    }
    UILabel *lastLable = [scrollerView.subviews lastObject];
    self.titleScrollerView.contentSize = CGSizeMake(CGRectGetMaxX(lastLable.frame), 0);
    
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
   return [str boundingRectWithSize:CGSizeMake(NSIntegerMax, height) options:NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
}

/**
 添加控制器到bottomscrollerview

 @param viewController 要添加的控制器
 */
- (void)addControllerInBottomView:(UIViewController *)viewController
{
    viewController.view.frame = self.bottomScrollerView.frame;
    [self.bottomScrollerView addSubview:viewController.view];
}
/**
 标题view 文字的点击事件

 @param tapGes 点击手势
 */
- (void)tapGesAction:(UITapGestureRecognizer *)tapGes{
    
}

@end
