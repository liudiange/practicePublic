//
//  DGCommonModel.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGCommonModel : NSObject
/** id*/
@property (nonatomic, copy) NSString *commentId;
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** user*/
@property (nonatomic, strong) DGUserModel *user;
/** 被点赞的个数*/
@property (nonatomic, assign) NSInteger like_count;
/** 音频文件的时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的url*/
@property (nonatomic, copy) NSString *voiceuri;

@end

NS_ASSUME_NONNULL_END
