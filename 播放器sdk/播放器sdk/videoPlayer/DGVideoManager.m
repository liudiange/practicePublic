//
//  DGVideoManager.m
//  播放器sdk
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGVideoManager.h"

#define DGPlayerStatusKey @"status"
#define DGPlayerRate @"rate"
#define DGPlayerLoadTimeKey @"loadedTimeRanges"
#define DGPlayerBufferEmty @"playbackBufferEmpty"
#define DGPlayerLikelyToKeepUp @"playbackLikelyToKeepUp"

@interface DGVideoManager ()

/**播放器*/
@property (strong, nonatomic)  AVPlayer *player;
/**当前的播放状态 */
@property (assign, nonatomic) DGPlayerStatus innerCurrentPlayStatus;
/**当前的音乐的播放信息*/
@property (strong, nonatomic) DGVideoInfo *innerCurrentMusicInfo;
/**AVPlayerItem*/
@property (strong, nonatomic) AVPlayerItem *playerItem;
/**当前的播放列表*/
@property (strong, nonatomic) NSMutableArray *playList;
/**进度观察的返回者*/
@property (strong, nonatomic) id progressObserver;
/** needAddView 添加layer的*/
@property (strong, nonatomic) CALayer *needAddLayer;
/** videoFrame*/
@property (assign, nonatomic) CGRect videoFrame;
/** currentVideoGravity*/
@property (assign, nonatomic) AVLayerVideoGravity currentVideoGravity;

@end

@implementation DGVideoManager
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
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
    }
    return self;
}
/**
 设置播放列表没有设置播放列表播放器没有播放地址
 
 @param playList 需要播放的模型数组
 @param offset 偏移量
 @param videoGravity 视频的显示类型
 @param addViewLayer 需要添加的layer
 @param frame 视频的frame
 */
- (void)setPlayList:(NSArray<DGVideoInfo *> *)playList
             offset:(NSUInteger)offset
       videoGravity:(AVLayerVideoGravity)videoGravity
       addViewLayer:(CALayer *)addViewLayer
         layerFrame:(CGRect)frame{
    
    [self.playList addObjectsFromArray:playList];
    
    NSAssert(!(offset < 0 || offset > self.playList.count - 1), @"歌曲播放位置不合法");
    NSAssert(!(self.playList.count <= 0), @"播放数组不能为空");
    if ((offset < 0 || offset > self.playList.count - 1) || self.playList.count == 0){ return;}
    
    DGVideoInfo *musicInfo = self.playList[offset];
    self.innerCurrentMusicInfo = musicInfo;
    if (musicInfo.playUrl.length == 0) {return;}
    
    if (!self.player) {
        NSURL *url = [NSURL URLWithString:musicInfo.playUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
        self.playerItem = item;
        self.player = player;
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = frame;
        playerLayer.videoGravity = videoGravity;
        [addViewLayer addSublayer:playerLayer];
        [self.player play];
        [self addMyObserver];
        self.currentVideoGravity = videoGravity;
        self.needAddLayer = addViewLayer;
        self.videoFrame = frame;
        
    }else{
        [self removeMyObserver];
        NSURL *url = [NSURL URLWithString:musicInfo.playUrl];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = frame;
        playerLayer.videoGravity = videoGravity;
        [addViewLayer addSublayer:playerLayer];
        [self.player play];
        [self addMyObserver];
        self.currentVideoGravity = videoGravity;
        self.needAddLayer = addViewLayer;
        self.videoFrame = frame;
    }
}
#pragma mark - 观察者的监听、代理的返回等等
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:DGPlayerStatusKey]) { // 监听播放器的状态
        
        NSLog(@"当前的播放状态 %zd",self.playerItem.status);
        
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
        
        NSArray *array = self.playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
        CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
        CGFloat totalBuffer = startSeconds + durationSeconds;
        CGFloat durationTime = CMTimeGetSeconds(self.playerItem.duration);
        
        CGFloat bufferProgress = totalBuffer/durationTime;
        if (isnan(bufferProgress)) {
            bufferProgress = 0;
        }
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerBufferProgress:)]) {
            [self.DGDelegate DGPlayerBufferProgress:bufferProgress];
        }
        
        if (bufferProgress < 1.0) {
            self.innerCurrentPlayStatus = DGPlayerStatusBuffer;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusBuffer];
            }
        }else{
            self.innerCurrentPlayStatus = DGPlayerStatusPlay;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
            }
        }
        NSLog(@"bufferProgress :%f",bufferProgress);
    }else if ([keyPath isEqualToString:DGPlayerRate]){ // 播放速度 0 就是暂停了
        
        NSLog(@"self.player.rate :%f",self.player.rate);
        
        if (self.player.rate == 0) {
            self.innerCurrentPlayStatus = DGPlayerStatusPause;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPause];
            }
        }else{
            self.innerCurrentPlayStatus = DGPlayerStatusPlay;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
            }
        }
    }else if([keyPath isEqualToString:DGPlayerBufferEmty]){ //没有足够的缓冲区了，监听播放播放器在缓冲区的状态
        NSLog(@"没有足够的缓冲区了，监听播放播放器在缓冲区的状态");
        self.innerCurrentPlayStatus = DGPlayerStatusBuffer;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusBuffer];
        }
    }else if([keyPath isEqualToString:DGPlayerLikelyToKeepUp]){ // 说明缓冲区有足够的数据可以播放，一般这种情况我们什么都不干
        
    }
}
/**
 一个歌播放完成的通知
 
 @param info 通知
 */
