//
//  WebViewController.m
//  syb
//
//  Created by GX on 15/10/30.
//  Copyright © 2015年 GX. All rights reserved.
//
/* The default blue tint color of iOS 7.0 */



/* Methods related to tracking load progress of current page */
#define NavBarFrame self.navigationController.navigationBar.frame


#import "WebViewController.h"

@implementation WebViewController


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
    [self initNavigaitonButtons];
    [MobClick beginLogPageView:_webTitle];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [WebView cleanForDealloc];
    [TitleLabel removeFromSuperview];
    [backButton removeFromSuperview];
    [closeButton removeFromSuperview];
    [reloadButton removeFromSuperview];
    [MobClick endLogPageView:_webTitle];
    
}
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
   
}
-(void)initNavigaitonButtons
{
   
    
    if (!TitleLabel) {
        TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 0, SCREEN_WIDTH-176, 44)];
        TitleLabel.textColor = [UIColor blackColor];
        TitleLabel.font = [UIFont boldSystemFontOfSize:16];
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.backgroundColor = [UIColor clearColor];
        TitleLabel.text = _webTitle;
        TitleLabel.hidden = NO;
    }
    
    
    if (!backButton) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!closeButton) {
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(SCREEN_WIDTH-88, 0, 44, 44);
        [closeButton setImage:[UIImage imageNamed:@"webbtn1"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!reloadButton) {
        reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadButton.frame = CGRectMake(SCREEN_WIDTH-44, 0, 44, 44);
        [reloadButton setImage:[UIImage imageNamed:@"webbtn2"] forState:UIControlStateNormal];
        [reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    [self.navigationController.navigationBar addSubview:TitleLabel];
    [self.navigationController.navigationBar addSubview:backButton];
    [self.navigationController.navigationBar addSubview:closeButton];
    [self.navigationController.navigationBar addSubview:reloadButton];
    

    
}
-(void)backButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
    btn.userInteractionEnabled = NO;
  
    if (WebView.canGoBack&&WebView&&!_aiTaoBao) {
  
        [WebView goBack];
         btn.userInteractionEnabled = YES;
        
    }else if (WebView.canGoBack&&WebView&&_aiTaoBao)
    {
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
        if (index>0) {
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
        }else
            
        {
            NSLog(@"无法返回");
        }
        btn.userInteractionEnabled = YES;
        
    }else if(!WebView.canGoBack&&WebView)
    {
        NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
        if (index>0) {
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
        }else
            
        {
            NSLog(@"无法返回");
        }
          btn.userInteractionEnabled = YES;
        
    }else
        
    {
        NSLog(@"123");
          btn.userInteractionEnabled = YES;
    }
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    _isAlipay = NO;
    _isTmall = NO;
    _shiyongshuoShow = NO;
     _smallWebShow = NO;
    _isdaiweiquanShow = NO;
    _count = 0;
    self.isHidden = NO; 
    _aiTaoBao = NO;
    [self getRuleArrayData];
    [self getCommitUrlRegular];
    if ([_requestURL isEmpty]||[_requestURL isEqualToString:@"<null>"]||[_requestURL isEqual:[NSNull null]]) {

        [HDHud showMessageInView:self.view title:@"该页面无法访问..."];
        
    }else
    {
        [self initWebView];
        [self initLoadView];
        [self initBottomButton];
        [self InitShiYongShuoButton];
        
    }
    
}
-(void)initLoadView
{
    if (!TestActivityIndicator) {
        TestActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        TestActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2-64);//只能设置中心，不能设置大小
        TestActivityIndicator.color = ThemeColor;
        [TestActivityIndicator setHidesWhenStopped:YES];
        [TestActivityIndicator startAnimating];
        [WebView addSubview:TestActivityIndicator];
    }
    
}

#pragma mark - NJKWebViewProgressDelegate

-(void)initWebView
{
  
    
    if(!WebView)
    {
        WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        WebView.backgroundColor = [UIColor clearColor];
        WebView.delegate = self;
        WebView.scrollView.delegate = self;
        WebView.opaque  = NO;
        WebView.tag = 1;
        WebView.scalesPageToFit = YES;
        WebView.autoresizesSubviews = YES;
    
        NSURL * url = [NSURL URLWithString:_requestURL];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.view addSubview:WebView];
        [WebView loadRequest:request];
     
    }

    
}



