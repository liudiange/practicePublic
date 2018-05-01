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

@end

@implementation LDGHomeBaseController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
static NSString * const ID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化及其他
    [self setUpCollection];
}
/**
 初始化collectionview
 */
- (void)setUpCollection{
    LDGPullViewLayout *pullLayout = [[LDGPullViewLayout alloc] init];
    pullLayout.layoutInset = UIEdgeInsetsMake(10, 10, 10, 10);
    pullLayout.columnCounts = 3;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height) collectionViewLayout:pullLayout];
    pullLayout.layoutDelegate = self;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"LDGItemCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
-(void)setModel:(LDGHomeModel *)model {
    _model = model;
    LDGHomeServer *homeServer = [[LDGHomeServer alloc] initWithModel:model];
    @weakify(self);
    [homeServer startRequest:^(NSError * _Null_unspecified error) {
        @strongify(self);
        if (!error) {
            NSLog(@"加载成功");
            self.dataArray = homeServer.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }else{
            NSLog(@"加载失败");
        }
    }];
}
#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDGItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    itemCell.shopModel = self.dataArray[indexPath.item];
    return itemCell;
}
#pragma mark - layout的delegate
/**
 通过体格宽度来计算宽高比
 
 @param indexPath indexPath
 @return 返回宽高比
 */
- (CGFloat)receicewidthAndHeightScale:(NSIndexPath*)indexPath{
    LDGShopModel *shopModel = self.dataArray[indexPath.item];
    return shopModel.h * 1.0 /shopModel.w;
}



@end
