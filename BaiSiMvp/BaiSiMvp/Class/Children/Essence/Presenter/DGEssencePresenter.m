//
//  DGEssencePresenter.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssencePresenter.h"
#import "DGEssenceButton.h"
#define DGEssenceButtonW (self.mainVc.view.frame.size.width * 1.0 / self.vcTitleArray.count)
@interface DGEssencePresenter()<UIScrollViewDelegate>

@property (weak, nonatomic) DGEssenceController* mainVc;
@property (strong, nonatomic) UIScrollView *bottomScrollerView;
@property (strong, nonatomic) NSMutableArray *vcArray;
@property (strong, nonatomic) NSMutableArray *vcTitleArray;
@property (strong, nonatomic) UIView *indicatorView;


@end
@implementation DGEssencePresenter
-(NSMutableArray *)vcArray {
    if (!_vcArray) {
        _vcArray = [[NSMutableArray alloc] init];
    }
    return _vcArray;
}
-(NSMutableArray *)vcTitleArray {
    if (!_vcTitleArray) {
        _vcTitleArray = [[NSMutableArray alloc] init];
    }
    return _vcTitleArray;
}

/**
 获取控制器
 
 @param controller vc
 */
- (void)attchView:(DGEssenceController *)controller{
    self.mainVc = controller;
}
/**
 添加子控制器
 
 @param controllerVcArray 自控制器的数组
 @param titlesArray 子控制的标题
 */
- (void)addChildVc:(NSArray<UIViewController *>*)controllerVcArray titles:(NSArray<NSString*>*)titlesArray{
    
    [self.vcArray addObjectsFromArray:controllerVcArray];
    [self.vcTitleArray addObjectsFromArray:titlesArray];
    
    [self createBottomView];
    [self createTitleView];
}
/**
 创建标题的view
 */
- (void)createTitleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.mainVc.view.frame.size.width, 35)];
    if ((self.vcTitleArray.count == self.vcArray.count) && (self.vcTitleArray.count > 0)) {
        
        // 创建button
        for (NSInteger index = 0; index < self.vcTitleArray.count; index++) {
            DGEssenceButton* button = [DGEssenceButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(index * DGEssenceButtonW, 0, DGEssenceButtonW, 32);
            [button setTitle:self.vcTitleArray[index] forState:UIControlStateNormal];
            [button setTitleColor:DG_BACKGROUND_COLOR forState:UIControlStateNormal];
            button.tag = index;
            [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleView addSubview:button];
        }
        titleView.backgroundColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.5];
        [self.mainVc.view addSubview:titleView];
        // 创建指示器
        DGEssenceButton *firstButton = (DGEssenceButton *)titleView.subviews.firstObject;
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.xmg_width = 30;
        indicatorView.xmg_height = 3;
        indicatorView.xmg_centerX = firstButton.xmg_centerX;
        indicatorView.xmg_centerY = 32;
        indicatorView.backgroundColor = [UIColor redColor];
        [titleView addSubview:indicatorView];
        self.indicatorView = indicatorView;
    }
    // 默认第一次选中一个控制器
    [self selectVc:0];
}

/**
 选中那个控制器

 @param index 当前偏移量的下标
 */
- (void)selectVc:(NSInteger )index{
    
    UIViewController *viewVc = self.mainVc.childViewControllers[index];
    viewVc.view.frame = CGRectMake(index * DGScreenWidth, 0, DGScreenWidth, DGScreenHeight);
    [self.bottomScrollerView addSubview:viewVc.view];

}
/**
 title 按钮点击

 @param button button
 */
- (void)titleButtonClick:(DGEssenceButton *)button{
    
    
    [self.bottomScrollerView setContentOffset:CGPointMake(button.tag * DGScreenWidth, 0) animated:YES];
    
    [self selectVc:button.tag];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xmg_centerX = button.xmg_centerX;
    }];
    
}
/**
 创建底部的view
 */
- (void)createBottomView{
    
    UIScrollView *bottomScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainVc.view.frame.size.width, self.mainVc.view.frame.size.height)];
    bottomScrollerView.backgroundColor = [UIColor whiteColor];
    
    bottomScrollerView.contentSize = CGSizeMake(self.vcArray.count * DGScreenWidth, 0);
    bottomScrollerView.pagingEnabled = YES;
    bottomScrollerView.delegate = self;
    [self.mainVc.view addSubview:bottomScrollerView];
    self.bottomScrollerView = bottomScrollerView;
    
}
/**
 获取数据
 */
- (void)fetchData{
    
    
}
#pragma Mark - scrollerView - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = (NSInteger)scrollView.contentOffset.x/DGScreenWidth;
    
    [self selectVc:index];
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xmg_centerX = DGEssenceButtonW * (index + 0.5);
    }];
}
@end
