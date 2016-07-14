//
//  HomePage320ViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "HomePage320ViewController.h"

@implementation HomePage320ViewController
//初始化  视图生命周期
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
    self.AdFinish = NO;
    self.OtherFloorFinish = NO;
    [self getMessageData];

    
    [self performSelector:@selector(StatusBarStyleChange) withObject:nil afterDelay:0.1];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@NO];
    
    [MobClick beginLogPageView:@"首页"];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [logoImg removeFromSuperview];
    [MagnifierIV removeFromSuperview];
    [searchView removeFromSuperview];
    [placeholderL removeFromSuperview];
    [messageButton removeFromSuperview];
    [pointImage removeFromSuperview];
    // [BarCodeButton removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.barTintColor = RGBACOLOR(250, 250, 250, .9);
    
    [MobClick endLogPageView:@"首页"];
    
}

-(void)StatusBarStyleChange
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HiddenPoint:) name:@"HiddenPoint" object:nil];

    
    [self InitTabelView];
    
    [self AutoLogin];
    
}


//没有新消息的方法
-(void)HiddenPoint:(NSNotification*)notification
{
    
    pointImage.hidden = YES;
    
}
//请求新消息数据
-(void)getMessageData;
{
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_MyNewestMessage pragma:nil ImageData:nil];
        
        request.successGetData = ^(id obj){
            
            NSString * code = [obj valueForKey:@"code"];
            
            if ([code isEqualToString:@"0"]) {
                NSLog(@"....");
            }else if ([code isEqualToString:@"1"])
            {
                NSDictionary * messageDict = [obj valueForKey:@"result"];
                NSString * messageCount = [messageDict valueForKey:@"item_count"];
                if ([messageCount integerValue]>0) {
                    
                    if (pointImage) {
                        pointImage.hidden = NO;
                    }
                }else
                {
                    NSLog(@"没有新消息");
                }
                
            }
            
            
        };
        request.failureGetData = ^(void){
            
            
        };
    }else if(!SM.isLogin)
    {
        NSLog(@"不用查看");
    }
    
    
}

//请求一楼Banner数据
-(void)getADData
{
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getAdList pragma:nil ImageData:nil];
    
    
    request.successGetData = ^(id obj){
        //加载框消失
        
        NSLog(@" %@ ",obj);
        
        NSArray * resultList = [obj valueForKey:@"result"];
        
        for (NSDictionary * adDict in resultList) {
            NSString * ad_pos_key = [adDict valueForKey:@"ad_pos_key"];
            if ([ad_pos_key isEqualToString:@"home_page"]) {
                _bannerArray = [adDict valueForKey:@"adList"];
            }
        }
        
        
        
        
        _bannerImageArray = [NSMutableArray array];
        
        for (NSDictionary * dict in _bannerArray) {
            NSString * img_url = [dict valueForKey:@"img_url"];
            [_bannerImageArray addObject:img_url];
        }
        
        
        _AdFinish = YES;
        
        
        [self RequestFinish];
        
        TableView.tableHeaderView = self.BannerView;
        
    };
    request.failureGetData = ^(void){
        
        
    };
}

