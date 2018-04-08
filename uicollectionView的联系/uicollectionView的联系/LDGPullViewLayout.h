//
//  LDGPullViewLayout.h
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/8.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGPullViewLayout : UICollectionViewLayout

// 每一行之间的间距
@property (nonatomic, assign) CGFloat rowMargon;
// 每一列之间之间的间距
@property (nonatomic, assign) CGFloat columnMargon;
// 设置边距离
@property (nonatomic, assign) UIEdgeInsets layoutInset;
// 显示多少列
@property (nonatomic, assign) int columnCounts;

@end