- (void)didFinishAction:(NSNotification *)info{
   
    // 把下一个歌曲回调回去
    DGVideoInfo *nextMusicInfo = self.playList[[self nextIndex]];
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerFinished:)]) {
        [self.DGDelegate DGPlayerFinished:nextMusicInfo];
    }
    // 开始播放下一个
    [self playNextVideo];
}
/**
 下一手歌曲的下标
 
 @return 下一个歌曲下标
 */
-(NSUInteger)nextIndex{
    
    if (self.innerCurrentMusicInfo == nil) return 0;
    
    NSUInteger index = [self.playList indexOfObject:self.currentMusicInfo];
    NSUInteger nextIndex = index + 1;
    if (nextIndex == self.playList.count) {
        nextIndex = 0;
    }
    return nextIndex;
}
/**
 上一个歌曲的下标
 
 @return 上一个歌曲的下标签
 */
-(NSUInteger)previousIndex{
    
    if (self.innerCurrentMusicInfo == nil) return 0;
    
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
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:DGPlayerStatusKey];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerLoadTimeKey];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerLikelyToKeepUp];
        [self.playerItem removeObserver:self forKeyPath:DGPlayerBufferEmty];
    }
    if (self.player) {
        [self.player removeObserver:self forKeyPath:DGPlayerRate];
    }
    if (self.progressObserver && self.player) {
        [self.player removeTimeObserver:self.progressObserver];
        self.progressObserver = nil;
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
    // 监听播放速度
    if (self.player) {
        // 监听当前的播放进度
        __weak typeof(self)weakSelf = self;
        self.progressObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            CGFloat duationTime = CMTimeGetSeconds(weakSelf.playerItem.duration);
            
            CGFloat currentTime = CMTimeGetSeconds(time);
            if (currentTime < 0 ) {
                currentTime = 0;
            }else if (duationTime < 0){
                duationTime = 0;
            }else if (isnan(duationTime)){
                duationTime = 0;
            }
            NSLog(@"总的时间 :%f",duationTime);
            CGFloat progress = currentTime/duationTime * 1.0;
            if ([weakSelf.DGDelegate respondsToSelector:@selector(DGPlayerCurrentTime:duration:playProgress:)]) {
                [weakSelf.DGDelegate DGPlayerCurrentTime:currentTime duration:duationTime playProgress:progress];
            }
        }];
        // 添加观察者
        [self.player addObserver:self forKeyPath:DGPlayerRate options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
}

