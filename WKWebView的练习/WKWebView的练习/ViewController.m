//
//  ViewController.m
//  WKWebView的练习
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"
#import "weakScriptMessage.h"

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 方法一使用 加载网页
//    [self loadHTML];
    // js调用oc的方法
    [self jsCorrespondoc];
    
    
}

/**
 通信 也就是oc注册方法 js进行调用
 */
- (void)jsCorrespondoc{
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.frame];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [self.view addSubview:web];
    self.webview = web;
    
    /******************** 这两个方法我都没有验证*****************************/
    // oc 注册方法 方法1自己写的 我觉得比较好
    [self.webview.configuration.userContentController addScriptMessageHandler:[WeakScriptMessageDelegate initWithTargetL:self] name:@"deleteName"];
    // 方法二 网上看的 应该也不错
    [self.webview.configuration.userContentController addScriptMessageHandler:[[weakScriptMessage alloc] initWithTarget:self] name:@"deleteName"];
    
    
    
    
    
}

/**
  用法1
  加载网页  这里面就是百度
 */
-(void)loadHTML{
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.frame];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [self.view addSubview:web];
    
}
#pragma mark  - WKScriptMessageHandler的代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    
    
}


#pragma mark navigationDelegate
/**
 开始加载的时候调用

 @param webView webview
 @param navigation navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"开始加载的时候调用");
}

/**
 加载完成时候调用

 @param webView webview
 @param navigation 导航栏
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"加载完成时调用");
    
}

/**
 加载出错的时候调用

 @param webView webview
 @param navigation 导航栏
 @param error 错误信息
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"出错了:%@",error);
}

/**
 当内容开始返回时调用

 @param webView webview
 @param navigation 导航栏
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"当内容开始返回时调用");
    
}
/**
  接收到服务器跳转请求之后调用

 @param webView webview
 @param navigation 导航栏
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"接收到服务器跳转请求之后调用");
    
    
}

/**
 在收到响应后决定是否跳转

 @param webView webview
 @param navigationResponse 响应
 @param decisionHandler 是否可以允许跳转的block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"在收到响应后决定是否跳转");
    if (decisionHandler) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

/**
 在发送请求之前决定是否跳转

 @param webView webview
 @param navigationAction 导航栏
 @param decisionHandler  是否可以允许跳转的block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"在发送请求之前决定是否跳转");
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

#pragma mark - WKUIDelegate

/**
 当前webView中有弹框出现的时候开始调用（比如警告、确认框、输入框等等）

 @param webView webview
 @param message 消息
 @param frame 尺寸
 @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"webview中开始出现弹出框了:%@",message);
    
    if (completionHandler) {
        completionHandler();
    }
    
}
-(void)dealloc{
    
    [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"deleteName"];
}

@end
