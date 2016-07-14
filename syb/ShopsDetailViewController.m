//
//  ShopsDetailViewController.m
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsDetailViewController.h"

@implementation ShopsDetailViewController
- (id)init
{
    self = [super init];
    if (self) {
       self.title = @"店铺点评";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initBackButton];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
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
-(void)initBackButton
{
    if (!backButton) {
        
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.navigationController.navigationBar addSubview:backButton];
}
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    if (index>0) {
       [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
    }else

    {
        NSLog(@"无法返回");
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self InitHeaderView];
    [self requestData];
   
}
-(void)requestData
{
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_SysHtmlInfo pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        
 
        NSArray * urlArray = [obj valueForKey:@"result"];
        
        for (NSDictionary * dict  in urlArray) {
            NSString * value = [dict valueForKey:@"url_key"];
            
            if ([value isEqualToString:@"_jianbieji"]) {
                NSLog(@"^^^%@",dict);
                _url4 = [dict valueForKey:@"url_link"];
            }
        }
        
        NSLog(@"%@%@", obj, _url4);
        
        
         [self addData];
    };
    request.failureGetData = ^(void){
        
       
    };

}
-(void)addData
{
    _IndexesArray = [NSMutableArray array];
    NSString * url1 = [_shopDict valueForKey:@"shop_dyna_inspection_url"];
    NSString * url2 = [_shopDict valueForKey:@"shop_dyna_services_url"];
    NSString * url3 = [_shopDict valueForKey:@"shop_scal_standard_url"];
    NSString * url4 = [NSString stringWithFormat:@"%@",_url4];
    
    NSDictionary * floor1Dict = @{@"name":@"动态质检",@"url":url1};
    NSDictionary * floor2Dict = @{@"name":@"动态服务",@"url":url2};
    NSDictionary * floor3Dict = @{@"name":@"规模规范",@"url":url3};
    NSDictionary * floor4Dict = @{@"name":@"真伪鉴定",@"url":url4};
    
    [_IndexesArray addObject:floor1Dict];
    [_IndexesArray addObject:floor2Dict];
    [_IndexesArray addObject:floor3Dict];
    [_IndexesArray addObject:floor4Dict];
    
    [self InitTableView];
    [self InitMenuButton];
    
}

-(void)InitHeaderView
{
    //平台来源
    platform = [[UIImageView alloc]initWithFrame:CGRectMake(10,30, 40,40)];
    NSString * platformImage = [_shopDict valueForKey:@"shop_logo"];
    [platform sd_setImageWithURL:[NSURL URLWithString:platformImage]];
    
    //店铺名称
    shopName = [[UILabel alloc]initWithFrame:CGRectMake(60,30, SCREEN_WIDTH-90, 20)];
    shopName.text = [_shopDict valueForKey:@"shop_name"];
    shopName.textColor = [UIColor blackColor];
    shopName.font = [UIFont systemFontOfSize:14.0];
    shopName.textAlignment = NSTextAlignmentLeft;
    
    //质检通过
    passImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,20,79,60)];
    UIImage * passimage = [UIImage imageNamed:@"pass"];
    passImage.image = passimage;
    
    
    AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AttentionButton.frame = CGRectMake(SCREEN_WIDTH-70,25, 60, 30);
    AttentionButton.layer.borderWidth = .5;
    AttentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
    AttentionButton.layer.cornerRadius = 10;
    AttentionButton.backgroundColor = [UIColor whiteColor];
    NSString * buttonTitle;
    
    if ([[_shopDict valueForKey:@"user_id"] isEmpty]) {
        buttonTitle = @"+关注";
    }else
    {
        buttonTitle = @"已关注";
    }
    [AttentionButton setTitle:buttonTitle forState:UIControlStateNormal];
    [AttentionButton setTitle:@"+关注" forState:UIControlStateNormal];
    [AttentionButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    AttentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [AttentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    AttentionCount = [[UILabel alloc]init];
    AttentionCount.frame = CGRectMake(SCREEN_WIDTH-160,65, 150, 20);
    NSString * count =  [_shopDict valueForKey:@"atte_count"];
    NSInteger userCount = [count integerValue];
    NSString * showCount;
    if (userCount > 10000) {
        showCount = [NSString stringWithFormat:@"共%.1d万人认为靠谱",userCount/10000];
    }else{
        showCount = [NSString stringWithFormat:@"共%.0ld人认为靠谱",(long)userCount];
    }
    AttentionCount.text = showCount;
    AttentionCount.textColor = [UIColor blackColor];
    AttentionCount.textAlignment = NSTextAlignmentRight;
    AttentionCount.font = [UIFont systemFontOfSize:12];
    AttentionCount.tag = 9999;

    
 
    HeaderView = [[UIView alloc]init];
    HeaderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 100);
    HeaderView.backgroundColor = [UIColor whiteColor];
    
        
    [HeaderView addSubview:platform];
    [HeaderView addSubview:shopName];
    [HeaderView addSubview:passImage];
    [HeaderView addSubview:AttentionButton];
    [HeaderView addSubview:AttentionCount];
  
        
    [self.view addSubview:HeaderView];
   

  
}


