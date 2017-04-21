//
//  HHOAuthVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/6.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHOAuthVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HHAccountTool.h"
#import "HHHtttpTool.h"

@interface HHOAuthVC ()<UIWebViewDelegate>

@end

@implementation HHOAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",HHAppKey,HHRedirectURL];
//    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3846952897&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

#pragma mark ------请求------
- (void)accessTokenWithCode:(NSString *)code{
    NSMutableDictionary *params        = [NSMutableDictionary dictionary];
    params[@"client_id"]               = HHAppKey;
    params[@"client_secret"]           = HHAppSecret;
    params[@"grant_type"]              = @"authorization_code";
    params[@"redirect_uri"]            = HHRedirectURL;
    params[@"code"]                    = code;

    
    [HHHtttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json){
        [MBProgressHUD hideHUD];
        
        //存储账号信息
        HHAccount *account = [HHAccount accountWithDict:json];
        [HHAccountTool saveAccount:account];
        
        // 切换窗口的控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSError *error){
        [MBProgressHUD hideHUD];
    }];


}


@end
