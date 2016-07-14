//
//  ZhengPinViewController.h
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNSegmentedControl.h>
@interface ZhengPinViewController : UIViewController<DZNSegmentedControlDelegate,UIWebViewDelegate>



@property (nonatomic,strong)DZNSegmentedControl * control;

@property (nonatomic,copy)NSString * firstUrL;
@property (nonatomic,copy)NSString * secondUrl;
@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UIWebView * WebView;

@property (nonatomic,strong) UIActivityIndicatorView *TestActivityIndicator;


@property (nonatomic,copy)NSString * requestUrl;

//当前访问的URL
@property (nonatomic,copy)NSString * NewUrl;



@end
