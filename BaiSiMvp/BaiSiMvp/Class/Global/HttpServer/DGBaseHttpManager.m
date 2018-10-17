//
//  DGBaseHttpManager.m
//  封装网络请求
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseHttpManager.h"
#define TimeOut 60
#define DGHttpErrorDomain @"com.myCompany.errorDomain"

@interface DGBaseHttpManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSURLSessionDataTask *task;

@end
@implementation DGBaseHttpManager
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = TimeOut;
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    }
    return _sessionManager;
}
/**
 特殊的情况的处理，特殊需要加在头信息中的
 
 @param value 值
 @param key key
 */
- (void)setHttpHeader:(NSString *)value forKey:(NSString *)key{
    if (value.length || key.length) {
        [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
}
/**
 特殊的情况处理，需要移除请求头的
 
 @param key key
 */
- (void)removeHttpHeaderWithKey:(NSString *)key{
    if (key.length) {
        NSMutableDictionary *httpHeaders = (NSMutableDictionary *)self.sessionManager.requestSerializer.HTTPRequestHeaders;
        [httpHeaders removeObjectForKey:key];
    }
}
/**
 停止请求
 */
-(void)stopRequest{
    
    [self.task cancel];
    self.task = nil;
}

/**
 普通的get请求方式
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param complete 完成的回调
 */
- (void)GETWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param complete:(void (^)(DGBaseHttpModel *))complete{
    
    // 开始前处理一些事情
    [self startRequest];
    // 开始请求
    self.task = [self.sessionManager GET:[self configUrl:requsetUrl] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (responseDic) { // 这里只是简单的判断，具体根据项目而定
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = responseDic;
            httpModel.successCode = @"000000";
            httpModel.serverError = nil;
            complete(httpModel);
        }else{
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = nil;
            NSDictionary *errorDic = @{
                                       NSLocalizedFailureReasonErrorKey : @"后台没有数据,一般来说是后台给的错误",
                                       NSLocalizedDescriptionKey : @"参数错误"
                                       };
            httpModel.serverError = [NSError errorWithDomain:DGHttpErrorDomain code:DGBaseErrorType_unknown userInfo:errorDic];
            httpModel.errorType = DGBaseErrorType_unknown;
            complete(httpModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
        httpModel.serverData = nil;
        httpModel.serverError = error;
        httpModel.errorType = DGBaseErrorType_unknown;
        complete(httpModel);
    }];
    [self.task resume];
}
/**
 普通的POST请求方式
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param complete 完成的回调
 */
- (void)POSTWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param complete:(void (^)(DGBaseHttpModel *))complete{
    
    // 开始网络请求之前必要的检查
    [self startRequest];
    //正式开始网络请求
    self.task = [self.sessionManager POST:[self configUrl:requsetUrl] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (responseDic) { // 这里只是简单的判断，具体根据项目而定
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = responseDic;
            httpModel.successCode = @"000000";
            httpModel.serverError = nil;
            complete(httpModel);
        }else{
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = nil;
            NSDictionary *errorDic = @{
                                       NSLocalizedFailureReasonErrorKey : @"后台没有数据,一般来说是后台给的错误",
                                       NSLocalizedDescriptionKey : @"参数错误"
                                       };
            httpModel.serverError = [NSError errorWithDomain:DGHttpErrorDomain code:DGBaseErrorType_unknown userInfo:errorDic];
            httpModel.errorType = DGBaseErrorType_unknown;
            complete(httpModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
        httpModel.serverData = nil;
        httpModel.serverError = error;
        httpModel.errorType = DGBaseErrorType_unknown;
        complete(httpModel);
    }];
    [self.task resume];
}
/**
 带有上传进度的get请求
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param progress 进度（范围是0.0-1.0）
 @param complete 要返沪的数据
 */
-(void)GETWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param progress:(void (^)(CGFloat))progress complete:(void (^)(DGBaseHttpModel *))complete{
    // 请求之前需要处理的事情
    [self startRequest];
    // 开始正式的请求
    self.task = [self.sessionManager GET:[self configUrl:requsetUrl] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat currentProgress = 1.0 *downloadProgress.completedUnitCount /1.0*downloadProgress.totalUnitCount;
        progress(currentProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (responseDic) { // 这里只是简单的判断，具体根据项目而定
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = responseDic;
            httpModel.successCode = @"000000";
            httpModel.serverError = nil;
            complete(httpModel);
        }else{
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = nil;
            NSDictionary *errorDic = @{
                                       NSLocalizedFailureReasonErrorKey : @"后台没有数据,一般来说是后台给的错误",
                                       NSLocalizedDescriptionKey : @"参数错误"
                                       };
            httpModel.serverError = [NSError errorWithDomain:DGHttpErrorDomain code:DGBaseErrorType_unknown userInfo:errorDic];
            httpModel.errorType = DGBaseErrorType_unknown;
            complete(httpModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
        httpModel.serverData = nil;
        httpModel.serverError = error;
        httpModel.errorType = DGBaseErrorType_unknown;
        complete(httpModel);
    }];
    [self.task resume];
}
/**
 带有上传进度的post请求
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param progress 进度（范围是0.0-1.0）
 @param complete 要返沪的数据
 */
-(void)POSTWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param progress:(void (^)(CGFloat))progress complete:(void (^)(DGBaseHttpModel *))complete{
    
    // 请求之前需要处理的事情
    [self startRequest];
    // 开始正式的请求
    self.task = [self.sessionManager POST:[self configUrl:requsetUrl] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat currentProgress = 1.0 *downloadProgress.completedUnitCount /1.0*downloadProgress.totalUnitCount;
        progress(currentProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (responseDic) { // 这里只是简单的判断，具体根据项目而定
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = responseDic;
            httpModel.successCode = @"000000";
            httpModel.serverError = nil;
            complete(httpModel);
        }else{
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = nil;
            NSDictionary *errorDic = @{
                                       NSLocalizedFailureReasonErrorKey : @"后台没有数据,一般来说是后台给的错误",
                                       NSLocalizedDescriptionKey : @"参数错误"
                                       };
            httpModel.serverError = [NSError errorWithDomain:DGHttpErrorDomain code:DGBaseErrorType_unknown userInfo:errorDic];
            httpModel.errorType = DGBaseErrorType_unknown;
            complete(httpModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
        httpModel.serverData = nil;
        httpModel.serverError = error;
        httpModel.errorType = DGBaseErrorType_unknown;
        complete(httpModel);
    }];
    [self.task resume];
}
/**
 文件上传（一般来说做的事图片上传）
 
 @param requsetUrl 请求的url
 @param param 请求的参数
 @param data 将上传的文件转化为data
 @param name 指定的参数名字（必须和服务器保持一致）
 @param fileName 文件的名字（如 haha.png）
 @param mimeType 什么类型（如 image/jpeg）
 @param progress 上传的进度
 @param complete 回掉用信息 （成功还是失败）
 */
-(void)POSTUploadRequestUrl:(NSString *)requsetUrl
                      param:(NSMutableDictionary *)param
                       data:(NSData *)data
                       name:(NSString *)name
                   fileName:(NSString *)fileName
                   mimeType:(NSString *)mimeType
                   progress:(void (^)(CGFloat))progress
                   complete:(void (^)(DGBaseHttpModel *))complete{
    
    NSAssert(name.length > 0, @"name 不能为空");
    NSAssert(data.length > 0, @"data 不能为空");
    NSAssert(fileName.length > 0, @"fileName 不能为空");
    NSAssert(mimeType.length > 0, @"mimeType 不能为空");
    
    // 请求之前的操作
    [self startRequest];
    // 开始正式的请求
    self.task = [self.sessionManager POST:[self configUrl:requsetUrl] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat currentProgress = 1.0 *uploadProgress.completedUnitCount /1.0*uploadProgress.totalUnitCount;
        progress(currentProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (responseDic) { // 这里只是简单的判断，具体根据项目而定
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = responseDic;
            httpModel.successCode = @"000000";
            httpModel.serverError = nil;
            complete(httpModel);
        }else{
            DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
            httpModel.serverData = nil;
            NSDictionary *errorDic = @{
                                       NSLocalizedFailureReasonErrorKey : @"后台没有数据,一般来说是后台给的错误",
                                       NSLocalizedDescriptionKey : @"参数错误"
                                       };
            httpModel.serverError = [NSError errorWithDomain:DGHttpErrorDomain code:DGBaseErrorType_unknown userInfo:errorDic];
            httpModel.errorType = DGBaseErrorType_unknown;
            complete(httpModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DGBaseHttpModel *httpModel = [[DGBaseHttpModel alloc] init];
        httpModel.serverData = nil;
        httpModel.serverError = error;
        httpModel.errorType = DGBaseErrorType_unknown;
        complete(httpModel);
    }];
    [self.task resume];
}


#pragma mark - 其他事情的处理
/**
 开始请求前需要处理的事情
 */
- (void)startRequest{
    [self cancleRequest];
    [self addHeaderMessage];
}
/**
 添加头部的信息、这个一般由后台确定
 */
- (void)addHeaderMessage{
    // 类似于这种
    //[self.sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
}

/**
 取消请求
 */
- (void)cancleRequest{
    
    [self.task cancel];
    self.task = nil;
    // 清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}
/**
 配置url 这里边一般是连上基地址或者是一些通用的参数，如：（ua、version等）

 @param requestUrl 传递的请求的链接
 @return 完成的链接
 */
- (NSString *)configUrl:(NSString *)requestUrl{
    // 具体配置看公司了
    
    return requestUrl;
}




@end