#pragma mark - 需要返回和设置的方法
/**
 当前的播放状态，方便用户随时拿到
 
 @return 对应的播放状态
 */
- (DGPlayerStatus)currentPlayeStatus{
    
    return self.innerCurrentPlayStatus;
}
/**
 当前的播放的模型
 
 @return 当前的播放模型
 */
- (DGVideoInfo *)currentMusicInfo{
    
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
 获得当前播放器的总时间
 
 @return 时间
 */
- (CGFloat )durationTime{
    if (self.player == nil) {
        return 0;
    }
    return CMTimeGetSeconds(self.playerItem.duration);
}
/**
 获得播放列表
 
 @return 播放列表
 */
- (NSArray<DGVideoInfo *> *)getPlayList{
    return self.playList;
}
/**
 点击下一个播放
 */
- (void)playNextVideo{
    
    if (self.playList.count == 0) {
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
        NSAssert(self.playList.count != 0, @"你还没有设置播放列表");
        return;
    }
    if (self.innerCurrentMusicInfo.playUrl.length == 0) {
        self.innerCurrentMusicInfo = [self.playList firstObject];
    }
    
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerBufferProgress:)]) {
        [self.DGDelegate DGPlayerBufferProgress:0.0];
    }
    
    NSUInteger nextIndex = [self nextIndex];
    DGVideoInfo *nextMusicInfo = self.playList[nextIndex];
    if (nextMusicInfo.playUrl.length == 0) {return;}
    
    [self removeMyObserver];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:nextMusicInfo.playUrl]];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.videoFrame;
    playerLayer.videoGravity = self.currentVideoGravity;
    [self.needAddLayer addSublayer:playerLayer];
    [self.player play];
    self.innerCurrentMusicInfo = nextMusicInfo;
    [self addMyObserver];
    
    self.innerCurrentPlayStatus = DGPlayerStatusPlay;
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
        [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
    }
}
/**
 播放上一个视频
 */
- (void)playPreviousVideo{
    
    
    if (self.playList.count == 0) {
        self.innerCurrentPlayStatus = DGPlayerStatusStop;
        if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
            [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusStop];
        }
        NSAssert(self.playList.count != 0, @"你还没有设置播放列表");
        return;
    }
    if (self.innerCurrentMusicInfo.playUrl.length == 0) {
        self.innerCurrentMusicInfo = [self.playList firstObject];
    }
    
    if ([self.DGDelegate respondsToSelector:@selector(DGPlayerBufferProgress:)]) {
        [self.DGDelegate DGPlayerBufferProgress:0.0];
    }
    
    NSUInteger previousIndex = [self previousIndex];
    DGVideoInfo *previousMusicInfo = self.playList[previousIndex];
    if (previousMusicInfo.playUrl.length == 0) return;
    
    [self removeMyObserver];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:previousMusicInfo.playUrl]];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.videoFrame;
    playerLayer.videoGravity = self.currentVideoGravity;
    [self.needAddLayer addSublayer:playerLayer];
    [self.player play];
    self.innerCurrentMusicInfo = previousMusicInfo;
    [self addMyObserver];
    
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
            if (self.innerCurrentMusicInfo.playUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            [self.player play];
            self.innerCurrentPlayStatus = DGPlayerStatusPlay;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
            }
            
        }
            break;
        case DGPlayerPlayOperatePause:
        {
            if (self.innerCurrentMusicInfo.playUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            [self.player pause];
            self.innerCurrentPlayStatus = DGPlayerStatusPause;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPause];
            }
        }
            break;
            
        case DGPlayerPlayOperateStop:
        {
            if (self.innerCurrentMusicInfo.playUrl.length == 0 || self.player == nil || self.playList.count == 0) {return;}
            
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
        self.videoFrame = CGRectZero;
        self.needAddLayer = nil;
    }
    [self.playList removeAllObjects];
}
/**
 删除一个播放列表
 
 @param deleteList 要删除的播放列表
 */
