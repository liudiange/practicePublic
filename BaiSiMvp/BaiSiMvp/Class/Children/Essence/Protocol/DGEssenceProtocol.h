//
//  DGEssenceProtocol.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol DGEssenceProtocol <NSObject>

- (NSArray<UIViewController *>*)getControllerVcArray;
- (NSArray<NSString *>*)getControllerTitleArray;

@end

NS_ASSUME_NONNULL_END
