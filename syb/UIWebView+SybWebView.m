//
//  UIWebView+SybWebView.m
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "UIWebView+SybWebView.h"

@implementation UIWebView (SybWebView)


- (NSString *)documentTitle
{
   	return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}


- (void)fixViewPort
{
    //适应客户端页面
    NSString* js =
    @"var meta = document.createElement('meta'); "
    "meta.setAttribute( 'name', 'viewport' ); "
    "meta.setAttribute( 'content', 'width = device-width' ); "
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    
    [self stringByEvaluatingJavaScriptFromString: js];
}

- (void)cleanBackground
{
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in [[[self subviews] safeObjectAtIndex:0] subviews])
    {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}

@end
