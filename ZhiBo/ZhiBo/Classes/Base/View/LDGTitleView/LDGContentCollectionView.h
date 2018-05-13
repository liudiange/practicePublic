//
//  LDGContentCollectionView.h
//  表情键盘控件封装
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGCommonModel.h"
#import "LDGContentFlowLayout.h"


@protocol LDGContentCollectionViewDelegate <NSObject>


@optional

-(void)ldgContentCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LDGContentCollectionViewDatasource <NSObject>

@required

- (NSInteger)ldgContentCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (__kindof UICollectionViewCell *)ldgContentCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInldgContentCollectionView:(UICollectionView *)collectionView;
@end

@interface LDGContentCollectionView : UIView

@property (weak, nonatomic ,nullable) id <LDGContentCollectionViewDelegate> contnetViewDelegate;
@property (weak ,nonatomic ,nullable) id <LDGContentCollectionViewDatasource> contentViewDataSource;

/**
 常用属性的类型
 */
@property (strong, nonatomic) LDGCommonModel *commonModel;
/**
 标题的高度
 */
@property (assign, nonatomic) CGFloat titleViewHeight;
/**
 是否显示在底部 yes 显示在底部
 */
@property (assign, nonatomic) BOOL isShouldBottom;
/**
 标题的数组
 */
@property (strong, nonatomic) NSMutableArray *titles;
/**
 layout
 */
@property (strong, nonatomic) LDGContentFlowLayout *collectionLayout;

/**
 用这种方式创建一个view
 
 @param frame 边距
 @param titleH 标题的高度
 @param isShouldBottom 是否标题显示在底部
 @param titles 标题的数组
 @param collectionLayout 传递进来的layout
 @param commonModel 其他的相关设置属性
 @return 对象本身
 */
- (instancetype)initWithFrame:(CGRect)frame titleH:(CGFloat)titleH isShouldBottom:(BOOL)isShouldBottom titles:(NSArray <NSString *> *)titles layout:(LDGContentFlowLayout *)collectionLayout withCommonModel:(LDGCommonModel *)commonModel;
/**
 注册class

 @param cellClass cellClass
 @param identifier identifier
 */
- (void)ldgContentRegisterClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
/**
 xib注册

 @param nib nib
 @param identifier identifier
 */
- (void)ldgContentRegisterNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
/**
 刷新数据
 */
- (void)ldgContentReloadData;


@end
