//
//  RenZhengGoodsDetailViewController.m
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RenZhengGoodsDetailViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
@implementation RenZhengGoodsDetailViewController
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
 
    [MobClick beginLogPageView:@"认证详情2"];
   [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];
    [MobClick endLogPageView:@"认证详情2"];
    

}


//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
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
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}


//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"认证商品";
   
    [self.view addSubview:self.TableView];
    [self getshiyongshuo];
    [self getgoodsDeatil];
    _segmentControlArray = @[[@"识真伪" uppercaseString], [@"知应用" uppercaseString], [@"通养护" uppercaseString], [@"规格参数" uppercaseString]];
}
-(void)getgoodsDeatil;
{
    [HDHud showHUDInView:self.view title:@"加载中"];
    
    NSString * goodsID = _model.c_goods_id;
    
    //NSString * shiyongshuoID = @"00000bf2-d031-43fc-bde8-eb1554c71ad4";
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:goodsID,@"c_goods_id", nil];
    
    NSLog(@"%@",postDict);
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getQtAuthenticationGoodsDetail pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
        [HDHud hideHUDInView:self.view];
        
        NSLog(@" ****%@",obj);
        _SiteArray = [[obj valueForKey:@"result"] valueForKey:@"qt_goods_stores"];
        
        [_TableView reloadData];
        
        
        
    };
    request.failureGetData = ^(void){
        
        [HDHud showNetWorkErrorInView:self.view];
        
        [HDHud hideHUDInView:self.view];
    };
    
    
}


-(void)getshiyongshuo
{
    NSString * shiyongshuoID = _model.sys_goods_id;
    //NSString * shiyongshuoID = @"00000bf2-d031-43fc-bde8-eb1554c71ad4";
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shiyongshuoID,@"goods_id", nil];
    
    NSLog(@"%@",postDict);
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_SearchProductById pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        NSLog(@"***%@",obj);
        
        NSArray * resultArray = [obj valueForKey:@"result"];
        
        if ([resultArray count]>0) {
            _shiyongshuoDict = resultArray[0];
        }
        
        shiyongshuoButton.userInteractionEnabled = YES;
        
    };
    request.failureGetData = ^(void){
        
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}
-(UIView*)HeaderView
{
    if (!_HeaderView) {
        _HeaderView = [[UIView alloc]init];
        _HeaderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 100);
        _HeaderView.backgroundColor = [UIColor whiteColor];
        
        //图片
        if (!cellimg) {
            cellimg = [[UIImageView alloc]init];
            cellimg.frame = CGRectMake(15,15, 70, 70);
            cellimg.backgroundColor = [UIColor whiteColor];
            cellimg.layer.cornerRadius = 3;
            cellimg.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
            cellimg.layer.borderWidth = .5;
            NSString * goodsImageUrl = _model.main_image;
            UIImage * noimage = [UIImage imageNamed:@"noimage"];
            [cellimg sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
        }
        
        
        //产品标题
        if (!celltitle) {
            celltitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200*Proportion, 40)];
            celltitle.textColor = [UIColor blackColor];
            celltitle.font = [UIFont systemFontOfSize:16.0];
            celltitle.textAlignment = NSTextAlignmentLeft;
            celltitle.numberOfLines = 2;
           // celltitle.lineBreakMode = NSLineBreakByCharWrapping;
            celltitle.backgroundColor = [UIColor clearColor];
            celltitle.text = _model.long_title;
        }
  
        
        
        
        if (!line) {
            line = [[UILabel alloc]initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = BGColor;
        }
        
        if (!shiyongshuoButton) {
            shiyongshuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            shiyongshuoButton.frame = CGRectMake(SCREEN_WIDTH-80, 62, 60, 25);
            shiyongshuoButton.backgroundColor = [UIColor whiteColor];
            [shiyongshuoButton setTitle:@"识用说" forState:UIControlStateNormal];
            [shiyongshuoButton setTitleColor:RGBACOLOR(102, 102, 102, 1) forState:UIControlStateNormal];
            shiyongshuoButton.layer.borderColor = RGBACOLOR(114, 114, 114, 1).CGColor;
            shiyongshuoButton.layer.cornerRadius = 5;
             shiyongshuoButton.layer.borderWidth = 0.5;
            shiyongshuoButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [shiyongshuoButton addTarget:self action:@selector(shiyongshuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_HeaderView addSubview:cellimg];
        [_HeaderView addSubview:celltitle];
        [_HeaderView addSubview:line];
        [_HeaderView addSubview:shiyongshuoButton];
    }
    return _HeaderView;
}
-(void)shiyongshuoButtonClick:(UIButton*)sender
{
    NSLog(@"shiyongshuo");

    if (IS_DICTIONARY_CLASS(_shiyongshuoDict)) {
        if(!segmetedControl)
        {
            segmetedControl = [[UISegmentedControl alloc] initWithItems:_segmentControlArray];
            segmetedControl.tintColor = ThemeColor;
            segmetedControl.frame =CGRectMake(20,5,SCREEN_WIDTH-40, 30);
            segmetedControl.selectedSegmentIndex = _selectIndex;
            [segmetedControl addTarget:self action: @selector(controlPressed:)
                      forControlEvents:UIControlEventValueChanged
             ];
            segmetedControl.backgroundColor = [UIColor clearColor];
            
        }
        
        
        
        
        webView = [[UIWebView alloc]init];
        webView.frame = CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT-204);
        webView.scalesPageToFit = NO;
        webView.delegate = self;
        webView.backgroundColor = [UIColor clearColor];
        
        NSString * urlString = [_shiyongshuoDict valueForKey:@"pinjian"];
        NSURL * loadUrl = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loadUrl];
        [webView loadRequest:urlRequest];
        
        
        if (!testActivityIndicator) {
            
            testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            testActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,120);//只能设置中心，不能设置大小
            testActivityIndicator.color = ThemeColor;
            [testActivityIndicator setHidesWhenStopped:YES];
            [testActivityIndicator startAnimating];
            [webView addSubview:testActivityIndicator];
        }
        
        
        if (!headerView) {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164)];
            headerView.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
            [headerView addGestureRecognizer:tapGesture];
        }
        
        if (!cpvBGview) {
            
            cpvBGview = [[UIView alloc] initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH,SCREEN_HEIGHT-164)];
            cpvBGview.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
        }
        
        
        
        customPopView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        customPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        customPopView.userInteractionEnabled = YES;
        
        
        
        [cpvBGview addSubview:webView];
        [cpvBGview addSubview:segmetedControl];
        [customPopView addSubview:headerView];
        [customPopView addSubview:cpvBGview];
        
        
        [UIView animateWithDuration:0.25f animations:^{
            [customPopView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:customPopView];
    }else
    {
        [HDHud showMessageInView:self.view title:@"暂无信息"];
    }
    
    
    
  
    

}