-(void)initBottomButton
{
    if (!bottomButton&&[_DaiWeiQuan length]>0) {
        
        bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40);
        bottomButton.backgroundColor = RGBACOLOR(16, 16, 16, .8);
        
        NSString * bottomTitle;
        NSString * bottomImage;
        bottomTitle = @"代 维 权";
        bottomImage = @"daiweiquan";
        UIImageView * bottomButtomImage = [[UIImageView alloc]init];
        bottomButtomImage.image = [UIImage imageNamed:bottomImage];

       
        bottomButtomImage.frame = CGRectMake(SCREEN_WIDTH*7/24, 8, 24, 24);
        bottomButtomImage.userInteractionEnabled = YES;
        [bottomButton addSubview:bottomButtomImage];
        
        [bottomButton setTitle:bottomTitle forState:UIControlStateNormal];
        [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        bottomButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomButton];
        
    }else
    {
        NSLog(@"不用添加底部导航栏");
    }
}
-(void)refreshBottomBar
{
    if (![_DaiWeiQuan isEmpty]&&!WebView.canGoBack&&bottomButton) {
        
        bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
        WebView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        
    }else 
        
    {
        bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40);
        WebView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        
    }
}

-(void)bottomButtonClick:(UIButton*)sender
{
    
    if ([_DaiWeiQuan isEqualToString:@"daiweiquan"]) {
        
        [self getDaiweiquan];
        
    }
    
    
}
-(void)getDaiweiquan
{
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_SysHtmlInfo pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        
        NSArray * urlArray = [obj valueForKey:@"result"];
        NSLog(@"^^%@",urlArray);
        for (NSDictionary * dict in urlArray) {
            NSString * key = @"url_key";
            if ([[dict valueForKey:key] isEqualToString:@"_daiweiquan"]) {
                _daiweiquanURL = [dict valueForKey:@"url_link"];
            }
        }
        
        
        if (![_daiweiquanURL isEmpty]) {
            [self initdaiweiquanView];
        }
        
        
    };
    request.failureGetData = ^(void){
        
        
    };
}
-(void)initdaiweiquanView
{
    
    if (!CustomPopView) {
        CustomPopView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        CustomPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        CustomPopView.userInteractionEnabled = YES;
    }
    
    if (!HeaderView) {
        HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 350)];
        HeaderView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TappedCancel)];
        [HeaderView addGestureRecognizer:tapGesture];
    }
    
    
    if (!WEBView) {
        WEBView = [[UIWebView alloc]init];
        WEBView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH,350);
        WEBView.scalesPageToFit = NO;
        WEBView.delegate = self;
        WEBView.backgroundColor = [UIColor clearColor];
        WEBView.scrollView.bounces = NO;
        NSURL * requestURL = [NSURL URLWithString:_daiweiquanURL];
        NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
        [WEBView loadRequest:request];
    }
    
    
    if (!CancleBtn) {
        //取消按钮
        CancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CancleBtn.frame = CGRectMake(SCREEN_WIDTH-40, -15, 30, 30);
        CancleBtn.layer.masksToBounds = YES;
        CancleBtn.layer.cornerRadius = 15;
        UIImage * btnimg = [UIImage imageNamed:@"webcancle"];
        [CancleBtn setImage:btnimg forState:UIControlStateNormal];
        [CancleBtn addTarget:self action:@selector(CancleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    [CustomPopView addSubview:HeaderView];
    [WEBView addSubview:CancleBtn];
    [CustomPopView addSubview:WEBView];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:CustomPopView];
    
    [self TappedCancel];
    
    
}

- (void)TappedCancel
{
    
    
    if (_isdaiweiquanShow==NO) {
        
        [UIView animateWithDuration:0.25f animations:^{
            [CustomPopView setFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
            
        } completion:^(BOOL finished) {
            _isdaiweiquanShow = YES;
        }];
        
        
        
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            [CustomPopView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT)];
            
        } completion:^(BOOL finished) {
            _isdaiweiquanShow = NO;
        }];
        
        
    }
    
    
    
}

