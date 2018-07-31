//
//  MRMCollectionViewModel.m
//  collectionContentView的下啦刷新问题
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MRMCollectionViewModel.h"
#import "MRMSongListCell.h"
#import "MRMHeaderCollectionCell.h"
#import "JHHeaderFlowLayout.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MRMCollectionViewModel()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@end
@implementation MRMCollectionViewModel

static NSString * const reuseSongListCellIndentifier = @"ReuseSongListCellIndentifier";
static NSString * const headerCell_ID = @"headerCellID";

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    if (self = [super init]) {
        self.collectionView = collectionView;
        [self setCollectionViewConfigure];
    }
    return self;
}
/**
 设置collectionview相关的东西
 */
- (void)setCollectionViewConfigure{
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
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
