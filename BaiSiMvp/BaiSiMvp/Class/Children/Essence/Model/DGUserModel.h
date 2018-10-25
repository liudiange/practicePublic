//
//  DGUserModel.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DGUserModel : NSObject
/** 名字*/
@property (nonatomic, copy) NSString *username;
/** id*/
@property (nonatomic, copy) NSString *userId;
/** 用户的头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 用户的性别*/
@property (nonatomic, copy) NSString *sex;
@end

NS_ASSUME_NONNULL_END