-(void)CancleClick:(UIButton*)sender
{
    [self TappedCancel];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _OldY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if( WebView.scrollView.contentOffset.y > _OldY&&!self.isHidden) {
        NSLog(@"向下");
        CGRect frame =NavBarFrame;
        CGRect webViewFrame=WebView.frame;
        frame.origin.y = -24;
        webViewFrame.origin.y -= 44;
        webViewFrame.size.height += 44;
        
        [UIView animateWithDuration:0.2 animations:^{
            NavBarFrame = frame;
            WebView.frame=webViewFrame;
          
            
        } completion:^(BOOL finished) {
       
            bottomButton.hidden = NO;
            backButton.hidden = YES;
            closeButton.hidden = YES;
            reloadButton.hidden = YES;
             TitleLabel.text = @"";
             self.isHidden= YES;
        }];
      
        
       
      
       
        
    }else if( WebView.scrollView.contentOffset.y < _OldY&& self.isHidden)
    {
  
        CGRect navBarFrame=NavBarFrame;
        CGRect webViewFrame=WebView.frame;
        
        navBarFrame.origin.y = 20;
        webViewFrame.origin.y += 44;
        webViewFrame.size.height -= 44;
        
        [UIView animateWithDuration:0.2 animations:^{
            NavBarFrame = navBarFrame;
            WebView.frame =webViewFrame;
           
        } completion:^(BOOL finished)
         {
             
             bottomButton.hidden = NO;
             backButton.hidden = NO;
             closeButton.hidden = NO;
             reloadButton.hidden = NO;
              TitleLabel.text = _webTitle;
              self.isHidden= NO;
         }];

    }
 
}
-(void)InitShiYongShuoButton
{
    
    if(_webViewType==1&&!ShiYongShuoButton)
    {
        ShiYongShuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ShiYongShuoButton.frame = CGRectMake(SCREEN_WIDTH,SCREEN_HEIGHT/2-37.5, 75, 75);
        ShiYongShuoButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"webbtn3"]];
        [ShiYongShuoButton addTarget:self action:@selector(ShiYongShuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       
        [self.view addSubview:ShiYongShuoButton];
    }
    
    
}


#pragma mark -
#pragma mark Button State Handling


-(void)reloadButtonClick:(UIButton*)sender
{
    
    [WebView reload];
    
}
-(void)closeButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}



