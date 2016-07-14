//
//  UIWebView+SybWebView.h
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SybWebView)

- (NSString *)documentTitle;
- (void)fixViewPort;    //网页content自适应
- (void)cleanBackground;    //清除默认的背景高光

@end
