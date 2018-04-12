//
//  UIView+MGSCXMusicSwipCategory.h
//  探探动画
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MGSCXMusicSwipCategory)
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;


- (UIView*)snapshotView;
- (void)removeAllSubviews;
+ (instancetype)viewFromXib;
@end


@interface UIColor (MGSCXMusicSwipCategory)
+ (instancetype)randomColor;
+ (instancetype)colorWithHex:(NSUInteger)hexColor;
+ (instancetype)colorWithHexString:(NSString *)hexStr;
@end
