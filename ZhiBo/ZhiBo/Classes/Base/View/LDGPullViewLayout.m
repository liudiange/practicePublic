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
@property (strong, nonatomic) NSMutableDictionary *minDic;


@end

@implementation LDGPullViewLayout
- (NSMutableArray *)attrArray {
    if (!_attrArray) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}
-(NSMutableDictionary *)minDic {
    if (!_minDic) {
        _minDic = [[NSMutableDictionary alloc] init];
    }
    return _minDic;
}
-(instancetype)init {
    if (self = [super init]) {
        // 填写默认的行、列间距 默认的列数
        self.rowMargon = 10;
        self.columnMargon = 10;
        self.columnCounts = 2;
        self.layoutInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
/**
 初始化的相关的操作 这里最准确
 */
- (void)prepareLayout {
    [super prepareLayout];
    // 给最小值的字典设置值
    for (NSInteger index = 0; index < self.columnCounts; index ++) {
        self.minDic[@(index)] = @(self.layoutInset.top);
    }
    // 开始的时候初始化
    [self.attrArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger index = 0; index < count; index++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.attrArray addObject:attrs];
    }
    
}

/**
 这个方法用来计算ContentSize的大小 最终能够滑动的

 @return size
 */
-(CGSize)collectionViewContentSize{
    
    __block NSNumber *maxNumber = [NSNumber numberWithInt:0];
    [self.minDic enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, NSNumber*  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.minDic[maxNumber] floatValue] < [obj floatValue]) {
            maxNumber = key;
        }
    }];
    return CGSizeMake(0, [self.minDic[maxNumber] floatValue] + self.layoutInset.bottom);
}
/**
 间距发生变化的时候改变

 @param newBounds newBounds
 @return 对象本身
 */
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
/**
 返回每一个的item的属性

 @param indexPath indexPath
 @return item的属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 宽度和高度
    CGFloat attrW = (self.collectionView.frame.size.width - (self.layoutInset.left + self.layoutInset.right) - (self.columnCounts-1)*self.columnMargon)/self.columnCounts;
    CGFloat scale = 0;
    if ([self.layoutDelegate respondsToSelector:@selector(receicewidthAndHeightScale:)]) {
        scale = [self.layoutDelegate receicewidthAndHeightScale:indexPath];
    }
    CGFloat attrH = attrW * scale;
    
    // 假设最小值的那列是第0列,假设最小的列是第0列
    __block NSNumber *minColumn = [NSNumber numberWithInt:0];
    [self.minDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSNumber *  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.minDic[minColumn] floatValue] > [obj floatValue]) {
            minColumn = key;
        }
    }];
    CGFloat attrX = [minColumn integerValue] * (attrW + self.columnMargon) + self.layoutInset.left;
    CGFloat attrY = [self.minDic[minColumn] floatValue] + self.rowMargon;
    attrs.frame = CGRectMake(attrX, attrY, attrW, attrH);
    self.minDic[minColumn] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

/**
 间距发生变化就调用这个方法

 @param rect rect
 @return 数组
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArray;
}


@end
