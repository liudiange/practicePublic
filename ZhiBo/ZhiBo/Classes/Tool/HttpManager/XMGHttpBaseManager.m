//
//  XMGHttpBaseManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/31.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpBaseManager.h"
#import "XMGHttpConfig.h"

@implementation XMGHttpBaseManager
#pragma mark - lazy
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        __weak typeof(self)weakSelf = self;
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = weakSelf.timeout;
        if (weakSelf.timeout == 0) {
           _manager.requestSerializer.timeoutInterval = XMG_TimeOut;
        }
        _manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    }
    return _manager;
}
#pragma mark - 基本事件的响应
/**
 开始请求网络
 
 @param complete 成功或者失败的block
 */
- (void)startRequest:(void (^)(NSError * _Null_unspecified error))complete {
     __weak typeof(self)weakSelf = self;
    if (self.requestUrl.length == 0 || self.requestMethod.length == 0) return;
    // 请求开始需要做一些操作
    [self startOption];
    if(self.fileData.length > 0){ // 上传的文件不为空，
        [weakSelf.manager POST:[self configUrl:self.requestUrl] parameters:self.paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [formData appendPartWithFileData:strongSelf.fileData name:strongSelf.name fileName:strongSelf.fileName mimeType:strongSelf.mimeType];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            CGFloat progress = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
            strongSelf.progress = progress;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailSuccess:responseObject complete:complete];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailError:error complete:complete];
        }];
    }else if ([[self.requestMethod uppercaseString] isEqualToString:@"GET"]) { // GET 请求
        
       self.task = [weakSelf.manager GET:[self configUrl:self.requestUrl] parameters:self.paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            CGFloat progress = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
            strongSelf.progress = progress;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailSuccess:responseObject complete:complete];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailError:error complete:complete];
        }];
    }else if ([[self.requestMethod uppercaseString] isEqualToString:@"POST"]){// POST 请求
        
        self.task = [weakSelf.manager POST:[self configUrl:self.requestUrl] parameters:self.paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
             __strong typeof(weakSelf)strongSelf = weakSelf;
            CGFloat progress = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
            strongSelf.progress = progress;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailSuccess:responseObject complete:complete];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf detailError:error complete:complete];
        }];
    }
    [self.task resume];
}
/**
 取消任务
 */
- (void)cancleTask {
    [self.task cancel];
    self.task = nil;
}
/**
 暂停任务
 */
- (void)suspendTask {
    [self.task suspend];
}
/**
 特殊的接口需要加上特别的header处理
 
 @param value 值
 @param header 键
 */
- (void)setHttpValue:(NSString * __nonnull)value forHeader:(NSString * __nonnull)header {
    [self.manager.requestSerializer setValue:value forHTTPHeaderField:header];
}
/**
 特殊的接口删除特别的header
 
 @param header 键
 */
- (void)removeHttpheader:(NSString * __nonnull)header{
    [(NSMutableDictionary *)self.manager.requestSerializer.HTTPRequestHeaders removeObjectForKey:header];
}
#pragma mark - 其他事件的响应
/**
 成功的操作其中也有错误的处理

 @param responseObject 后台丢给的数据
 @param complete 回调的block
 */
- (void)detailSuccess:(NSData *)responseObject complete:(void (^)(NSError *_Null_unspecified error))complete {
     __weak typeof(self)weakSelf = self;
    if (responseObject.length) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (dic) {
           [weakSelf parseData:dic complete:complete];
        }else{
            NSError *errorM = [NSError errorWithDomain:@"服务器没有给我们数据" code:XMG_ERRORCODE600 userInfo:nil];
            complete(errorM);
        }
    }else{
        NSError *errorM = [NSError errorWithDomain:@"服务器没有给我们数据" code:XMG_ERRORCODE600 userInfo:nil];
        complete(errorM);
    }
}
/**
 解析数据 防止空实现报错

 @param responseDic 服务器给的数据
 */
- (void)parseData:(NSDictionary * __nonnull)responseDic complete:(void (^)(NSError *_Null_unspecified error))complete{}
/**
 错误的处理

 @param errorS 系统返回的错误
 @param complete 回去调用的block
 */
- (void)detailError:(NSError *)errorS complete:(void (^)(NSError * _Null_unspecified error))complete {
    // 这里还要做一些特殊的判断，一遍遍为了更加友好的提示
    NSError *errorMe = errorS;
    switch (errorS.code) {
        case 404:
        {
            errorMe = [NSError errorWithDomain:@"网络链接出错了，可能是你的地址不对" code:XMG_ERRORCODE404 userInfo:nil];
            
        }
            break;
        case 500:
        {
            errorMe = [NSError errorWithDomain:@"后台代码出错了" code:XMG_ERRORCODE500 userInfo:nil];
            
        }
            break;
            
        default:
            break;
    }
    complete(errorMe);
}
/**
 配置url
 
 @param path 给的路径
 */
- (NSString *)configUrl:(NSString *)path {
    /*
     正常的配置
     
     NSString *str = @"http://218.200.160.29/rdp2/test/mac/";
     path = [str stringByAppendingString:path];
     NSString *versionStr = [NSString stringWithFormat:@"ua=%@&version=%@",XMG_UA,XMG_VERSION];
     path = [path stringByAppendingString:versionStr];
     */
    return path;
}
/**
 开始的相关的操作
 */
- (void)startOption {
    [self cancelRequest];
    [self addHeadOpention];
}
/**
 取消任务操作
 */
- (void)cancelRequest {
    // 取消任务
    [self.task cancel];
    self.task = nil;
    // 清除网络的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/**
 添加头部的操作
 */
- (void)addHeadOpention {
    //    [AFHTTPSessionManager.manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    
}



@end
