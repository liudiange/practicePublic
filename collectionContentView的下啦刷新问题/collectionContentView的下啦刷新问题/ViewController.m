//
//  ViewController.m
//  collectionContentView的下啦刷新问题
//
//  Created by apple on 2018/7/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MRMSongListCell.h"
#import "MRMHeaderCollectionCell.h"
#import "JHHeaderFlowLayout.h"
#import <MJRefresh/MJRefresh.h>


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation ViewController

static NSString * const reuseSongListCellIndentifier = @"ReuseSongListCellIndentifier";
static NSString * const headerCell_ID = @"headerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionViewConfigure];
    [self pulldownRefresh];
    [self.collectionView reloadData];

}
/**
 下拉刷新
 
 */
- (void)pulldownRefresh{
    
    __weak typeof(self)weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf refrshAction];
    }];
    self.collectionView.mj_header = header;
}
- (void)refrshAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
    
}
/**
 设置collectionview相关的东西
 */
- (void)setCollectionViewConfigure{
    
    JHHeaderFlowLayout *flowLayout = [[JHHeaderFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH -45)/2.0 , (SCREEN_WIDTH -45)/2.0 + 50);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 10;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.collectionView registerNib:[UINib nibWithNibName:@"MRMSongListCell" bundle:nil] forCellWithReuseIdentifier:reuseSongListCellIndentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MRMHeaderCollectionCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCell_ID];
    [self.collectionView setCollectionViewLayout:flowLayout];
}
#pragma mark - uicollectionFlowDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 200);
}
#pragma mark - uicollectionview 的 delegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MRMHeaderCollectionCell *headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCell_ID forIndexPath:indexPath];
        return headerCell;
    }
    return view;
}
#pragma mark - collectionview 的 datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MRMSongListCell *cell = (MRMSongListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseSongListCellIndentifier forIndexPath:indexPath];
    cell.nameStr = @"sadasd";
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

@end