- (void)deletePlayList:(NSArray<DGVideoInfo *>*)deleteList{
    
    NSAssert(deleteList.count != 0, @"对不起，删除的数组不能为空");
    if (deleteList.count == 0) {return;}
    
    NSMutableArray *temAttay = [NSMutableArray array];
    __block BOOL isContainCurrentInfo = NO;
    for (NSInteger index = 0; index < deleteList.count; index ++) {
        DGVideoInfo *info = deleteList[index];
        if (info.videoId.length && [info isMemberOfClass:[DGVideoInfo class]]) {
            [self.playList enumerateObjectsUsingBlock:^(DGVideoInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.videoId isEqualToString:info.videoId]) {
                    [temAttay addObject:obj];
                    if ([info.videoId isEqualToString:self.innerCurrentMusicInfo.videoId]) {
                        isContainCurrentInfo = YES;
                    }
                    *stop = YES;
                }
            }];
        }
    }
    NSLog(@"清除的数组个数：%zd",temAttay.count);
    if (temAttay.count == 0) {return;}
    if (isContainCurrentInfo) {
        [self.player pause];
    }
    // 删除数组
    [self.playList removeObjectsInArray:temAttay];
}
/**
 添加一个新的歌单到播放列表
 
 @param addList 新的歌曲的数组
 */
- (void)addPlayList:(NSArray<DGVideoInfo *>*)addList{
    
    NSAssert(addList.count != 0, @"添加的数组不能为空");
    if (addList.count == 0) {return;}
    
    NSMutableArray *temArray = [NSMutableArray array];
    for (NSInteger index = 0; index < addList.count; index ++) {
        DGVideoInfo *info = addList[index];
        if ([info isMemberOfClass:[DGVideoInfo class]]) {
            __block BOOL isFlag = NO;
            [self.playList enumerateObjectsUsingBlock:^(DGVideoInfo  *_Nonnull obj, NSUInteger idx, BOOL * stop) {
                if ([obj.videoId isEqualToString:info.videoId]) {
                    isFlag = YES;
                    *stop = YES;
                }
                
            }];
            if (isFlag == NO) {
                [temArray addObject:info];
            }
        }
    }
    NSLog(@"temArray.count : %zd",temArray.count);
    if (temArray.count == 0) return;
    [self.playList addObjectsFromArray:temArray];
}
/**
 快进或者快退
 
 @param time 要播放的那个时间点
 */
- (void)seekTime:(NSUInteger)time{
    
    NSAssert(self.player != nil, @"q对不起你的播放器已经不存在了");
    if (!self.player) return;
    
    NSAssert(self.playList.count != 0, @"对不起你的当前播放列表为空或者你还没有设置播放列表");
    NSAssert(self.innerCurrentMusicInfo.playUrl.length != 0, @"当前播放歌曲的地址为空");
    
    if (self.playList.count == 0 || self.innerCurrentMusicInfo.playUrl.length == 0) return;
    CGFloat duration = CMTimeGetSeconds(self.playerItem.duration);
    NSAssert(time < duration, @"对不起 你的播放时间大于总时长了");
    if (time > duration) return;
    if (!(self.innerCurrentPlayStatus == DGPlayerStatusPlay || self.innerCurrentPlayStatus == DGPlayerStatusPause)) return;
    
    [self.player seekToTime:CMTimeMake(time, 1.0) completionHandler:^(BOOL finished) {
        if (finished) {
            self.innerCurrentPlayStatus = DGPlayerStatusPlay;
            if ([self.DGDelegate respondsToSelector:@selector(DGPlayerChangeStatus:)]) {
                [self.DGDelegate DGPlayerChangeStatus:DGPlayerStatusPlay];
            }
        }
    }];
}

@end

