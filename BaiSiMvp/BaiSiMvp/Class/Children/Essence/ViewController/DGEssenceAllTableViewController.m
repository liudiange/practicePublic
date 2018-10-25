//
//  DGEssenceAllTableViewController.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssenceAllTableViewController.h"

@interface DGEssenceAllTableViewController ()

@end

@implementation DGEssenceAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DG_RANDM_COLOR;
}
#pragma mark - protol action
- (DGTopicType)fetchTopicType{
    return DGTopicTypeAll;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
@end
