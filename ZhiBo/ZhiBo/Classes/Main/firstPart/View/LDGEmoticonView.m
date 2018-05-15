//
//  LDGEmoticonView.m
//  ZhiBo
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGEmoticonView.h"
#import "LDGContentCollectionView.h"
#import "LDGContentFlowLayout.h"
#import "LDGEmoticonCell.h"
#import <MJExtension/MJExtension.h>
#import "LDGEmoticonModel.h"
#import "LDGCommonModel.h"

@interface LDGEmoticonView ()<LDGContentCollectionViewDelegate,LDGContentCollectionViewDatasource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
@implementation LDGEmoticonView
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
static NSString *emoticon_ID = @"emoticonID";
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self obtainData];
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self obtainData];
    [self setUp];
}
/**
 从plist文件中拿到数据
 */
- (void)obtainData{
    
    NSString *normalPath = [[NSBundle mainBundle] pathForResource:@"QHNormalEmotionSort" ofType:@"plist"];
    NSString *gifSortPath = [[NSBundle mainBundle] pathForResource:@"QHSohuGifSort" ofType:@"plist"];
    NSArray *normalArray = [NSArray arrayWithContentsOfFile:normalPath];
    NSArray *gifSortArray = [NSArray arrayWithContentsOfFile:gifSortPath];
    NSMutableArray *temNormalArray = [NSMutableArray array];
    NSMutableArray *temGifSortArray = [NSMutableArray array];
    for (NSString *str in normalArray) {
        LDGEmoticonModel *model = [[LDGEmoticonModel alloc] init];
        model.emoticonImageName = str;
        [temNormalArray addObject:model];
    }
    for (NSString *str in gifSortArray) {
        LDGEmoticonModel *model = [[LDGEmoticonModel alloc] init];
        model.emoticonImageName = str;
        [temGifSortArray addObject:model];
    }
    [self.dataArray addObject:temNormalArray];
    [self.dataArray addObject:temGifSortArray];
}
/**
 初始化
 */
- (void)setUp{
    
    NSArray *titlesArray = @[@"普通",@"粉丝专属"];
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.averageCount = 2;
    commonModel.pageControllCommonColor = [UIColor grayColor];
    LDGContentFlowLayout *contentLayout = [[LDGContentFlowLayout alloc] init];
    contentLayout.minimumLineSpacing = 10;
    contentLayout.minimumInteritemSpacing = 10;
    contentLayout.layoutCows = 3;
    contentLayout.layoutColumns = 7;
    LDGContentCollectionView *contentCollection = [[LDGContentCollectionView alloc] initWithFrame:self.bounds titleH:44 isShouldBottom:YES titles:titlesArray layout:contentLayout withCommonModel:commonModel];
    contentCollection.contnetViewDelegate = self;
    contentCollection.contentViewDataSource = self;
    [contentCollection ldgContentRegisterNib:[UINib nibWithNibName:@"LDGEmoticonCell" bundle:nil] forCellWithReuseIdentifier:emoticon_ID];
    [self addSubview:contentCollection];
    [contentCollection ldgContentReloadData];
}
#pragma mark - collectionView - datasource
- (NSInteger)numberOfSectionsInldgContentCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}
- (NSInteger)ldgContentCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (__kindof UICollectionViewCell *)ldgContentCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LDGEmoticonCell *emoticonCell = [collectionView dequeueReusableCellWithReuseIdentifier:emoticon_ID forIndexPath:indexPath];
    NSArray *array = self.dataArray[indexPath.section];
    LDGEmoticonModel *model = array[indexPath.item];
    emoticonCell.emoticomModel = model;
    return emoticonCell;
}
#pragma mark collectionView - delegate
- (void)ldgContentCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.dataArray[indexPath.section];
    LDGEmoticonModel *model = array[indexPath.item];
    if (self.CollectionSelected) {
        self.CollectionSelected(model);
    }
    
}
@end
