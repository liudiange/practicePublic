//
//  DGCacheMusicPlayer.m
//  播放器sdk
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGCacheMusicPlayer.h"
#import <AVFoundation/AVFoundation.h>

#define DGPlayerStatusKey @"status"
#define DGPlayerRateKey @"rate"
#define DGPlayerLoadTimeKey @"loadedTimeRanges"
#define DGPlayerBufferEmty @"playbackBufferEmpty"
#define DGPlayerLikelyToKeepUp @"playbackLikelyToKeepUp"

@interface DGCacheMusicPlayer ()

/** 当前的播放的模型*/
@property (strong, nonatomic) DGCacheMusicModel *currentModel;
/** 当前的播放模式*/
@property (assign, nonatomic) DGCacheMusicMode innerCurrentMode;
/** 当前的播放器状态*/
@property (assign, nonatomic) DGCacheMusicState innerPlayState;
/** 是否需要缓存*/
@property (assign, nonatomic) BOOL isNeedCache;
/** 播放器*/
@property (strong, nonatomic) AVPlayer *player;
/** 播放的item*/
@property (strong, nonatomic) AVPlayerItem *playerItem;
/** 播放的数组*/
@property (strong, nonatomic) NSMutableArray *playList;
/** 播放进度的观察者*/
@property (strong, nonatomic) id playerObserver;


@end
@implementation DGCacheMusicPlayer
#pragma mark - 懒加载的创建
-(NSMutableArray *)playList {
    if (!_playList) {
        _playList = [[NSMutableArray alloc] init];
    }
    return _playList;
}
#pragma mark - 初始化
+(instancetype)shareInstance{
    
    static DGCacheMusicPlayer * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}
- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.innerPlayState = DGCacheMusicStateStop;
        self.innerCurrentMode = DGCacheMusicModeListRoop;
        self.currentModel = nil;

    }
    return self;
}
#pragma mark - 设置相关的方法
/**
 设置播放列表没有设置播放列表播放器没有播放地址
 
 @param playList 需要播放的模型数组
 @param offset 偏移量
 @param cache 是否需要缓存 YES：边下边播 NO:不缓存 在线播放
 */
- (void)setPlayList:(NSArray<DGCacheMusicModel *> *)playList
             offset:(NSUInteger)offset
            isCache:(BOOL)cache{
    
    NSAssert(playList.count != 0, @"对不起播放数组不能为空");
    NSAssert(!(offset > playList.count - 1 || offset < 0), @"offset不合法，大于播放列表的个数或者小于0了");
    if (offset > playList.count - 1 || offset < 0 || playList.count == 0) return;
    [self.playList addObjectsFromArray:playList];
    self.currentModel = self.playList[offset];
    if (self.currentModel.listenUrl.length == 0) return;
    self.isNeedCache = cache;
    if (self.isNeedCache == NO) { // 不需要缓存的情况
        if (!self.player) {

            self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.currentModel.listenUrl]];
            self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
            [self.player play];
        }
        
        
    }else{ // 需要缓存的情况
        
    }
    
    
    
    
}
#pragma mark - 自己方法的实现
/**
 移除观察者
 */
- (void)removeMyObserver{
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:DGPlayerStatusKey];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerLoadTimeKey];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerBufferEmty];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerLikelyToKeepUp];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    if (self.player) {
        [self.player removeObserver:self forKeyPath:DGPlayerRateKey];
    }
    if (self.playerObserver && self.player) {
        [self.playerObserver removeObserver:self];
        self.playerObserver = nil;
    }
    
}
/**
 添加我的观察者
 */
- (void)addMyObserver{
    
    // 添加在播放器开始播放后的通知
    if (self.playerItem) {
        
        [self.playerItem addObserver:self forKeyPath:DGPlayerStatusKey options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:DGPlayerLoadTimeKey options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:DGPlayerBufferEmty options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:DGPlayerLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    if (self.player) {
        // 监听播放进度等等
      self.playerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
      }];
        // 播放速度
        [self.player addObserver:self forKeyPath:DGPlayerRateKey options:NSKeyValueObservingOptionNew context:nil];
    }
}
/**
 播放完成

 @param info 信息
 */
- (void)didFinishAction:(NSNotification *)info{
    
}

@end
