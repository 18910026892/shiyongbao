//
//  ZhengPinViewController.m
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPinViewController.h"

@implementation ZhengPinViewController
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self PageSetup];
    [self.navigationController.navigationBar addSubview:self.backButton];

    [MobClick beginLogPageView:@"正品"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];

    [MobClick endLogPageView:@"正品"];
    
    
}
-(UIButton*)backButton
{
    if (!_backButton) {
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 44, 44);
        [_backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
    
}
-(void)backButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
    btn.userInteractionEnabled = NO;
    
    

    if (self.WebView.canGoBack) {
        
        
        if ([_NewUrl isEqualToString:_firstUrL]||[_NewUrl isEqualToString:_secondUrl]) {
            NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
        }else
        {
            [self.WebView goBack];
            btn.userInteractionEnabled = YES;
        }
        
       
        
    }else
    {
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
    }
 
}

//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
}
- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = NO;
        _control.height = 40.0f;
        _control.frame = CGRectMake(20, 64, SCREEN_WIDTH-40, 40);
        _control.showsGroupingSeparators = NO;
        _control.backgroundColor = [UIColor clearColor];
        _control.tintColor = ThemeColor;
        _control.showsCount = NO;
        _control.selectionIndicatorHeight = 1;
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

-(UIWebView*)WebView
{
    if (!_WebView) {
        _WebView = [[UIWebView alloc]init];
        _WebView.frame = CGRectMake(0, 104.5, SCREEN_WIDTH, SCREEN_HEIGHT-104.5);
        _WebView.delegate = self;
        _WebView.backgroundColor = [UIColor clearColor];
        _WebView.delegate = self;
        _WebView.opaque  = NO;
        _WebView.scalesPageToFit = YES;
        _WebView.autoresizesSubviews = YES;
        [_WebView addSubview:self.TestActivityIndicator];
    }
    
    return _WebView;
}
-(UIActivityIndicatorView*)TestActivityIndicator
{
    if (!_TestActivityIndicator) {
       _TestActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _TestActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2-64);//只能设置中心，不能设置大小
        _TestActivityIndicator.color = ThemeColor;
        [_TestActivityIndicator setHidesWhenStopped:YES];
        [_TestActivityIndicator startAnimating];
}
    return _TestActivityIndicator;
}
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title =@"正品检测认证";
    _menuItems = @[@"直播中",@"报告"];
    [self.view addSubview:self.control];
    [self.view addSubview:self.WebView];

 
     _requestUrl = [_firstUrL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
    NSURL * url = [NSURL URLWithString:_requestUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
  
    [self.WebView loadRequest:request];
    
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    
   NSInteger index = control.selectedSegmentIndex;
    

    _requestUrl = [_firstUrL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    
    if (index==0) {
         _requestUrl = [_firstUrL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else if(index==1)
    {
         _requestUrl = [_secondUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    NSURL * url = [NSURL URLWithString: _requestUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [self.WebView loadRequest:request];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [self.TestActivityIndicator stopAnimating];
   
    _NewUrl = self.WebView.request.URL.absoluteString;
    
    NSLog(@"***%@",_NewUrl);
    
    NSString *  doctitle = [self.WebView documentTitle];
 
    self.title = doctitle;
    
    if ([doctitle isEqualToString:@"404 Not Found"]) {
        
        self.WebView.hidden = YES;
        [HDHud showMessageInView:self.view title:@"亲，该商城的简介跑火星去了..."];
        self.title = @"正品检测认证";
    }
    
    
}

@end