-(void)InitMenuButton
{
   
    for (int i = 0; i<[_IndexesArray count]; i++) {
        
        menuButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButtn.frame = CGRectMake(SCREEN_WIDTH-90, 180+41*i, 80, 40);
        menuButtn.backgroundColor =  RGBACOLOR(57, 62, 65, .9);
        menuButtn.layer.cornerRadius = 5;
        NSString * title = [[_IndexesArray objectAtIndex:i] valueForKey:@"name"];
        [menuButtn setTitle:title  forState:UIControlStateNormal];
        [menuButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        menuButtn.tag = i;
        menuButtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [menuButtn addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuButtn];
        
        
    }
        
     
}

//菜单按钮的点击事件方法
-(void)menuButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
    NSIndexPath * first = [NSIndexPath indexPathForRow:0 inSection:btn.tag];
    [TableView scrollToRowAtIndexPath:first atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
-(void)InitTableView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,180,SCREEN_WIDTH, SCREEN_HEIGHT-180) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
     
        [self.view addSubview:TableView];
    }
}

#pragma mark - Navigation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_IndexesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    return SCREEN_HEIGHT-210;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 20);
    label.font= [UIFont boldSystemFontOfSize:15];
    label.text = [[_IndexesArray objectAtIndex:section]valueForKey:@"name"];
    label.textColor = ThemeColor;
    label.textAlignment = NSTextAlignmentLeft;
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,30)] ;
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView addSubview:label];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell;
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        
        WebView = [[UIWebView alloc]init];
        WebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-94);
        WebView.scalesPageToFit = NO;
        WebView.delegate = self;
        WebView.backgroundColor = [UIColor clearColor];
        NSString * url = [_IndexesArray[indexPath.section] valueForKey:@"url"];
        if([url isEmpty])
        {
            [HDHud showHUDInView:WebView title:@"暂时无法访问"];
        }else
        {
            NSURL * URL = [NSURL URLWithString:url];
            NSURLRequest * request = [NSURLRequest requestWithURL:URL];
            [WebView loadRequest:request];
            [cell.contentView addSubview:WebView];
        }
        
        
        
        testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        testActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2-105);//只能设置中心，不能设置大小
        testActivityIndicator.color = ThemeColor;
        [testActivityIndicator setHidesWhenStopped:YES];
        [testActivityIndicator startAnimating];
        [cell.contentView addSubview:testActivityIndicator];
        
        
        
    }
    
    
   
   
    return cell;

}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    [testActivityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [testActivityIndicator stopAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
     [testActivityIndicator stopAnimating];
     [HDHud showHUDInView:WebView title:@"暂时无法访问"];
}

-(void)attentionButtonClick:(UIButton*)sender
{

    UIButton * btn = (UIButton*)sender;
    btn.userInteractionEnabled = NO;
    
    UILabel * Label = (UILabel*)[self.view viewWithTag:9999];
    [HDHud showHUDInView:self.view title:@"正在关注..."];
        
    NSString * shopID = [_shopDict valueForKey:@"shop_id"];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_DoAttentShop pragma:postDict ImageData:nil];
        
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            btn.userInteractionEnabled = YES;
            NSString * message = [obj valueForKey:@"message"];
            [HDHud showMessageInView:self.view title:message];
            [btn setTitle:@"已关注" forState:UIControlStateNormal];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"attention" object:nil];
            
            NSDictionary * resultDict = [obj valueForKey:@"result"];
            NSString * attentCount = [resultDict valueForKey:@"atte_count"];
            
            if ([attentCount isEmpty]) {
                NSLog(@"没有返回值");
            }else
            {
                
                NSInteger  count = [attentCount integerValue];
                NSString * userCount;
                if (count > 10000) {
                    userCount = [NSString stringWithFormat:@"共%.1ld万人认为靠谱",count/10000];
                }else{
                    userCount = [NSString stringWithFormat:@"共%.0ld人认为靠谱",(long)count];
                }
                Label.text = userCount;
            }

            
            
            
    };
    request.failureGetData = ^(void){
            
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
        

}

@end
