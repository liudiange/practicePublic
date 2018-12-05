//
//  DGDownloadManager.h
//  播放器sdk
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DGDownloadManager;

NS_ASSUME_NONNULL_BEGIN

@protocol DGDownloadManagerDelegate <NSObject>

/**
 下载的进度 0 - 1

 @param manager manager
 @param need 是否需要进度 YES : 需要进度 NO：不需要进度
 */
- (void)downloadManager:(DGDownloadManager *)manager updateCacheProgressIsNeed:(BOOL)need;
/**
 下载失败了

 @param downloadManager 下载管理者
 @param error 错误信息
 */
- (void)downloadManager:(DGDownloadManager *)downloadManager failure:(NSError *)error;

@end
@interface DGDownloadManager : NSObject

/** delegate*/
@property (weak, nonatomic) id<DGDownloadManagerDelegate> downloadManagerDelegate;
/** 请求的其实位置 */
@property (assign, nonatomic) NSUInteger requestOffset;
/** 文件长度 */
@property (assign, nonatomic) NSUInteger fileLenth;
/** 缓存的长度 */
@property (assign, nonatomic) NSUInteger cacheLength;
/** 下载的链接,可能是某一段的url */
@property (strong, nonatomic) NSURL *requestURL;
/** 是否需要缓存 */
@property (assign, nonatomic) BOOL isCache;
/** 是否取消下载的请求 */
@property (assign, nonatomic) BOOL cancel;
/**
 开始发送请求
 */
- (void)startRequest;


@end

NS_ASSUME_NONNULL_END
