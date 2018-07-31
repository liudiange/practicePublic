//
//  MRMHttpViewModel.m
//  collectionContentView的下啦刷新问题
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MRMHttpViewModel.h"
#import <MJRefresh/MJRefresh.h>


@interface MRMHttpViewModel()

@property (strong, nonatomic) UICollectionView *collectionView;
@end
@implementation MRMHttpViewModel

-(instancetype)initCollectionView:(UICollectionView *)collectionView{
    if (self = [super init]) {
        self.collectionView = collectionView;
        [self pulldownRefresh];
    }
    return self;
    
}
/**
 下拉刷新
 
 */
- (void)pulldownRefresh{
    
    __weak typeof(self)weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf refrshAction];
    }];
    self.collectionView.mj_header = header;
}
- (void)refrshAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
    
}
@end