#pragma WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
 
    NSString * requestURL = request.URL.absoluteString ;
    
    
    
    if(_webViewType==WebViewTypeNormal){
  
        NSString * url = @"m.tmall.com";
        NSString * url1 = @"m.tmall.hk";
        NSString * url2 = @"spygmall.com";
        if (([requestURL rangeOfString:url].location != NSNotFound)||([requestURL rangeOfString:url1].location != NSNotFound)||!([requestURL rangeOfString:url2].location != NSNotFound)) {
            NSLog(@"类型切换");
            
            _webViewType = 2;
            
        }else
        {
            _webViewType = 1;
            NSLog(@"类型不切换");
            return YES;
        }

        
    }
    
    NSURL *url = request.URL;
    
    /**
     *  拦截app跳转
     */

    if ((![url.scheme isEqualToString:@"http"])&&(![url.scheme isEqualToString:@"https"])&&![url.scheme isEqualToString:@"weixin"]) {
  
        return NO;
    }

    return YES;
  
}
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    [TestActivityIndicator startAnimating];
    
    if (_smallWebShow) {
        [testActivityIndicator startAnimating];
    }
    

 
  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    
    
    if (WebView.isLoading) {
        return;
    }else
    {
        _count ++;
        
        _doctitle = [WebView documentTitle];
        NSLog(@"%@",_doctitle);
        if ([_doctitle isEqualToString:@"404 Not Found"]) {
            
            WebView.hidden = YES;
            [HDHud showMessageInView:self.view title:@"亲，该商城的简介跑火星去了..."];
        }
        
        
        [TestActivityIndicator stopAnimating];
        
        if (_smallWebShow) {
            [testActivityIndicator stopAnimating];
        }
        
        [self refreshBottomBar];
        
       
        
        //获取Html字符串
        NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
        _htmlStr = [WebView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
        
        _NewUrl = WebView.request.URL.absoluteString;

        NSLog(@"%@",_NewUrl);
      
        if (_count%2==0) {
            NSLog(@"偶数页");
           
        }else if (_count%2==1)
        {
            NSLog(@"奇数页");
            
            NSString * aitaobao = @"ai.m.taobao.com";
            
            NSString * clicktaobao = @"s.click.taobao.com";
            
            if ([_NewUrl rangeOfString:aitaobao].location != NSNotFound||[_NewUrl rangeOfString:clicktaobao].location != NSNotFound) {
                
                _aiTaoBao = YES;
                
            }else
            {
                _aiTaoBao = NO;
            }
            
            
        }
        
        if (_webViewType==WebViewTypeShiYongShuo) {
            
            [self postID];
            
            
            _RuleDict = [NSMutableDictionary dictionary];
            [_RuleArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString * url = [obj valueForKey:@"detail_page_regular"];
                
                if ([_NewUrl rangeOfString:url].location != NSNotFound) {
                    _RuleDict = [NSMutableDictionary dictionaryWithDictionary:obj];
                    
                }
                
                
            }];
            
            
            [self refreshWebView:_RuleDict HtmlStr:_htmlStr];
            
            
        }
        
        [self postDeviceInfo];
 
    }
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;
{
    [TestActivityIndicator stopAnimating];
    
  // [HDHud showMessageInView:self.view title:@"亲，您的网络不太顺畅喔~"];
 
}
-(void)postID
{
    
    NSString * tmall = @"tmall.com";
    NSString * taobao = @"taobao.com";
    NSString * bijia = @"fl.shiyongbao.com.cn";
    
    if (([_NewUrl rangeOfString:tmall].location != NSNotFound)||([_NewUrl rangeOfString:taobao].location != NSNotFound)||([_NewUrl rangeOfString:bijia].location != NSNotFound)) {
    
        _isTmall = YES;
        
    }else
        
    {
        
        _isTmall = NO;
    }
    
    for (NSDictionary * dict in _ConditionArray) {
        
        NSString * alipay  = [dict valueForKey:@"pattern_order_id"];
        NSString * url = [dict valueForKey:@"url"];
        
        if ([_NewUrl rangeOfString:url].location != NSNotFound) {
            _url1  = url;
            _alipay1 = alipay;
        }
        
    }
 
    BOOL alipayIsEmpty = IsStrEmpty(_alipay1);
    
    
    if (_isTmall&&!alipayIsEmpty) {
  
            NSRange range = [_NewUrl rangeOfString:_alipay1];
            NSInteger location = range.location;
            NSRange range1 = NSMakeRange(location+13,[_NewUrl length]-location-13);
            if (location+13>[_NewUrl length]) {
                NSLog(@"字符串长度越界");
            }else
            {
                
                NSString * str2 = [_NewUrl substringWithRange:range1];
                NSString * str3 = @"&";
                NSRange range2 = [str2 rangeOfString:str3];
                NSInteger location1 = range2.location;
                NSRange range3 =  NSMakeRange(0,location1);
                NSString * order_id = [str2 substringWithRange:range3];
                
                NSLog(@"%@",order_id);
                NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:order_id,@"order_id", nil];
                
                GXHttpRequest * request = [[GXHttpRequest alloc]init];
                [request StartWorkPostWithurlstr:URL_insert_tmall_order pragma:postDict ImageData:nil];
                
                request.successGetData = ^(id obj){
                    //加载框消失
                    NSLog(@"*********%@",obj);
                };
                request.failureGetData = ^(void){
                    
                };
            }
            
    
        
     
       
        
    }else
    {
        NSLog(@"不包含");
    }

    
}


