//
//  weakScriptMessage.m
//  WKWebView的练习
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "weakScriptMessage.h"

@implementation weakScriptMessage

-(instancetype)initWithTarget:(id<WKScriptMessageHandler>)target{
    if (self = [super init]) {
        self.target = target;
    }
    return self;

}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    [self.target userContentController:userContentController didReceiveScriptMessage:message];
}

@end
