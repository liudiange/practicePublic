//
//  LDGContentFlowLayout.h
//  表情键盘控件封装
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGContentFlowLayout : UICollectionViewFlowLayout
/**
 行数
 */
@property (assign, nonatomic) NSInteger layoutCows;
/**
 列数
 */
@property (assign, nonatomic) NSInteger layoutColumns;

@end
