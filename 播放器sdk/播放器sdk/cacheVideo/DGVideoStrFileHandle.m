//
//  DGVideoStrFileHandle.m
//  播放器sdk
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGVideoStrFileHandle.h"
#import <CommonCrypto/CommonDigest.h>

#define DGMyTempPath [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp/MediaCache"] stringByAppendingPathComponent:@"videoTemp.mp4"]
#define DGMyCacheFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videoCache"]

@implementation DGVideoStrFileHandle
/**
 传递一个字符串转换为一个不是我们的Schemeurl
 
 @param str 传递的字符串
 @return 我们想要的scheme
 */
+ (NSURL *)customSchemeUrl:(NSString *)str{
    
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:str] resolvingAgainstBaseURL:NO];
    components.scheme = @"streaming";
    return [components URL];
}
/**
 返回我们原始的url的scheme
 
 @param url 哪一个字符串
 @return 我们原始的url
 */
+ (NSURL *)originalUrl:(NSURL *)url{
    
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme = @"http";
    return [components URL];
    
}
#pragma mark - 文件相关
/**
 通过一个偏移量来读取临时文件的数据
 
 @param offset offset
 @param length 长度
 @return 数据
 */
+ (NSData *)readTempFileDataWithOffset:(NSUInteger )offset length:(NSUInteger)length{
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:DGMyTempPath];
    if (fileHandle == nil) {
        return nil;
    }
    [fileHandle seekToFileOffset:offset];
    NSData *data = [fileHandle readDataOfLength:length];
    NSLog(@"读到的数据是什么？%@",data);
    return data;
}
/**
 往临时文件中写入数据
 
 @param data data
 */
+ (void)writeTempFileData:(NSData *)data{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:DGMyTempPath]) {
        [[NSFileManager defaultManager] createFileAtPath:DGMyTempPath contents:data attributes:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:DGMyTempPath];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:data];
}
/**
 存储缓存文件的数据
 
 @param str 缓存的名字
 */
+ (void)cacheTempFileData:(NSString *)str{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL directory = NO;
    [manager fileExistsAtPath:DGMyCacheFile isDirectory:&directory];
    if (directory == NO) {
        [manager createDirectoryAtPath:DGMyCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    str = [DGVideoStrFileHandle changeStrToMd5:str];
    str = [NSString stringWithFormat:@"%@.mp4",str];
    NSString *cacheFileName = [NSString stringWithFormat:@"%@/%@",DGMyCacheFile,str];
    [manager copyItemAtPath:DGMyTempPath toPath:cacheFileName error:nil];
    if ([manager fileExistsAtPath:DGMyTempPath]) {
        [manager removeItemAtPath:DGMyTempPath error:nil];
    }
}
/**
 删除临时文件
 */
+ (void)deleteTempFile{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:DGMyTempPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:DGMyTempPath error:nil];
    }
}
/**
 判断缓存文件是否存在
 
 @param linkStr 开始请求的链接
 @return 是否存在
 */
+ (BOOL)myCacheFileIsExist:(NSString *)linkStr{
    
    NSURL *customUrl = [self customSchemeUrl:linkStr];
    NSString *str = customUrl.absoluteString;
    NSFileManager *manager = [NSFileManager defaultManager];
    str = [DGVideoStrFileHandle changeStrToMd5:str];
    str = [NSString stringWithFormat:@"%@.mp4",str];
    NSString *cacheFileName = [NSString stringWithFormat:@"%@/%@",DGMyCacheFile,str];
    if ([manager fileExistsAtPath:cacheFileName]) {
        return YES;
    }
    return NO;
}
/**
 获得我的缓存的文件
 
 @param linkStr 下载的链接
 @return 文件的位置
 */
+ (NSString *)getMyCacheFile:(NSString *)linkStr{
    NSURL *customUrl = [self customSchemeUrl:linkStr];
    NSString *str = customUrl.absoluteString;
    str = [DGVideoStrFileHandle changeStrToMd5:str];
    str = [NSString stringWithFormat:@"%@.mp4",str];
    NSString *cacheFileName = [NSString stringWithFormat:@"%@/%@",DGMyCacheFile,str];
    return cacheFileName;
}
/**
 装换为md5
 
 @return 转化为md5字符串
 */
+ (NSString *)changeStrToMd5:(NSString *)changeStr
{
    NSData *data = [changeStr dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    NSString *fmt = @"%02x%02x%02x%02x"
    @"%02x%02x%02x%02x"
    @"%02x%02x%02x%02x"
    @"%02x%02x%02x%02x";
    
    return [[NSString alloc] initWithFormat:fmt,
            result[ 0], result[ 1], result[ 2], result[ 3],
            result[ 4], result[ 5], result[ 6], result[ 7],
            result[ 8], result[ 9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
@end
