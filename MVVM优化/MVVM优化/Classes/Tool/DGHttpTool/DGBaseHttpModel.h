//
//  DGBaseHttpModel.h
//  封装网络请求
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,DGBaseErrorType) {
    
    DGBaseErrorType_unknown = 0,
    DGBaseErrorType_404     = 1,
    DGBaseErrorType_500     = 2
    
};
@interface DGBaseHttpModel : NSObject
/**
 后台返回的错误信息
 */
@property (strong, nonatomic) NSError *serverError;
/**
 错误的类型
 */
@property (assign, nonatomic) DGBaseErrorType errorType;
/**
 服务器返回的成功数据
 */
@property (strong, nonatomic) NSDictionary *serverData;
/**
 成功的返回码
 */
@property (copy, nonatomic) NSString *successCode;



@end