-(void)AutoLogin;
{
    
    //用户名 密码
    SM = [SingleManage shareManage];
    
    if (SM.isLogin) {
        NSString * userName = SM.userName;
        NSString * passWord = SM.passWord;
        
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username",passWord,@"password",nil];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_Login pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:obj];
            
            NSString * code = [dict valueForKey:@"code"];
            NSString * reason = [dict valueForKey:@"message"];
            
            if ([code isEqualToString:@"1"]) {
                
                _userDict = [dict valueForKey:@"result"];
                [self saveUserInfo:_userDict];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:_userDict];
                
                
            }else if([code isEqualToString:@"0"])
            {
                NSLog(@"登录失败");
                [HDHud showMessageInView:self.view title:reason];
                
            }
            
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
            
            
            
        };
        
    }else
        
    {
        NSLog(@"不需要自动登录");
    }
    
    
}
-(void)saveUserInfo:(NSMutableDictionary*)dict
{
    
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_name"] forKey:@"user_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_photo"] forKey:@"user_photo"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"nickname"] forKey:@"nickname"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"birthday"] forKey:@"birthday"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"sex"] forKey:@"sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"code"] forKey:@"code"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"token"] forKey:@"token"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"password"] forKey:@"password"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"app_money"] forKey:@"user_money"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_desc"] forKey:@"user_desc"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_name"] forKey:@"baby_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_sex"] forKey:@"baby_sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_birthday"] forKey:@"baby_birthday"];
    
    
    //单例取值
    SM = [SingleManage shareManage];
    SM.userID = [UserDefaultsUtils valueWithKey:@"user_id"];
    SM.userName = [UserDefaultsUtils valueWithKey:@"user_name"];
    SM.imageURL = [UserDefaultsUtils valueWithKey:@"user_photo"];
    SM.nickName  = [UserDefaultsUtils valueWithKey:@"nickname"];
    SM.birthday = [UserDefaultsUtils valueWithKey:@"birthday"];
    SM.userSex = [UserDefaultsUtils valueWithKey:@"sex"];
    SM.code  = [UserDefaultsUtils valueWithKey:@"code"];
    SM.userToken = [UserDefaultsUtils valueWithKey:@"token"];
    SM.passWord = [UserDefaultsUtils valueWithKey:@"password"];
    SM.userMoney = [UserDefaultsUtils valueWithKey:@"user_money"];
    SM.userdesc = [UserDefaultsUtils valueWithKey:@"user_desc"];
    SM.babyName = [UserDefaultsUtils valueWithKey:@"baby_name"];
    SM.babySex = [UserDefaultsUtils valueWithKey:@"baby_sex"];
    SM.babyBirthday = [UserDefaultsUtils valueWithKey:@"baby_birthday"];
    
    SM.isLogin = YES;
}


//数据请求完成
-(void)RequestFinish
{
    
    if (_AdFinish&&_OtherFloorFinish) {
        
        [TableView.header endRefreshing];
        [TableView reloadData];
        
    }
}

//页面设置的相关方法
-(void)PageSetup
{
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = ThemeColor;
    [self.navigationController.navigationBar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self NavigationBarLayout];
}


//布局顶部导航栏
-(void)NavigationBarLayout
{
    //初始化LogoImg
    if (!logoImg) {
        logoImg = [[UIImageView alloc]init];
        logoImg.frame = CGRectMake(0,2, 80, 40);
        UIImage * hplogo = [UIImage imageNamed:@"syblogo"];
        logoImg.image = hplogo;
    }
    
    [self.navigationController.navigationBar addSubview:logoImg];
    
    
    if (!searchView) {
        searchView = [[UIView alloc]init];
        searchView.frame = CGRectMake(80, 7, SCREEN_WIDTH-120, 30);
        searchView.layer.cornerRadius = 15;
        searchView.backgroundColor = [UIColor whiteColor];
        searchView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewClick:)];
        [searchView addGestureRecognizer:tapGesture];
        
        MagnifierIV = [[UIImageView alloc]initWithFrame:CGRectMake(7.5,7.5, 15, 15)];
        MagnifierIV.image = [UIImage imageNamed:@"search"];
        MagnifierIV.userInteractionEnabled = YES;
        
        placeholderL = [[UILabel alloc]initWithFrame:CGRectMake(30*Proportion, 5, 130*Proportion, 20)];
        placeholderL.text = @"搜索商品/店铺";
        placeholderL.textColor = RGBACOLOR(98, 98, 98, 1);
        placeholderL.font = [UIFont systemFontOfSize:14.0];
        placeholderL.textAlignment = NSTextAlignmentLeft;
        
    }
    [searchView addSubview:MagnifierIV];
    [searchView addSubview:placeholderL];
    [self.navigationController.navigationBar addSubview:searchView];
    
    
    if (!messageButton) {
        UIImage * messageImage = [UIImage imageNamed:@"message_xiaoxi"];
        messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        messageButton.frame = CGRectMake(SCREEN_WIDTH-44,0, 44, 44);
        [messageButton setImage:messageImage forState:UIControlStateNormal];
        [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationController.navigationBar addSubview:messageButton];
    
    
    if (!pointImage) {
        pointImage = [[UIImageView alloc]init];
        pointImage.backgroundColor = [UIColor whiteColor];
        pointImage.layer.cornerRadius = 4.5;
        pointImage.frame = CGRectMake(SCREEN_WIDTH-16, 6, 9, 9);
        pointImage.hidden = YES;
        
    }
    
    [self.navigationController.navigationBar addSubview:pointImage];
    
    
    //    //二维码按钮
    //    BarCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    BarCodeButton.frame = CGRectMake(SCREEN_WIDTH-80,0, 40, 40);
    //    [BarCodeButton setImage:[UIImage imageNamed:@"scanCode_default"] forState:UIControlStateNormal];
    //    [BarCodeButton addTarget:self action:@selector(BarCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:BarCodeButton];
    
}