-(void)refreshWebView:(NSDictionary*)dict HtmlStr:(NSString*)str;
{
   
    
    if(_shiyongshuoShow==YES)
    {
        
        [UIView animateWithDuration:.25 animations:^{
            
            ShiYongShuoButton.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-37.5, 75, 75);
            _shiyongshuoShow = NO;
          
        }];
        
    }
    
  
    NSString * prefix = [dict valueForKey:@"prefix_html"];
    NSString * sufix = [dict valueForKey:@"sufix_html"];
    NSString * headStr = [self htmlEntityDecode:prefix];
    NSString * footStr = [self htmlEntityDecode:sufix];
    NSRange range = [str rangeOfString:headStr];
    NSInteger location = range.location;
    NSRange range1 = NSMakeRange(location,300);
    NSString * str2 =[str substringWithRange:range1];
    NSString * str3 = [NSString stringWithFormat:@"%@",footStr];
    NSRange  range2 = [str2 rangeOfString:str3];
    NSInteger location1 = range2.location;
    NSInteger length = location1;
    NSRange range4 = NSMakeRange(0,length);
    NSString * str5 = [str2 substringWithRange:range4];
    NSString *content = [self filterHTML:str5];
    
 
    
   _ShiYongShuoTitle = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
    
    
    if ([_ShiYongShuoTitle isEmpty]) {
        
        NSLog(@"看看能不能走到这里");

    }else
    {
        [self GetshiYongShuoList];
    }
    
    
}

//转码
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return string;
}
//去除HTML代码
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}
//请求识用说数组
-(void)GetshiYongShuoList
{
    
    NSString * keyword = [NSString stringWithFormat:@"%@",_ShiYongShuoTitle];
    //NSString * shuoshuoID = [NSString stringWithFormat:@"%@",_ShiYongShuoID];
    NSString * num = @"5";
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:keyword,@"keyword",num,@"num", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_SearchProductList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:obj];

        //识用说数组
        _ShiYongShuoArray = [dict valueForKey:@"result"];
        _ShiYongShuoModelArray = [WebShiYongShuoModel mj_objectArrayWithKeyValuesArray:_ShiYongShuoArray];

        NSLog(@"%@",_ShiYongShuoArray);
        
      if([_ShiYongShuoArray count]>0&&_shiyongshuoShow==NO)
      {
          
          [UIView animateWithDuration:.25 animations:^{
              
              ShiYongShuoButton.frame = CGRectMake(SCREEN_WIDTH-75, SCREEN_HEIGHT/2-37.5, 75, 75);
              _shiyongshuoShow = YES;
              
       
              
          }];
         
       }
        [TableView reloadData];
 
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
       
    };
    
}


-(void)ShiYongShuoButtonClick:(UIButton*)sender
{
   
    _selectIndex = 0;
   
    _segmentControlArray = @[[@"识真伪" uppercaseString], [@"知应用" uppercaseString], [@"通养护" uppercaseString], [@"规格参数" uppercaseString]];
    
    if ([_ShiYongShuoModelArray count]==0) {
        [HDHud showMessageInView:self.view title:@"没有相关的商品"];
    }else
    {
        NSLog(@"弹出");
        [self initPopView];
        _smallWebShow = YES;
    }
}

