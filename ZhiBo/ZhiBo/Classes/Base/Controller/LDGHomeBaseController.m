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


@interface LDGHomeBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDGPullViewLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (assign, nonatomic) LDGHomeModel *model;

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
/**
 这种方式创建控制器
 
 @param model model
 @return 返回对象本身
 */
-(instancetype)initWithModel:(LDGHomeModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
/**
 初始化collectionview
 */
- (void)setUpCollection{
    
    LDGPullViewLayout *pullLayout = [[LDGPullViewLayout alloc] init];
    pullLayout.layoutInset = UIEdgeInsetsMake(35, 0, 0, 0);
    pullLayout.columnCounts = 2;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height) collectionViewLayout:pullLayout];
    pullLayout.layoutDelegate = self;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"LDGItemCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
/**
 加载网络数据
 */
-(void)loadServerData {
    
    LDGHomeModel *homeModel = [[LDGHomeModel alloc] init];
    homeModel.title = @"全部";
    homeModel.type = @(0);
    
    LDGHomeServer *homeServer = [[LDGHomeServer alloc] initWithModel:homeModel];
    @weakify(self);
    [homeServer startRequest:^(NSError * _Null_unspecified error) {
        @strongify(self);
        if (!error) {
            LDGLog(@"加载成功");
            [self.dataArray removeAllObjects];
            self.dataArray = homeServer.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }else{
            LDGLog(@"加载失败");
        }
    }];
}
#pragma mark - datasource
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
    return indexPath.item % 2 == 0 ? 1.0:1.25;
}



@end
