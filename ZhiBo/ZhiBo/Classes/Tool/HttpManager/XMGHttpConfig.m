//
//  XMGHttpConfig.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/30.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpConfig.h"

/** ua*/
NSString * const XMG_UA = @"ua";
/** version*/
NSString * const XMG_VERSION = @"version";
/** 成功的code*/
NSString * const XMG_SUCCESSCODE = @"00000";
/** 重新登录*/
NSInteger const XMG_ERRORCODE500 = 500;
/** 服务器错误*/
NSInteger const XMG_ERRORCODE404 = 404;
/** 服务器错误,服务器没有给数据 自己定义的 */
NSInteger const XMG_ERRORCODE600 = 600;
/** 超时时间*/
NSInteger const XMG_TimeOut = 60;
