//
//  DGHomeView.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGHomeView.h"
#import "DGAutoNormalFooter.h"
#import "DGRefreshNormalHeader.h"
#import "DGListHeaderView.h"
#import "DGHomeListTableViewCell.h"

@interface DGHomeView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DGHomeViewModel *homeViewModel;
@property (strong, nonatomic) DGListHeaderView *headerView;

@end
@implementation DGHomeView
static NSString * const cellID = @"ListCellID";

-(DGListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"DGListHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, self.frame.size.width, 75);
    }
    return _headerView;
}
-(void)DG_bindViewModel{
    
        // 刷新ui
        @weakify(self);
    if (self.homeViewModel) {
        [self.homeViewModel.refreashUI subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        // 加载更多或者上拉加载更多刷新
        [self.homeViewModel.refreshEndUI subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }];
        // 头部绑定
        [_headerView dg_setViewModel:self.homeViewModel.listHeaderViewModel];
        [_headerView DG_bindViewModel];
    }
}
- (void)DG_setUpSubViews{
    
    // 初始化tableivew
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"DGHomeListTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    // 添加方法
    [self upLoadMoreData];
    [self downRefreshData];

}
-(void)dg_setViewModel:(DGBaseViewModel *)viewModel{
    self.homeViewModel = (DGHomeViewModel *)viewModel;
    
}
-(void)DG_getData{
    [self.homeViewModel.getData sendNext:nil];

}
/**
 上拉加载更多
 */
- (void)upLoadMoreData{
    
        @weakify(self);
    DGAutoNormalFooter *footer = [DGAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.upLoadMore execute:nil];
    }];
    self.tableView.mj_footer = footer;
}
/**
 下拉刷新
 */
- (void)downRefreshData{
    
        @weakify(self);
    DGRefreshNormalHeader *header = [DGRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.downRefresh execute:nil];

    }];
    self.tableView.mj_header = header;
}
#pragma Mark - tableview的datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeViewModel.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DGHomeListTableViewCell *homeListCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    homeListCell.model = self.homeViewModel.dataArray[indexPath.row];
    return homeListCell;
}
#pragma mark - tableview的delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



@end
