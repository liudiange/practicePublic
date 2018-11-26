//
//  DGCacheMusicPlayer.h
//  播放器sdk
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
typedef NS_ENUM(NSUInteger, DGCacheMusicOperate){
    
    DGCacheMusicOperatePlay       = 1, // 播放操作
    DGCacheMusicOperatePause      = 2, // 暂停操作
    DGCacheMusicOperateStop       = 3  // 停止操作
};
NS_ASSUME_NONNULL_BEGIN

@protocol DGCacheMusicPlayerDelegate <NSObject>


@end
@interface DGCacheMusicPlayer : NSObject
#pragma mark - 初始化
@property (weak, nonatomic) id <DGCacheMusicPlayerDelegate> DGCacheMusicDelegate;
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
/**
 点击下一首播放
 
 @param isNeedSingRoopJump 当单曲循环的时候是否需要跳转到下一首（只有在单曲循环的情况下才有用）
 如果传递是yes的情况下，那么单曲循环就会跳转到下一首循环播放
 */
- (void)playNextSong:(BOOL)isNeedSingRoopJump;
/**
 播放上一首歌曲
 
 @param isNeedSingRoopJump 当单曲循环的时候是否需要跳转到下一首（只有在单曲循环的情况下才有用）
 如果传递是yes的情况下，那么单曲循环就会跳转到下一首循环播放
 */
- (void)playPreviousSong:(BOOL)isNeedSingRoopJump;
/**
 设置当前的播放动作
 
 @param operate 动作： 播放、暂停、停止
 停止：清空播放列表，如果在要播放需要重新设置播放列表
 */
- (void)playOperate:(DGCacheMusicOperate)operate;
/**
 设置当前的播放模式
 
 @param mode 自己要设置的模式
 */
- (void)updateCurrentPlayMode:(DGCacheMusicMode)mode;
/**
 清空播放列表
 
 @param isStopPlay YES:停止播放 NO:不停止播放
 */
- (void)clearPlayList:(BOOL)isStopPlay;
/**
 删除一个播放列表
 
 @param deleteList 要删除的播放列表
 */
- (void)deletePlayList:(NSArray<DGCacheMusicModel *>*)deleteList;
/**
 添加一个新的歌单到播放列表
 
 @param addList 新的歌曲的数组
 */
- (void)addPlayList:(NSArray<DGCacheMusicModel *>*)addList;
/**
 快进或者快退
 
 @param time 要播放的那个时间点
 */
- (void)seekTime:(NSUInteger)time;








@end
NS_ASSUME_NONNULL_END
