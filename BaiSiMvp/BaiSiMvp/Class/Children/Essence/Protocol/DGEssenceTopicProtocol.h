//
//  DGEssenceTopicProtocol.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGTopicModel.h"
#import "DGEssenceHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DGEssenceTopicProtocol <NSObject>
/**
 获得type，父类的方法在子类中实现
 
 @return 获得type
 */
- (DGTopicType)fetchTopicType;
/**
 展示加载信息的动画相关
 */
- (void)showLoadAnimation;
/**
 隐藏加载的动画信息
 */
- (void)hideLoadAnimation;
/**
 获取数据

 @param modelArray 获得的数据
 */
- (void)fetch:(NSArray<DGTopicModel *> *)modelArray;

@end
NS_ASSUME_NONNULL_END

