//
//  DGAutoNormalFooter.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGAutoNormalFooter.h"

@implementation DGAutoNormalFooter

-(void)prepare{
    
    [super prepare];
    
    // 设置状态文字
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载完毕了奥" forState:MJRefreshStatePulling];
    [self setTitle:@"没有数据了不要再加载了" forState:MJRefreshStateNoMoreData];
    
}
@end