-(void)initPopView
{

    if (!TableView) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 350) style:UITableViewStylePlain];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.userInteractionEnabled = YES;
        TableView.backgroundColor = [UIColor clearColor];
        }

    if (!detailView) {
        detailView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, 350) ];
        detailView.backgroundColor = [UIColor clearColor];
        UISwipeGestureRecognizer * toRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(toRightSwipe:)];
        [toRight setNumberOfTouchesRequired:1];
        [toRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [detailView addGestureRecognizer:toRight];
        
    }
        
    if (!imgv) {
        imgv = [[UIImageView alloc]init];
        imgv.frame = CGRectMake(20, 10, 50,50);
        imgv.layer.cornerRadius = 25;
        imgv.layer.borderWidth = .5;
        imgv.layer.borderColor = RGBACOLOR(209, 209, 209, 1).CGColor;
        imgv.layer.masksToBounds = YES;
        [detailView addSubview:imgv];
    }
        
    if (!titleLabel) {
            
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200*Proportion, 40)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 2;
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        titleLabel.backgroundColor = [UIColor clearColor];
        [detailView addSubview:titleLabel];
    }
        
    
    if (!priceLabel) {
            
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, 200*Proportion, 20)];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.numberOfLines = 2;
        priceLabel.lineBreakMode = NSLineBreakByCharWrapping;
        priceLabel.backgroundColor = [UIColor clearColor];
        [detailView addSubview:priceLabel];
    }
     
    if (!detailHeaderView) {
        detailHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        detailHeaderView.backgroundColor = [UIColor clearColor];
        [detailView addSubview:detailHeaderView];
    }
     
        
    if(!segmetedControl)
        {
        segmetedControl = [[UISegmentedControl alloc] initWithItems:_segmentControlArray];
        segmetedControl.tintColor = ThemeColor;
        segmetedControl.frame =CGRectMake(20,70,SCREEN_WIDTH-40, 40);
        segmetedControl.selectedSegmentIndex = _selectIndex;
        [segmetedControl addTarget:self action: @selector(controlPressed:)
                      forControlEvents:UIControlEventValueChanged
            ];
        segmetedControl.backgroundColor = [UIColor clearColor];
        [detailView addSubview:segmetedControl];
    }
    
    
    
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.frame = CGRectMake(0, 110, SCREEN_WIDTH, 240);
        _webView.scalesPageToFit = NO;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [detailView addSubview:_webView];
     
        }
    if (!testActivityIndicator) {
        
        testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        testActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,120);//只能设置中心，不能设置大小
        testActivityIndicator.color = ThemeColor;
        [testActivityIndicator setHidesWhenStopped:YES];
        [testActivityIndicator startAnimating];
        [_webView addSubview:testActivityIndicator];
    }

    if (!cancleBtn) {
            //取消按钮
        cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = CGRectMake(SCREEN_WIDTH-40, -15, 30, 30);
        cancleBtn.layer.masksToBounds = YES;
        cancleBtn.layer.cornerRadius = 15;
        UIImage * btnimg = [UIImage imageNamed:@"webcancle"];
        [cancleBtn setImage:btnimg forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
      
    
        
    if (!headerView) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 350)];
        headerView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [headerView addGestureRecognizer:tapGesture];
    }
    
    if (!cpvBGview) {
        
        cpvBGview = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 350), SCREEN_HEIGHT,350)];
        cpvBGview.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
    }
    

    
    customPopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    customPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    customPopView.userInteractionEnabled = YES;
    
    
    [cpvBGview addSubview:TableView];
    [cpvBGview addSubview:detailView];
    [cpvBGview addSubview:cancleBtn];
    [customPopView addSubview:headerView];
    [customPopView addSubview:cpvBGview];
        
        
    [UIView animateWithDuration:0.25f animations:^{
            [cpvBGview setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-350, [UIScreen mainScreen].bounds.size.width,350)];
            
    } completion:^(BOOL finished) {
            
    }];
        
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:customPopView];
   

}
-(void)cancleClick:(UIButton*)sender
{
    [self tappedCancel];
}
//识用说页面消失
- (void)tappedCancel
{
    _smallWebShow = NO;
    
    [UIView animateWithDuration:0.25f animations:^{
        [cpvBGview setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        customPopView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [customPopView removeFromSuperview];
        }
    }];
}
-(void)toRightSwipe:(UIGestureRecognizer*)gestureRecognizer
{
    [UIView animateWithDuration:0.25f animations:^{
        [TableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
        [detailView setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,350)];
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"finish");
        }
    }];
}

