//
//  DGHomeViewController.m
//  MVVM优化
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGHomeViewController.h"
#import "DGHomeListTableViewCell.h"
#import "DGHomeViewModel.h"
#import "DGRefreshNormalHeader.h"
#import "DGAutoNormalFooter.h"
#import "DGListHeaderView.h"

#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface DGHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DGHomeViewModel *homeViewModel;


@end
@implementation DGHomeViewController
static NSString * const cellID = @"ListCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUIAndDefaultView];
    [self configLoadMoreAndRefresh];
    [self bingViewModel];
    [self requesetServer];
}
#pragma AMRK - 常规方法的响应
/**
一些配置和添加默认试图等等
 */
- (void)configUIAndDefaultView{
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DGHomeListTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}
/**
 配置下拉刷新和上拉加载更多
 */
- (void)configLoadMoreAndRefresh{
    
        @weakify(self);
    DGAutoNormalFooter *footer = [DGAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.upLoadMore execute:nil];
    }];
    self.tableView.mj_footer = footer;
    DGRefreshNormalHeader *header = [DGRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.downRefresh execute:nil];
        
    }];
    self.tableView.mj_header = header;
}
/**
 绑定model的相关的处理
 */
-(void)bingViewModel{
    
    self.homeViewModel = [[DGHomeViewModel alloc] init];
        @weakify(self);
    [self.homeViewModel.refreashUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
    [self.homeViewModel.refreshEndUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}
/**
 请求网络
 */
- (void)requesetServer{
    [SVProgressHUD showWithStatus:@"哈哈哈正在加载中奥"];
    [self.homeViewModel.getData sendNext:nil];
}
#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.homeViewModel.serverDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DGHomeListTableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    homeCell.model = self.homeViewModel.serverDataArray[indexPath.row];
    return homeCell;
}
#pragma mark - delegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DGListHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"DGListHeaderView" owner:nil options:nil] lastObject];
    headerView.dataArray = self.homeViewModel.headerDataArray;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
