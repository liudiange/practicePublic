//
//  DGTopicModel.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGEssenceHeader.h"
#import "DGCommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGTopicModel : NSObject
/** id*/
@property (nonatomic, copy) NSString *topicId;
/** 标题头像*/
@property (copy, nonatomic) NSString *profile_image;
/** 标题*/
@property (copy, nonatomic) NSString *name;
/**  创建时间*/
@property (copy, nonatomic) NSString *created_at;
/** 内容*/
@property (copy, nonatomic) NSString *text;
/** 顶*/
@property (nonatomic, copy) NSString *ding;
/** 评论*/
@property (copy, nonatomic) NSString *comment;
/** 菜*/
@property (copy, nonatomic) NSString *cai;
/** 分享,转发分享的数量*/
@property (copy, nonatomic) NSString *repost;
/** 最热评论*/
@property (nonatomic, strong) DGCommonModel *top_cmt;
/** 内容的类型（音频，文字，图片等等的）*/
@property (nonatomic, assign) DGTopicType type;
/** 服务器返回的图片的宽度*/
@property (nonatomic, assign) CGFloat width;
/** 服务器返回的高度*/
@property (nonatomic, assign) CGFloat height;
/** 小的图片*/
@property (copy, nonatomic) NSString *small_image;
/** 中等的图片*/
@property (copy, nonatomic) NSString *middle_image;
/** 大的的图片*/
@property (copy, nonatomic) NSString *large_image;
/** 是不是gif图片*/
@property (assign, nonatomic) BOOL is_gif;
/** 播放的次数*/
@property (nonatomic, assign) NSInteger playcount;
/** 视频的总长*/
@property (nonatomic, assign) NSInteger videotime;
/** 声音的总长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 视频的播放地址*/
@property (nonatomic, copy) NSString *videourl;
/** 音频的播放地址*/
@property (nonatomic, copy) NSString *voiceurl;


/** 是不是大图*/
@property (nonatomic, assign) BOOL is_largeImage;
/** cell的内容属性*/
@property (nonatomic, assign) CGFloat cellHeight;
/** 根据类型显示frame*/
@property (nonatomic, assign) CGRect frame;


@end

NS_ASSUME_NONNULL_END
