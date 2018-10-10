//
//  DGListHeaderView.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGListHeaderView.h"
#import "DGListHeaderCollectionViewCell.h"

@interface DGListHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;

@end

@implementation DGListHeaderView
static NSString * const cellID = @"CELLID";
-(void)awakeFromNib{
    [super awakeFromNib];
    [self DG_setUpSubViews];
    
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}
-(void)DG_setUpSubViews{
    
    self.collectionView.backgroundColor = [UIColor redColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 120);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DGListHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DGListHeaderCollectionViewCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    headerCell.model = self.dataArray[indexPath.item];
    return headerCell;
}



@end
