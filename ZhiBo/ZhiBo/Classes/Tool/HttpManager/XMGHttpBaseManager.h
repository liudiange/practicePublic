//
//  XMGHttpBaseManager.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/31.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface XMGHttpBaseManager : NSObject

/** 请求的管理者*/
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 请求的任务*/
@property (nonatomic, strong) NSURLSessionDataTask *task;
/** 请求的url*/
@property (copy, nonatomic) NSString *requestUrl;
/** 请求的参数*/
@property (nonatomic, strong) NSMutableDictionary *paramDic;
/** 请求的方法*/
@property (copy, nonatomic) NSString *requestMethod;
/** 请求的下载的进度／上传的进度*/
@property (assign, nonatomic) CGFloat progress;
/** 超时时间*/
@property (nonatomic, assign) NSInteger timeout;
//***************上传相关的操作，如果不是上传这些没有必要填写**********************//
/** 文件名字*/
@property (copy, nonatomic,nonnull) NSString *fileName;
/** mimeType*/
@property (copy, nonatomic,nonnull) NSString *mimeType;
/** 名字*/
@property (copy, nonatomic) NSString *_Nonnull name;
/** 文件数据*/
@property (nonatomic, strong) NSData *__nonnull fileData;
//***************上传相关的操作，如果不是上传这些没有必要填写**********************//

#pragma mark - 基本的方法的响应
/**
 开始请求网络

 @param complete 成功或者失败的block
 */
- (void)startRequest:(void (^)(NSError * _Null_unspecified error))complete;
/**
 要解析的数据

 @param responseDic 要解析的字典
 @param complete 回调的blocl
 */
- (void)parseData:(NSDictionary * __nonnull)responseDic complete:(void (^)(NSError *_Null_unspecified error))complete;
/**
 取消任务
 */
- (void)cancleTask;
/**
 暂停任务
 */
- (void)suspendTask;
/**
 特殊的接口需要加上特别的header处理

 @param value 值
 @param header 键
 */
- (void)setHttpValue:(NSString * __nonnull)value forHeader:(NSString * __nonnull)header;
/**
 特殊的接口删除特别的header
 
 @param header 键
 */
- (void)removeHttpheader:(NSString * __nonnull)header;







@end
