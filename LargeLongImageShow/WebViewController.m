//
//  WebViewController.m
//  LargeLongImageShow
//
//  Created by huangjian on 2019/10/14.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
}
-(void)setUrl:(NSString *)url{
    _url = url;
    if (url) {
        if ([url containsString:@"<html>"]) {
            [self.webView loadHTMLString:url baseURL:nil]; //加载html
        }else{
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }
    }
}

- (WKWebView *)webView
{
    if(_webView == nil)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;

    }
    return _webView;
}

@end
