//
//  DGHomeViewModel.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGHomeViewModel.h"
#import "DGBaseHttpManager.h"
#import "DGListModel.h"

@interface DGHomeViewModel()

@property (assign, nonatomic) NSInteger currentPage;

@end
@implementation DGHomeViewModel
-(NSMutableArray *)headerDataArray {
    if (!_headerDataArray) {
        _headerDataArray = [[NSMutableArray alloc] init];
    }
    return _headerDataArray;
}
-(void)DG_bindViewModel{
    
    self.currentPage = 0;
        @weakify(self);
    // 添加网络请求的相关的操作
    [self.getData subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        // 开始请求网络
        DGBaseHttpManager *manager = [[DGBaseHttpManager alloc] init];
        [manager POSTWithRequestUrl:@"http://www.baidu.com" param:nil complete:^(DGBaseHttpModel *baseModel) {
            if (!baseModel.serverError) {
                for (int i = 0; i < 8; i++) {
                    DGListModel *model = [[DGListModel alloc] init];
                    model.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
                    model.name = @"财税培训圈子";
                    model.articleNum = @"1568";
                    model.peopleNum = @"568";
                    model.topicNum = @"5749";
                    model.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
                    [self.serverDataArray addObject:model];
                    [self.headerDataArray addObject:model];
                }
                [self.refreashUI sendNext:nil];
                
            }else{
                [self.refreashUI sendNext:nil];
                
            }
        }];
    }];
    //上拉加载更多
    [[self.upLoadMore.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
         @strongify(self);
        // 这里直接组装数据 ，进行往数组里面添加就行了
        DGBaseHttpModel *httpModel = (DGBaseHttpModel *)x;
        if(!httpModel.serverError){
            for (int i = 0; i < 8; i++) {
                DGListModel *model = [[DGListModel alloc] init];
                model.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
                model.name = @"财税培训圈子";
                model.articleNum = @"1568";
                model.peopleNum = @"568";
                model.topicNum = @"5749";
                model.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
                [self.serverDataArray addObject:model];
            }
            [self.refreshEndUI sendNext:nil];
        }else{
            [self.refreshEndUI sendNext:nil];
        }
    }];
    // 下拉刷新
    [[self.downRefresh.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
         @strongify(self);
        [self.serverDataArray removeAllObjects];
        [self.headerDataArray removeAllObjects];
        // 这里直接组装数据 ，进行往数组里面添加就行了
        DGBaseHttpModel *baseModel = (DGBaseHttpModel *)x;
        if (!baseModel.serverError) {
            for (int i = 0; i < 8; i++) {
                DGListModel *model = [[DGListModel alloc] init];
                model.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
                model.name = @"财税培训圈子";
                model.articleNum = @"1568";
                model.peopleNum = @"568";
                model.topicNum = @"5749";
                model.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
                [self.serverDataArray addObject:model];
                [self.headerDataArray addObject:model];
            }
            [self.refreshEndUI sendNext:nil];
            
        }else{
            [self.refreshEndUI sendNext:nil];
            
        }
        
    }];
    
    
}
#pragma mark - lazy
-(RACSubject *)refreshEndUI {
    if (!_refreshEndUI) {
        _refreshEndUI = [RACSubject subject];
    }
    return _refreshEndUI;
}
-(RACSubject *)refreashUI {
    if (!_refreashUI) {
        _refreashUI = [RACSubject subject];
    }
    return _refreashUI;
}
-(RACSubject *)getData {
    if (!_getData) {
        _getData = [RACSubject subject];
    }
    return _getData;
}
-(RACCommand *)upLoadMore {
    if (!_upLoadMore) {
            @weakify(self);
        _upLoadMore = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            // 进行网络请求在这里,上拉加载更多
            self.currentPage ++;
            // 开始请求网络
            DGBaseHttpManager *manager = [[DGBaseHttpManager alloc] init];
            [manager POSTWithRequestUrl:@"http://www.baidu.com" param:nil complete:^(DGBaseHttpModel *baseModel) {
                
                [subscriber sendNext:baseModel];
                [subscriber sendCompleted];
            }];
                return nil;
            }];
        }];
    }
    return _upLoadMore;
}
-(RACCommand *)downRefresh {
    if (!_downRefresh) {
            @weakify(self);
        _downRefresh = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                // 进行网络请求在这里,下拉刷新
                self.currentPage = 1;
                // 开始请求网络
                DGBaseHttpManager *manager = [[DGBaseHttpManager alloc] init];
                [manager POSTWithRequestUrl:@"http://www.baidu.com" param:nil complete:^(DGBaseHttpModel *baseModel) {
                    
                    [subscriber sendNext:baseModel];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _downRefresh;
}
@end
