//
//  DGMusicManager.m
//  播放器sdk
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGMusicManager.h"

#define DGPlayerStatusKey @"status"
#define DGPlayerLoadTimeKey @"loadedTimeRanges"

@interface DGMusicManager ()

/**播放器*/
@property (strong, nonatomic)  AVPlayer *player;
/**当前的播放模式*/
@property (assign, nonatomic) DGPlayMode innerCurrentPlayMode;
/**当前的播放状态 */
@property (assign, nonatomic) DGPlayerStatus innerCurrentPlayStatus;
/**当前的音乐的播放信息*/
@property (strong, nonatomic) DGMusicInfo *innerCurrentMusicInfo;
/**AVPlayerItem*/
@property (strong, nonatomic) AVPlayerItem *playerItem;
/**当前的播放列表*/
@property (strong, nonatomic) NSMutableArray *playList;



@end

@implementation DGMusicManager
-(NSMutableArray *)playList {
    if (!_playList) {
        _playList = [[NSMutableArray alloc] init];
    }
    return _playList;
}
#pragma mark - 初始化的方法，以及相关的设置等等
+(instancetype)shareInstance{
    static id _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.innerCurrentPlayMode = DGPlayModeListRoop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeMode:)]) {
            [self.DGDelegate DGPlayerChangeMode:DGPlayModeListRoop];
        }
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
    }
    return self;
}
/**
 设置播放列表并且开始播放，此时的播放模式为列表循环
 
 @param listArray 播放的数组
 @param offset 从第几个开始
 */
- (void)setPlayList:(NSArray<DGMusicInfo *> *)listArray offset:(NSUInteger)offset{
    [self.playList addObjectsFromArray:listArray];
    
    NSAssert(!(offset < 0 || offset > self.playList.count - 1), @"歌曲播放位置不合法");
    NSAssert(!(self.playList.count <= 0), @"播放数组不能为空");
    
    if ((offset < 0 || offset > self.playList.count - 1) || self.playList.count == 0){ return;}
    DGMusicInfo *musicInfo = self.playList[offset];
    self.innerCurrentMusicInfo = musicInfo;
    if (musicInfo.listenUrl.length == 0) {return;}
    
    if (!self.player) {
        NSURL *url = [NSURL URLWithString:musicInfo.listenUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
        self.playerItem = item;
        self.player = player;
    }else{
        NSURL *url = [NSURL URLWithString:musicInfo.listenUrl];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    }
    // 添加开始播放前的通知监听
    if (self.playerItem) {
        
        [self.playerItem removeObserver:self forKeyPath:DGPlayerStatusKey];
        [self.playerItem addObserver:self forKeyPath:DGPlayerStatusKey options:NSKeyValueObservingOptionNew context:nil];
    }
    [self.player play];
    // 添加在播放器开始播放后的通知
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:DGPlayerLoadTimeKey];
        [self.playerItem addObserver:self forKeyPath:DGPlayerLoadTimeKey options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
}
#pragma mark - 观察者的监听、代理的返回等等
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:DGPlayerStatusKey]) { // 监听播放器的状态
        switch (self.playerItem.status) {
            case AVPlayerStatusReadyToPlay:
            {
                self.innerCurrentPlayStatus = DGPlayerStatusPlay;
                if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                    [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
                }
            }
                break;
            case AVPlayerStatusFailed:
            {
                self.innerCurrentPlayStatus = DGPlayerStatusStop;
                if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                    [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
                }
                if ([self.DGDelegate respondsToSelector:@selector(DGPlayerPlayFailure:)]) {
                    [self.DGDelegate DGPlayerPlayFailure:AVPlayerStatusFailed];
                }
            }
                break;
            case AVPlayerStatusUnknown:
            {
                self.innerCurrentPlayStatus = DGPlayerStatusPause;
                if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                    [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPause];
                }
            }
                break;
            default:
                break;
        }
        
    }else if ([keyPath isEqualToString:DGPlayerLoadTimeKey]){ //监听播放器的缓冲情况
        
        
    }
}
/**
 一首歌播放完成的通知

 @param info 通知
 */
