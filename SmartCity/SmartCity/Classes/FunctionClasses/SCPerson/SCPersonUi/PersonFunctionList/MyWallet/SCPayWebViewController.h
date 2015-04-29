//
//  SCPayWebViewController.h
//  SmartCity
//
//  Created by fortsven on 15/4/17.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBaseViewController.h"

@interface SCPayWebViewController : SCBaseViewController<UIWebViewDelegate>
{

    UIWebView               *_webView;
}
@property (nonatomic, retain)NSString *htmlString;

- (void)loadRequest:(NSURLRequest *)request;


- (void)loadHTMLString:(NSString *)htmlString;
@end
