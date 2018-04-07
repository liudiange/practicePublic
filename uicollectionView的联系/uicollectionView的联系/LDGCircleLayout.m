//
//  LDGCircleLayout.m
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "LDGCircleLayout.h"

@implementation LDGCircleLayout

/**
 这个方法是用来判断每次属性变化的时候都会返回
 
 @param newBounds 新的位置变化
 @return 是否都会会回调用
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
/**
 返回的是每一个属性
 
 @param indexPath indexPath
 @return 属性
 */
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    // 计算角度
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center = CGPointMake(150 - 100*cos(indexPath.item*(M_PI*2/count)),100 - 100*sin(indexPath.item*(M_PI*2/count)));
    attrs.size = CGSizeMake(50, 50);
    return attrs;
}
/**
 这个方法是间距变化返回每一个attr的数组
 
 @param rect rect
 @return 属性的数组
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger index = 0; index < count; index++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [dataArray addObject:attrs];
    }
    return dataArray;
}


@end
