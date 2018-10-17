//
//  DGEssencePresenter.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGEssenceProtocol.h"
#import "DGEssenceController.h"
#import <UIkit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface DGEssencePresenter : NSObject
/**
 获取控制器

 @param controller vc
 */
- (void)attchView:(DGEssenceController *)controller;
/**
 获取数据
 */
- (void)fetchData;
/**
 添加子控制器

 @param controllerVcArray 自控制器的数组
 @param titlesArray 子控制的标题
 */
- (void)addChildVc:(NSArray<UIViewController *>*)controllerVcArray titles:(NSArray<NSString*>*)titlesArray;

@end

NS_ASSUME_NONNULL_END
