//
//  LDGlineFlowLayout.m
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "LDGlineFlowLayout.h"

@implementation LDGlineFlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(100, 100);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 100;
    self.sectionInset = UIEdgeInsetsMake(0, (self.collectionView.frame.size.width - self.itemSize.width)*0.5, 0, (self.collectionView.frame.size.width - self.itemSize.width)*0.5);
}

/**
 这个方法是用来判断每次属性变化的时候都会返回

 @param newBounds 新的位置变化
 @return 是否都会会回调用
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
/**
 最终停留的地方

 @param proposedContentOffset 系统自动计算停留的地方
 @param velocity 速度
 @return 要停留的地方
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 只需要计算当前与屏幕相交的即可 没有必要放大所有的
    CGRect currentRect;
    currentRect.size = self.collectionView.frame.size;
    currentRect.origin = self.collectionView.contentOffset;
    NSArray *array = [self layoutAttributesForElementsInRect:currentRect];
     // 屏幕的中心点
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 计算最小值
    CGFloat minF = MAXFLOAT;
    CGFloat adjustF = 0;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - screenCenterX) <= minF) {
            adjustF = attrs.center.x - screenCenterX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustF, proposedContentOffset.y);
}
/**
 这个方法是间距变化返回每一个attr的数组

 @param rect rect
 @return 属性的数组
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 只需要计算当前与屏幕相交的即可 没有必要放大所有的
    CGRect currentRect;
    currentRect.size = self.collectionView.frame.size;
    currentRect.origin = self.collectionView.contentOffset;
    // 拿到屏幕的中心点
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (!CGRectIntersectsRect(currentRect, attrs.frame)) {
            continue;
        }
        // 计算差值
        CGFloat differX = ABS(attrs.center.x - screenCenterX);
        // 计算需要放大的倍数
        CGFloat scale = 1 + 0.7*(1- differX/self.collectionView.frame.size.width);
        if (scale <= 1.3) {
            scale = 1;
        }
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}



@end
