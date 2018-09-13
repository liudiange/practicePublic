//
//  WeakScriptMessageDelegate.m
//  WKWebView的练习
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate

+(instancetype)initWithTargetL:(id<WKScriptMessageHandler>)target{
    
    WeakScriptMessageDelegate *poxry = [WeakScriptMessageDelegate alloc];
    poxry.weakDelegate = target;
    return poxry;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    return [self.weakDelegate methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    
    [invocation invokeWithTarget:self.weakDelegate];
}


@end