-(void)cancleClick:(UIButton*)sender
{
    [self tappedCancel];
}
//识用说页面消失
- (void)tappedCancel
{
    
    
    [UIView animateWithDuration:0.25f animations:^{
        [customPopView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        customPopView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [customPopView removeFromSuperview];
        }
    }];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [testActivityIndicator stopAnimating];
}


-(UITableView*)TableView
{
    if (!_TableView)
    {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.backgroundColor = [UIColor clearColor];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _TableView.tableHeaderView = self.HeaderView;
       
    }
    
    return _TableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return [_SiteArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        _sectionTitle.backgroundColor = [UIColor clearColor];
        _sectionTitle.textColor = [UIColor blackColor];
        _sectionTitle.textAlignment = NSTextAlignmentLeft;
        _sectionTitle.font = [UIFont systemFontOfSize:14.0f];
        _sectionTitle.text = [NSString stringWithFormat:@"   认证通过店铺"];
    }
    
    return _sectionTitle;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
      return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UITableViewCell * cell;
    
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = ThemeColor;
        
        
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH-80, 20)];
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.font = [UIFont systemFontOfSize:14];
        _cellTitle.textAlignment = NSTextAlignmentLeft;
        _cellTitle.textColor = [UIColor grayColor];
      
        [cell.contentView addSubview:_cellTitle];
        
        
        _cellLabel = [[UILabel alloc]init];
        _cellLabel.frame = CGRectMake(SCREEN_WIDTH-80, 7, 60, 30);
        _cellLabel.backgroundColor = [UIColor clearColor];
        _cellLabel.layer.cornerRadius = 5;
        _cellLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _cellLabel.layer.borderWidth = .5;
        _cellLabel.text = @"在售";
        _cellLabel.font = [UIFont systemFontOfSize:16];
        _cellLabel.textColor = ThemeColor;
        _cellLabel.hidden = YES;
        _cellLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:_cellLabel];
        
    }
    
    
      id cellStr = [_SiteArray[indexPath.row] valueForKey:@"store_goods_name"];

        id webview_url =[_SiteArray[indexPath.row] valueForKey:@"store_goods_url"];
    
       if ([webview_url isKindOfClass:[NSString class]]&&[_cellLabel isKindOfClass:[NSString class]]) {
        
           _cellTitle.text = cellStr;
           
        if ([webview_url isEqualToString:@""]) {
            
            cell.selected = NO;
            _cellLabel.hidden = YES;
            
        }else
        {
            
            _cellLabel.hidden = NO;
        }

       }else
       {
           NSLog(@"");
       }
    
    
    


    
    
    

    
//        NSString * storeName = [_SiteArray[indexPath.row] valueForKey:@"vote_store_name"];
//        
//        
//        NSString * siteName = [_SiteArray[indexPath.row] valueForKey:@"vote_rebate_site_name"];
//        
//        
//        NSString * string = [NSString stringWithFormat:@"%@ %@",storeName,siteName];
//        
//        // 创建可变属性化字符串
//        NSMutableAttributedString *attrString =
//        [[NSMutableAttributedString alloc] initWithString:string];
//        
//        
//        
//        // 设置颜色
//        UIColor *color = [UIColor grayColor];
//        [attrString addAttribute:NSForegroundColorAttributeName
//                           value:color
//                           range:[string rangeOfString:siteName]];
//        
//        
//        
//        _cellTitle.attributedText = attrString;
//    
//        
 
    
    
    
    return cell;
    
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
        NSString * webview_url = [_SiteArray[indexPath.row] valueForKey:@"webview_url"];
    
    
    if ([webview_url isEqualToString:@""]) {
        [HDHud showMessageInView:self.view title:@"暂无在售产品"];
    }else
    {
        NSString * storeName = [_SiteArray[indexPath.row] valueForKey:@"vote_store_name"];
        SM = [SingleManage shareManage];
        if (SM.isLogin&&![webview_url isEmpty]) {
            WebViewController * webVC = [[WebViewController alloc]init];
            webVC.webViewType = WebViewTypeShiYongShuo;
            webVC.requestURL = webview_url;
            webVC.webTitle = storeName;
            [self.navigationController pushViewController:webVC animated:YES];
        }if(!SM.isLogin)
        {
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }

    }
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
    [webView loadRequest:urlRequest];
    
    
}

#pragma mark - ViewController Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}
@end
