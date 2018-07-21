//
//  ViewController.m
//  collectionViewHeader
//
//  Created by 刘殿阁 on 2018/7/21.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import "DGCollectionViewCell.h"
#import "DGCollectionReusableView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

static NSString * const header_View = @"headerView";
static NSString * const DGCollection_Cell = @"DGcollectionViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.dataArray addObject:@"asdhashd"];
    [self.dataArray addObject:@"qweqwehqweh"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DGCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_View];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DGCollection_Cell];
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - layout  的 delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width, 100);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *resabaleView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DGCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_View forIndexPath:indexPath];
        headerView.titleArray = self.dataArray;
        return headerView;
    }
   
    return resabaleView;
}
#pragma mark - uicollectionview  的 datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DGCollection_Cell forIndexPath:indexPath];
    cell.nameLable.text = self.dataArray[indexPath.item];
    return cell;
}
@end
