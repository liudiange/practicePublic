//
//  ViewController.m
//  表情键盘控件封装
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LDGContentCollectionView.h"
#import "LDGCollectionViewCell.h"

@interface ViewController ()<LDGContentCollectionViewDelegate,LDGContentCollectionViewDatasource>

@end

@implementation ViewController
static NSString *cell_ID = @"cell_id";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor grayColor];
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.averageCount = 4;
    NSArray *titleArray = @[@"土豪",@"热门",@"专属",@"常见"];
    LDGContentFlowLayout *flowLayout = [[LDGContentFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.layoutCows = 3;
    flowLayout.layoutColumns = 4;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    LDGContentCollectionView *contentCollectionView = [[LDGContentCollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400) titleH:40 isShouldBottom:YES titles:titleArray layout:flowLayout withCommonModel:commonModel];
    contentCollectionView.contnetViewDelegate = self;
    contentCollectionView.contentViewDataSource = self;
    [contentCollectionView ldgContentRegisterNib:[UINib nibWithNibName:@"LDGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cell_ID];
    [self.view addSubview:contentCollectionView];
    [contentCollectionView ldgContentReloadData];
}
#pragma mark - dataosource
- (NSInteger)ldgContentCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)numberOfSectionsInldgContentCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (__kindof UICollectionViewCell *)ldgContentCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LDGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed: 1.0 *arc4random_uniform(10)/10.0 green:1.0 *arc4random_uniform(10)/10.0 blue:1.0 *arc4random_uniform(10)/10.0 alpha:1.0];
    return cell;
}
#pragma mark - delegate
- (void)ldgContentCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd",indexPath.item);
}
@end
