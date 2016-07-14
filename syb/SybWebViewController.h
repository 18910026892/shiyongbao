//
//  SybWebViewController.h
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface SybWebViewController : BaseViewController
<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
}

@property(nonatomic,strong)UIButton * BackButton;

@property(nonatomic,strong)UIWebView * WebView;

@property(nonatomic,copy)NSString *  RequestUlr;

@property(nonatomic,copy)NSString * WebTitle;
@end
