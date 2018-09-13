//
//  weakScriptMessage.h
//  WKWebView的练习
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface weakScriptMessage : NSObject <WKScriptMessageHandler>

@property (weak, nonatomic) id <WKScriptMessageHandler>target;

-(instancetype)initWithTarget:(id<WKScriptMessageHandler>)target;

@end
