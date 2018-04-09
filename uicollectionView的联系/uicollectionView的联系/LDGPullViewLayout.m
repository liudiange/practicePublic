//
//  LDGPullViewLayout.m
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/8.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "LDGPullViewLayout.h"

@interface LDGPullViewLayout ()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>*attrArray;

@end
@implementation LDGPullViewLayout
- (NSMutableArray *)attrArray {
    if (!_attrArray) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}

-(instancetype)init {
    if (self = [super init]) {
        // 填写默认的行、列间距 默认的列数
        self.rowMargon = 10;
        self.columnMargon = 10;
        self.columnCounts = 2;
    }
    return self;
}
/**
 初始化的相关的操作 这里最准确
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    
}
/**
 间距发生变化的时候改变

 @param newBounds newBounds
 @return 对象本身
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
/**
 返回每一个的item的属性

 @param indexPath indexPath
 @return item的属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat attrX = 0.0;
    CGFloat attrY = 0.0;
    CGFloat attrW = 100;
    CGFloat attrH = 100;
    attrs.frame = CGRectMake(attrX, attrY, attrW, attrH);
    return attrs;
}

/**
 间距发生变化就调用这个方法

 @param rect rect
 @return 数组
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    [self.attrArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger index = 0; index < count; index++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.attrArray addObject:attrs];
    }
    return self.attrArray;
}


@end
