//
//  LDGContentFlowLayout.m
//  表情键盘控件封装
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGContentFlowLayout.h"

@interface LDGContentFlowLayout ()

@property (strong, nonatomic) NSMutableArray *attrsArray;
@property (assign, nonatomic) NSInteger totalCount;

@end

@implementation LDGContentFlowLayout
-(NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    self.layoutCows = self.layoutCows == 0 ? (2) : (self.layoutCows);
    self.layoutColumns = self.layoutColumns == 0 ? (4) : (self.layoutColumns);
    
    CGFloat attrW = 1.0 *(self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.layoutColumns - 1) * self.minimumInteritemSpacing)/self.layoutColumns;
    CGFloat attrH = 1.0 *(self.collectionView.frame.size.height - self.sectionInset.top - self.sectionInset.bottom - (self.layoutCows - 1) * self.minimumLineSpacing)/ self.layoutCows;
    NSInteger prePageCount = 0;
    // 多少个section（土豪 、时尚 、精彩、萝莉）
    for (NSInteger sectionIndex = 0; sectionIndex < self.collectionView.numberOfSections; sectionIndex ++) {
        // 每个section有多少个items
        NSInteger items = [self.collectionView numberOfItemsInSection:sectionIndex];
        for (NSInteger itemIndex = 0; itemIndex < items; itemIndex ++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:sectionIndex];
            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            NSInteger preItemPageCount = itemIndex/(self.layoutCows * self.layoutColumns);
            CGFloat attrsY = ((itemIndex % (self.layoutColumns * self.layoutCows))/ self.layoutColumns) * (attrH + self.minimumLineSpacing) + self.sectionInset.top;
            CGFloat attrsX = (prePageCount + preItemPageCount) * self.collectionView.frame.size.width + self.sectionInset.left + (itemIndex % self.layoutColumns) * (self.minimumInteritemSpacing + attrW);
            attr.frame = CGRectMake(attrsX, attrsY, attrW, attrH);
            [self.attrsArray addObject:attr];
        }
        // 这是一个小算法 前一个section有多少页数
        prePageCount += (items - 1)/(self.layoutCows * self.layoutColumns) + 1;
    }
    self.totalCount = prePageCount;
}
-(CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.totalCount * self.collectionView.frame.size.width,0);
    
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

@end
