//
//  ViewController.m
//  同时来多个数据的时候处理tableview
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DGShareInfo.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation ViewController
static NSString * const cellID = @"cell_id";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化相关
    [self configData];
    [self configTableView];
    [self addNotification];

}
- (void)addNotification{
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeArray) name:@"arrayChange" object:nil];
}
- (void)changeArray{
    
    [self.tableView reloadData];
}
- (void)configData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (NSInteger index = 0; index < 30; index++) {
            [[DGShareInfo shareInfo].dataArray addObject:@"test"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.tableView reloadData];
        });
    });
}
/**
 配置tableview
 */
- (void)configTableView{
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.tableView reloadData];
    
}
#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    NSInteger countNumber = [DGShareInfo shareInfo].dataArray.count;

    NSLog(@"countNumber ==== %zd",countNumber);
    return countNumber;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.contentView.backgroundColor = [UIColor greenColor];
//    [[DGShareInfo shareInfo].dataLock lock];
    cell.textLabel.text = [DGShareInfo shareInfo].dataArray[indexPath.row];
//    [[DGShareInfo shareInfo].dataLock unlock];
    
    return cell;
    
}

@end
