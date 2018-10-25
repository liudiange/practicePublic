//
//  DGEssenceTopicTableViewController.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssenceTopicTableViewController.h"
#import "DGTopicModel.h"

@interface DGEssenceTopicTableViewController ()<UITableViewDataSource,UITableViewDelegate,DGEssenceTopicProtocol>

@property (strong, nonatomic) DGEssenceTopicPresenter *presenter;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
@implementation DGEssenceTopicTableViewController

#pragma Mark - 懒加载
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
#pragma mark - 系统的方法
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.presenter = [[DGEssenceTopicPresenter alloc] init];
    [self.presenter attchView:self];
    [self.presenter fetchData];
}

#pragma mark - Table view 的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - tableview的delegate的方法

#pragma mark - protocol的方法
/**
 从网络获取的数据

 @param modelArray 数据的数组
 */
-(void)fetch:(NSArray<DGTopicModel *> *)modelArray{
    
    [self.dataArray addObjectsFromArray:modelArray];
}
/**
 展示动画
 */
-(void)showLoadAnimation{
    
    [SVProgressHUD showWithStatus:@"正在加载。。。"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
/**
 隐藏动画
 */
-(void)hideLoadAnimation{
    
    [SVProgressHUD dismiss];
}

@end
