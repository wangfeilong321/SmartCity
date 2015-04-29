//
//  SCPayWebViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/17.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCPayWebViewController.h"

@interface SCPayWebViewController ()
{
    NSURLRequest        *_currentRequest;
}

@end

@implementation SCPayWebViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 20;
    
    if (self.navigationController) {
        
        height = height - 44;
    }
    
    CGRect frame = self.view.bounds;
    
    frame.size.height = height;
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    
    _webView.delegate = self;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    [self.view addSubview:_webView];
    
    [_webView loadHTMLString:_htmlString baseURL:nil];
//    [_webView loadRequest:_currentRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequest:(NSURLRequest *)request {
    
    _currentRequest = request;
    
    [_webView loadRequest:request];
}

- (void)loadHTMLString:(NSString *)htmlString {
    _htmlString = htmlString;
    [_webView loadHTMLString:htmlString baseURL:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
}
@end