- (void)didFinishAction:(NSNotification *)info{
    
    DGMusicInfo *nextMusicInfo = self.playList[[self nextIndex]];
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerFinished:)]) {
        [self.DGDelegate DGPlayerFinished:nextMusicInfo];
    }
    
}
/**
 下一手歌曲的下标

 @return 下一首歌曲下标
 */
-(NSUInteger)nextIndex{
    
    NSUInteger index = [self.playList indexOfObject:self.currentMusicInfo];
    NSUInteger nextIndex = index + 1;
    if (nextIndex == self.playList.count) {
        nextIndex = 0;
    }
    return nextIndex;
}
/**
 上一首歌曲的下标

 @return 上一首歌曲的下标签
 */
-(NSUInteger)previousIndex{
    NSUInteger index = [self.playList indexOfObject:self.currentMusicInfo];
    NSUInteger previousIndex = index - 1;
    if (previousIndex == -1) {
        previousIndex = self.playList.count - 1;
    }
    return previousIndex;
}

/**
 移除全部的通知
 */
-(void)removeMyObserver{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:DGPlayerStatusKey];
    [self.playerItem removeObserver:self forKeyPath:DGPlayerLoadTimeKey];
    
}
#pragma Mark - 需要返回和设置的方法
/**
 当前的播放状态，方便用户随时拿到
 
 @return 对应的播放状态
 */
- (DGPlayerStatus)currentPlayeStatus{
    
    return self.innerCurrentPlayStatus;
}
/**
 获取到当前的播放模式
 
 @return 对应的播放模式
 */
- (DGPlayMode)currentPlayMode{
    
    return self.innerCurrentPlayMode;
}
/**
 当前的播放的模型
 
 @return 当前的播放模型
 */
- (DGMusicInfo *)currentMusicInfo{
    
    return self.innerCurrentMusicInfo;
}
/**
 当前播放e歌曲的下标
 
 @return 为了你更加省心 我给你提供出来
 */
- (NSUInteger)currentIndex{
   return [self.playList indexOfObject:self.innerCurrentMusicInfo];
    
}
/**
 获得播放列表
 
 @return 播放列表
 */
- (NSArray<DGMusicInfo *> *)getPlayList{
    return self.playList;
}
/**
 点击下一首播放
 
 @param isNeedSingRoopJump 当单曲循环的时候是否需要跳转到下一首（只有在单曲循环的情况下才有用）
 如果传递是yes的情况下，那么单曲循环就会跳转到下一首循环播放
 */
- (void)playNextSong:(BOOL)isNeedSingRoopJump{
    
    NSAssert(self.playList.count != 0, @"你还没有设置播放列表");
    if (self.playList.count == 0) {
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
        return;
    }
    if (self.innerCurrentMusicInfo.listenUrl.length == 0) {
        self.innerCurrentMusicInfo = [self.playList firstObject];
    }
    // 播放当前单曲循环的歌曲
    if (self.innerCurrentPlayMode == DGPlayModeSingleRoop && isNeedSingRoopJump == NO) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.innerCurrentMusicInfo.listenUrl]];
        self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        [self.player play];
        self.innerCurrentPlayStatus = DGPlayerStatusPlay;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
        }
        return;
    }
    // 随机播放
    if (self.innerCurrentPlayMode == DGPlayModeRandPlay) {
        NSUInteger randIndex = arc4random_uniform((int32_t)self.playList.count - 1);
        DGMusicInfo *info = self.playList[randIndex];
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:info.listenUrl]];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player play];
        self.innerCurrentPlayStatus = DGPlayerStatusPlay;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
        }
        return;
    }
    NSUInteger nextIndex = [self nextIndex];
    DGMusicInfo *nextMusicInfo = self.playList[nextIndex];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:nextMusicInfo.listenUrl]];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
    self.innerCurrentPlayStatus = DGPlayerStatusPlay;
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
        [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
    }
}
/**
 播放上一首歌曲
 
 @param isNeedSingRoopJump 当单曲循环的时候是否需要跳转到下一首（只有在单曲循环的情况下才有用）
 如果传递是yes的情况下，那么单曲循环就会跳转到下一首循环播放
 */
