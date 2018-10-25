//
//  DGEssenceTopicPresenter.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGEssenceTopicProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface DGEssenceTopicPresenter : NSObject
/**
 获取view

 @param view view
 */
-(void)attchView:(id <DGEssenceTopicProtocol>)view;
/**
 获取数据
 */
- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