-(CCAdsPlayView*)BannerView
{
    
    /*使用API */
    _BannerView = [CCAdsPlayView adsPlayViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,107*Proportion) imageGroup:_bannerImageArray];
    //设置小圆点位置
    _BannerView.pageContolAliment = CCPageContolAlimentCenter;
    //设置动画时间
    _BannerView.animationDuration = 3.;
    //设置缺省图
    //apView.placeHoldImage = [UIImage imageNamed:@"Default-568h"];
    
    //这句可以在任何地方使用，异步下载并展示
    
    __weak HomePage320ViewController * homePageVC = self;
    
    NSLog(@"***%@",_bannerArray);
    
    [_BannerView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
        _bannerDict = [NSDictionary dictionary];
        _bannerDict = _bannerArray[index];
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webViewType = WebViewTypeNormal;
        webVC.requestURL =  [_bannerDict valueForKey:@"url_link"];
        webVC.webTitle =  [_bannerDict valueForKey:@"url_title"];
        [homePageVC.navigationController pushViewController:webVC animated:YES];
        
    }];
    
    
    return _BannerView;
}



//页面布局
-(void)InitTabelView
{
    
    if (!TableView) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-113) style:UITableViewStylePlain];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor colorWithHexString:@"#F1F1F1"];
        TableView.scrollEnabled = YES;
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TableView.tableHeaderView = self.BannerView;
        TableView.tag = 1;
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [self addRefresh];
        
        
    }
    [self.view addSubview:TableView];
    
}
-(void)viewDidLayoutSubviews
{
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //获取当前行 数据模型
    return SCREEN_HEIGHT - 102*Proportion-113;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 6.6;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    
    return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    
    return cell;
    
    
}



- (void)InitgoToTopButton
{
    if(!GoTopButton)
    {
        GoTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        GoTopButton.backgroundColor = [UIColor clearColor];
        GoTopButton.frame = CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-107, 50, 50);
        GoTopButton.alpha = 1;
        [GoTopButton setImage:[UIImage imageNamed:@"gotop"] forState:UIControlStateNormal];
        [GoTopButton addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:GoTopButton];
        
    }
    
}
//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-113);
        TableView.frame = frame;
        
    }completion:^(BOOL finished){
    }];
    
    [TableView setContentOffset:CGPointZero animated:YES];
    
}

-(void)searchViewClick:(UIGestureRecognizer*)gestureRecognizer
{
    SearchViewController * SearchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:SearchVc animated:NO];
}

-(void)messageClick:(UIButton*)sender
{
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        MyMessageViewController * myMessageVc = [[MyMessageViewController alloc]init];
        [self.navigationController pushViewController:myMessageVc animated:YES];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

//添加更新控件
-(void)addRefresh
{
    [TableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [TableView.header setTitle:@"下拉可以刷新了" forState:MJRefreshHeaderStateIdle];
    [TableView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [TableView.header setTitle:@"正在刷新 ..." forState:MJRefreshHeaderStateRefreshing];
}
//更新数据
-(void)headerRereshing
{
    [self requestData];
    [self getADData];
}
-(void)requestData
{
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_StoreGoodsFirstLevelCats pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载
        NSLog(@" %@ ",obj);
        
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            
            _catArray = [obj valueForKey:@"result"];
            
            if (IS_ARRAY_CLASS(_catArray)) {
                _cat_id = [_catArray[0] valueForKey:@"cat_id"];
            }else
            {
                _cat_id = @"RX";
            }
            
            
            if (IS_EXIST_STR(_cat_id)) {
                
                [self addParameter];
                [self requestDataWithPage:1];
            }
            
        }
        
        _OtherFloorFinish = YES;
        [self RequestFinish];
        
        
    };
    request.failureGetData = ^(void){
        
        _OtherFloorFinish = YES;
        [self RequestFinish];
    };
    
    
}

//设置请求参数
-(void)addParameter
{
    _page = @"1";
}



-(void)requestDataWithPage:(int)Type
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page",_cat_id,@"cat_id", nil];
    NSLog(@"%@",postDict);
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GetStoreGoodsByCatId pragma:postDict ImageData:nil];
    
    
    request.successGetData = ^(id obj){
        //加载框消失
        
        NSLog(@" %@ ",obj);
        
        
    };
    request.failureGetData = ^(void){
        
        [TableView.header endRefreshing];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}


@end