- (void)controlPressed:(id)sender {
    
    _selectIndex = segmetedControl.selectedSegmentIndex;

    switch (_selectIndex) {
        case 0:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"pinjian"];
        }
            break;
        case 1:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"yingyong"];
        }
            break;
        case 2:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"kehu"];
        }
            break;
        case 3:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"guige"];
        }
            break;
        default:
            break;
    }
    
    NSURL * loadUrl = [NSURL URLWithString:_smallWebUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loadUrl];
    [_webView loadRequest:urlRequest];
    
    
    
}

#pragma mark - ViewController Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}


#pragma table delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    return [_ShiYongShuoModelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //初始化每行的数据模型
    WebShiYongShuoModel * webShiYongShuoModel = _ShiYongShuoModelArray[indexPath.row];
    
    static NSString * cellID = @"webshiyongshuoCell";
    WebShiYongShuoTableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[WebShiYongShuoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.webshiyongshuoModel = webShiYongShuoModel;
    _shiyongshuoDict = [_ShiYongShuoArray objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    
    _shiyongshuoDict = [_ShiYongShuoArray objectAtIndex:indexPath.row];
    
   // NSLog(@"^^%@",_shiyongshuoDict);
    
    [UIView animateWithDuration:0.25f animations:^{
            [TableView setFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, 350)];
            float price = [[_shiyongshuoDict valueForKey:@"ref_price"] floatValue];
           NSString * imageUrl = [_shiyongshuoDict valueForKey:@"p_img_url"];
            NSURL * imgUrl = [NSURL URLWithString:imageUrl];
            priceLabel.text = [NSString stringWithFormat:@"价格:￥%.2f",price];
            titleLabel.text = [_shiyongshuoDict valueForKey:@"p_name"];
            [imgv sd_setImageWithURL:imgUrl];
        
        
            _smallWebUrl = [_shiyongshuoDict valueForKey:@"pinjian"];
        
       
            NSURL * loadUrl = [NSURL URLWithString:_smallWebUrl];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loadUrl];
            [_webView loadRequest:urlRequest];
            [detailView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
        } completion:^(BOOL finished) {
            if (finished) {
                NSLog(@"finish");
            }
        }];
        

    
}

//获取返利规则的数据
-(void)getRuleArrayData;
{
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkWithUrlstr:URL_Rebate_Site];

    request.successGetData = ^(id obj){
 
        if (IS_ARRAY_CLASS([obj valueForKey:@"result"])) {
            
            _RuleArray = [obj valueForKey:@"result"];
        
        
            
        }else
        {
            NSLog(@"hehe");
        }
      


    };
    request.failureGetData = ^(void){         
    };
    
    
    
}
//获取天猫条件
-(void)getCommitUrlRegular
{
    
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkWithUrlstr:URL_getCommitUrlRegular];
    request.successGetData = ^(id obj){
       
        
        if (IS_ARRAY_CLASS([obj valueForKey:@"result"])) {
            
           _ConditionArray = [obj valueForKey:@"result"];
       
            
        }else
        {
            NSLog(@"hehe");
        }
        
    };
    request.failureGetData = ^(void){
        
    };
}

-(void)postDeviceInfo;
{

    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:
                             _NewUrl,@"v_url",nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_accessedUrlStat pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
        
     
    };
    request.failureGetData = ^(void){
        
    };
    
}


@end
