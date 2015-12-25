//
//  OAuthViewController.m
//  my-weibo
//
//  Created by qyt on 11/23/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "OAuthAccount.h"
#import "OAuthAccountTool.h"
#import "WBRootViewController.h"

@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getToken];
}

- (void)getToken {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:
                        CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=381032163&redirect_uri=https://www.tmall.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    
    [self.view addSubview:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length) {
        long loc = range.location + range.length;
        NSString *code = [url substringFromIndex:loc];
        [self accessTokenWithCode:code];
    }
    
    return true;
}

- (void)accessTokenWithCode:(NSString *)code {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"client_id": @"381032163",
                                 @"client_secret": @"894fd3957456cbf9e734938c187d97fe",
                                 @"grant_type": @"authorization_code",
                                 @"code": code,
                                 @"redirect_uri": @"https://www.tmall.com"};
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        OAuthAccount *account = [OAuthAccount accoutWithDict:responseObject];
        [OAuthAccountTool saveAccount:account];
        
        self.view.window.rootViewController = [[WBRootViewController alloc] init];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
