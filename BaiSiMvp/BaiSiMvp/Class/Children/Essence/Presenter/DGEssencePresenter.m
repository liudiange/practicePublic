//
//  DGEssencePresenter.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssencePresenter.h"
#import "DGEssenceButton.h"

@interface DGEssencePresenter()

@property (weak, nonatomic) DGEssenceController* mainVc;
@property (strong, nonatomic) NSMutableArray *vcArray;
@property (strong, nonatomic) NSMutableArray *vcTitleArray;


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
    
    [self createTitleView];
    [self createBottomView];
}
/**
 创建标题的view
 */
- (void)createTitleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.mainVc.view.frame.size.width, 35)];
    if (self.vcTitleArray.count == self.vcArray.count) {
        for (NSInteger index = 0; index < self.vcTitleArray.count; index++) {
            DGEssenceButton* button = [DGEssenceButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:self.vcTitleArray[index] forState:UIControlStateNormal];
            [button setTitleColor:DG_BACKGROUND_COLOR forState:UIControlStateNormal];
            [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleView addSubview:button];
        }
    }
    titleView.backgroundColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
    [self.mainVc.view addSubview:titleView];
}
/**
 title 按钮点击

 @param button button
 */
- (void)titleButtonClick:(DGEssenceButton *)button{
    
}
/**
 创建底部的view
 */
- (void)createBottomView{
    
}
/**
 获取数据
 */
- (void)fetchData{
    
    
}

@end
