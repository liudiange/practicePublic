//
//  DGRefreshNormalHeader.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGRefreshNormalHeader.h"

@implementation DGRefreshNormalHeader

- (void)prepare{
    [super prepare];

    // 设置状态文字
    [self setTitle:@"拖拽下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载完毕了奥" forState:MJRefreshStatePulling];
    
    
}



@end