- (void)playPreviousSong:(BOOL)isNeedSingRoopJump{
    NSAssert(self.playList.count != 0, @"你还没有设置播放列表");
    if (self.playList.count == 0) {
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
        return;
    }
    if (self.innerCurrentMusicInfo.listenUrl.length == 0) {
        self.innerCurrentMusicInfo = [self.playList firstObject];
    }
    // 播放当前单曲循环的歌曲
    if (self.innerCurrentPlayMode == DGPlayModeSingleRoop && isNeedSingRoopJump == NO) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.innerCurrentMusicInfo.listenUrl]];
        self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        [self.player play];
        self.innerCurrentPlayStatus = DGPlayerStatusPlay;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
        }
        return;
    }
    // 随机播放
    if (self.innerCurrentPlayMode == DGPlayModeRandPlay) {
        NSUInteger randIndex = arc4random_uniform((int32_t)self.playList.count - 1);
        DGMusicInfo *info = self.playList[randIndex];
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:info.listenUrl]];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player play];
        self.innerCurrentPlayStatus = DGPlayerStatusPlay;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
        }
        return;
    }
    NSUInteger previousIndex = [self previousIndex];
    DGMusicInfo *previousMusicInfo = self.playList[previousIndex];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:previousMusicInfo.listenUrl]];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
    self.innerCurrentPlayStatus = DGPlayerStatusPlay;
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
        [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
    }
}
/**
 设置当前的播放动作
 
 @param Operate 动作： 播放、暂停、停止
 停止：清空播放列表，如果在要播放需要重新设置播放列表
 */
- (void)playOperate:(DGPlayerPlayOperate)Operate{
    switch (Operate) {
        
        case DGPlayerPlayOperatePlay:
        {
            if (self.innerCurrentMusicInfo.listenUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            [self.player play];
            self.innerCurrentPlayStatus = DGPlayerStatusPlay;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
            }
            
        }
            break;
        case DGPlayerPlayOperatePause:
        {
            if (self.innerCurrentMusicInfo.listenUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            [self.player pause];
            self.innerCurrentPlayStatus = DGPlayerStatusPause;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPause];
            }
        }
            break;
        
        case DGPlayerPlayOperateStop:
        {
            if (self.innerCurrentMusicInfo.listenUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            
            [self.player pause];
            [self removeMyObserver];
            [self.playList removeAllObjects];
            self.innerCurrentMusicInfo = nil;
            self.player = nil;
            self.playerItem = nil;
            self.innerCurrentPlayStatus = DGPlayerStatusStop;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
            }
        }
            break;
        default:
            break;
    }
    
}
/**
 设置当前的播放模式
 
 @param mode 自己要设置的模式
 */
- (void)updateCurrentPlayMode:(DGPlayMode)mode{
    self.innerCurrentPlayMode = mode;
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeMode:)]) {
        [self.DGDelegate DGPlayerChangeMode:mode];
    }
}
/**
 清空播放列表
 
 @param isStopPlay YES:停止播放 NO:不停止播放
 */
- (void)clearPlayList:(BOOL)isStopPlay{
    
    if (isStopPlay) {
        [self.player pause];
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
        [self removeMyObserver];
        self.player = nil;
        self.playerItem = nil;
        self.innerCurrentMusicInfo = nil;
    }
    [self.playList removeAllObjects];
}
/**
 删除一个播放列表
 
 @param deleteList 要删除的播放列表
 */
- (void)deletePlayList:(NSArray<DGMusicInfo *>*)deleteList{
    
    if (deleteList.count == 0) {return;}
    NSMutableArray *temAttay = [NSMutableArray array];
    for (NSInteger index = 0; index < deleteList.count; index ++) {
        DGMusicInfo *info = deleteList[index];
        if ([self.playList containsObject:info]) {
            [temAttay addObject:info];
        }
    }
    
    if (temAttay.count == 0) {return;}
    if ([temAttay containsObject:self.innerCurrentMusicInfo]) {
        [self.player pause];
    }
    // 删除数组
    [self.playList removeObjectsInArray:temAttay];
}
/**
 添加一个新的歌单到播放列表
 
 @param addList 新的歌曲的数组
 */
- (void)addPlayList:(NSArray<DGMusicInfo *>*)addList{
    
    [self.playList addObjectsFromArray:addList];
}
@end
