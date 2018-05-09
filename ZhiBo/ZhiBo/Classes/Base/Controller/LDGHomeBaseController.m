//
//  LDGHomeBaseController.m
//  ZhiBo
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeBaseController.h"
#import "LDGPullViewLayout.h"
#import "LDGItemCell.h"
#import "LDGHomeServer.h"
#import "LDGZhiBoViewController.h"


@interface LDGHomeBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDGPullViewLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LDGHomeBaseController
static NSString * const ID = @"cellID";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化及其他
    [self setUpCollection];
    [self loadServerData];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
/**
 初始化collectionview
 */
- (void)setUpCollection{
    
    LDGPullViewLayout *pullLayout = [[LDGPullViewLayout alloc] init];
    pullLayout.layoutInset = UIEdgeInsetsMake(99, 0, 49, 0);
    pullLayout.rowMargon = 10;
    pullLayout.columnMargon = 5;
    pullLayout.columnCounts = 2;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height) collectionViewLayout:pullLayout];
    pullLayout.layoutDelegate = self;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"LDGItemCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView reloadData];
}
/**
 加载网络数据
 */
-(void)loadServerData {

    LDGHomeServer *homeServer = [[LDGHomeServer alloc] initWithModel:self.model];
    @weakify(self);
    [homeServer startRequest:^(NSError * _Null_unspecified error) {
        @strongify(self);
        __weak typeof(homeServer)weakHomeServer = homeServer;
        if (!error) {
            LDGLog(@"加载成功");
            [self.dataArray removeAllObjects];
            self.dataArray = weakHomeServer.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }else{
            LDGLog(@"加载失败");
        }
    }];
}
#pragma mark - collection 的 delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDGAuthorModel *authorModel = self.dataArray[indexPath.item];
    LDGZhiBoViewController *zhiboVc = [[UIStoryboard storyboardWithName:@"FirstPart" bundle:nil] instantiateViewControllerWithIdentifier:@"LDGZhiBoViewController"];
    zhiboVc.authorModel = authorModel;
    [self.navigationController pushViewController:zhiboVc animated:YES];
  
}
#pragma mark - collection 的 datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDGItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    itemCell.authorModel = self.dataArray[indexPath.item];
    return itemCell;
}
#pragma mark - layout的delegate
/**
 通过体格宽度来计算宽高比
 
 @param indexPath indexPath
 @return 返回宽高比
 */
- (CGFloat)receicewidthAndHeightScale:(NSIndexPath*)indexPath{
    return indexPath.item % 2 == 0 ? 2.0 * 2.0/3.0 : 2.0 * 0.5;
}



@end
