//
//  DGBaseHttpManager.h
//  封装网络请求
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGBaseHttpModel.h"
#import <AFNetworking/AFNetworking.h>



@interface DGBaseHttpManager : NSObject
#pragma mark - 一般的方法 几乎用不上的
/**
 特殊的情况的处理，特殊需要加在头信息中的

 @param value 值
 @param key key
 */
- (void)setHttpHeader:(NSString *)value forKey:(NSString *)key;

/**
 特殊的情况处理，需要移除请求头的

 @param key key
 */
- (void)removeHttpHeaderWithKey:(NSString *)key;
/**
 停止请求
 */
-(void)stopRequest;

#pragma mark - 常规的请求方法的响应方法的响应
/**
 普通的get请求方式

 @param requsetUrl 请求的链接
 @param param 参数
 @param complete 完成的回调
 */
- (void)GETWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param complete:(void (^)(DGBaseHttpModel *baseModel))complete;
/**
 普通的POST请求方式
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param complete 完成的回调
 */
- (void)POSTWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param complete:(void (^)(DGBaseHttpModel *baseModel))complete;

/**
 带有上传进度的get请求

 @param requsetUrl 请求的链接
 @param param 参数
 @param progress 进度（范围是0.0-1.0）
 @param complete 要返沪的数据
 */
- (void)GETWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param progress:(void(^)(CGFloat progress))progress complete:(void (^)(DGBaseHttpModel *baseModel))complete;
/**
 带有上传进度的post请求
 
 @param requsetUrl 请求的链接
 @param param 参数
 @param progress 进度（范围是0.0-1.0）
 @param complete 要返沪的数据
 */
- (void)POSTWithRequestUrl:(NSString *)requsetUrl param:(NSMutableDictionary *)param progress:(void(^)(CGFloat progress))progress complete:(void (^)(DGBaseHttpModel *baseModel))complete;

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
- (void)POSTUploadRequestUrl:(NSString *)requsetUrl
                     param:(NSMutableDictionary *)param
                      data:(NSData *)data
                      name:(NSString *)name
                  fileName:(NSString *)fileName
                  mimeType:(NSString *)mimeType
                  progress:(void(^)(CGFloat progress))progress
                  complete:(void (^)(DGBaseHttpModel *baseModel))complete;













@end
