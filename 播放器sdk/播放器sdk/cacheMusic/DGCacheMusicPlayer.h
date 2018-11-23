//
//  DGCacheMusicPlayer.h
//  播放器sdk
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGCacheMusicModel.h"

typedef NS_ENUM(NSUInteger,DGCacheMusicState) {
    
    DGCacheMusicStatePlay        = 1, // 播放
    DGCacheMusicStatePause       = 2, // 暂停
    DGCacheMusicStateBuffer      = 3, // 缓冲
    DGCacheMusicStateStop        = 4, // 停止
    DGCacheMusicStateError       = 5, // 错误
    DGCacheMusicStateWaitting    = 6  // 等待中的状态
};
typedef NS_ENUM(NSUInteger, DGCacheMusicMode){
    
    DGCacheMusicModeListRoop       = 1, // 列表循环
    DGCacheMusicModeRandom         = 2, // 随机播放
    DGCacheMusicModeSingleRoop     = 3  // 单曲循环
};
NS_ASSUME_NONNULL_BEGIN

@interface DGCacheMusicPlayer : NSObject
#pragma mark - 初始化
+(instancetype)shareInstance;
#pragma mark - 设置相关的方法
/**
 设置播放列表没有设置播放列表播放器没有播放地址

 @param playList 需要播放的模型数组
 @param offset 偏移量
 @param cache 是否需要缓存 YES：边下边播 NO:不缓存 在线播放
 */
- (void)setPlayList:(NSArray<DGCacheMusicModel *> *)playList
             offset:(NSUInteger)offset
            isCache:(BOOL)cache;








@end
NS_ASSUME_NONNULL_END
