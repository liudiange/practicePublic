//
//  LDGInterActiveView.m
//  ZhiBo
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGInterActiveView.h"
#import "LDGInteractiveTextCell.h"


@interface LDGInterActiveView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
@implementation LDGInterActiveView
static NSString *text_id = @"textID";
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LDGInteractiveTextCell" bundle:nil] forCellReuseIdentifier:text_id];
    self.userInteractionEnabled = YES;
}

/**
 进行刷新表格
 
 @param str str
 */
- (void)interReloadData:(NSString *)str{
    [self.dataArray addObject:str];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        if (self.dataArray.count) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDGInteractiveTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:text_id];
    textCell.selectionStyle = UITableViewCellSelectionStyleNone;
    textCell.textStr = self.dataArray[indexPath.row];
    return textCell;
    
}
#pragma mark - tableview - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
