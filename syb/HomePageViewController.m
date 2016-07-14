//
//  HomePageViewController.m
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

#import "HomePageViewController.h"
#import "SearchViewController.h"
#import "BarCodeViewController.h"
#import "CategoryViewController.h"
#import "ShopAllViewController.h"
#import "WebViewController.h"
#import "MyMessageViewController.h"
#import "LoginViewController.h"
#import "CommodityViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

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
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }
    
    [self performSelector:@selector(StatusBarStyleChange) withObject:nil afterDelay:0.1];
   

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(attentionChange:) name:@"attention" object:nil];
    
    self.update = YES;
    [self getShopCatList];
    [self InitTabelView];
    [self InitgoToTopButton];
 
   
}

-(void)attentionChange:(NSNotification*)notification
{
    [self headerRereshing];
    NSLog(@"…………………………刷新状态");
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
-(void)getShopCatList
{
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_ShopCatList pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失
         NSLog(@"%@",obj);
        _shopCatList = [obj valueForKey:@"result"];
        
    };
    request.failureGetData = ^(void){
        
        
    };
}
//请求一楼Banner数据
-(void)getADData
{

    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_HomePageAD pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失
        
        //头部的数据模型
        NSMutableArray * resultArray = [obj valueForKey:@"result"];
        
        
        _bannerImageArray = [NSMutableArray array];
        
        for (NSDictionary * dict in resultArray) {
            NSString * img_url = [dict valueForKey:@"img_url"];
            [_bannerImageArray addObject:img_url];
        }
        
        _bannerModelArray  = [HomePageFloorDTO mj_objectArrayWithKeyValuesArray:resultArray];

        _bannerArray = [NSMutableArray arrayWithArray:_bannerModelArray];
        
        _AdFinish = YES;
        
        [self InitBannerView];
        
        [self RequestFinish];
        
    };
    request.failureGetData = ^(void){
        
        
    };
}

//请求首页其他楼层数据
-(void)requestData
{
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_HomePage pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
      
        //初始化新的首页数据
        _HomePageArray = [NSMutableArray array];
   
        NSLog(@"%@",obj);
        
        //第一层数据处理
        NSMutableArray * floor1 = [[obj valueForKey:@"result"] valueForKey:@"module_0"];
    
        
        NSMutableDictionary * floor1dict = [NSMutableDictionary dictionary];
        [floor1dict setValue:@"xunzhen" forKey:@"xunzhen"];
        [floor1dict setValue:@"floor1" forKey:@"floorName"];
        [floor1dict setValue:floor1 forKey:@"floor1Array"];
        [_HomePageArray addObject:floor1dict];
      
      
        //第二层数据处理
        NSMutableArray * floor3 = [[obj valueForKey:@"result"] valueForKey:@"module_1"];
        _categoryArray = [[obj valueForKey:@"result"]valueForKey:@"module_1"];
        

        NSString * cat_id1 = [[floor3 objectAtIndex:0] valueForKey:@"cat_id"];
        NSString * cat_id2 = [[floor3 objectAtIndex:1] valueForKey:@"cat_id"];

        NSString * babyimage = [floor3[0]valueForKey:@"image_url"];
        NSString * beautyimage = [floor3[1]valueForKey:@"image_url"];
        
        //初始化第三成层的数据字典
        NSDictionary * floor2Dict = @{ @"shangpinhuiImageName" : @"floor1_shangpinhui", @"babybuttonImageName" : babyimage, @"beautyButtonImageName" : beautyimage ,@"floorName":@"floor2",@"cat_id1":cat_id1,@"cat_id2":cat_id2};
        
        //初始化第四层的数据字典
        NSDictionary * floor3Dict = @{ @"wangdianhuiImageName" : @"floor2_wangdianhui", @"moreImageName" : @"floor2_more",@"floorName":@"floor3" };
        
        [_HomePageArray addObject:floor2Dict];
        [_HomePageArray addObject:floor3Dict];
        
      
        _ShopsListArray = [[obj valueForKey:@"result"] valueForKey:@"module_2"];
        

        //拿到第四层的店铺数组
        
        for (NSDictionary * shopDict in _ShopsListArray) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:shopDict];
            [dict setValue:@"floor4" forKey:@"floorName"];
            [_HomePageArray addObject:dict];
        }
        
   

        
        //数据建模
        _ModelArray = [HomePageFloorDTO mj_objectArrayWithKeyValuesArray:_HomePageArray];
        
        //初始化新的数组
        _NewHomePageArray = [NSMutableArray arrayWithArray:_ModelArray];
        
        _OtherFloorFinish = YES;

        
         [self RequestFinish];
        
        
    };
    request.failureGetData = ^(void){
        
        [TableView.header endRefreshing];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}
//数据请求完成
-(void)RequestFinish
{
    if (_AdFinish&&_OtherFloorFinish) {
        
        [TableView.header endRefreshing];
        [CollectionView reloadData];
        [TableView reloadData];
        FooterView.hidden = NO;
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
-(void)InitBannerView
{
    
    /*使用API */
    CCAdsPlayView *apView = [CCAdsPlayView adsPlayViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,107*Proportion) imageGroup:_bannerImageArray];
    //设置小圆点位置
    apView.pageContolAliment = CCPageContolAlimentCenter;
    //设置动画时间
    apView.animationDuration = 3.;
    //设置缺省图
    //apView.placeHoldImage = [UIImage imageNamed:@"Default-568h"];
  
    //这句可以在任何地方使用，异步下载并展示
    
    __weak HomePageViewController * homePageVC = self;
   
    __block  HomePageFloorDTO  * homePageModel = homePageModel;
    
    [apView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
        homePageModel = _bannerArray[index];
                    WebViewController * webVC = [[WebViewController alloc]init];
                    webVC.webViewType = WebViewTypeNormal;
                    webVC.requestURL = homePageModel.url_link;
                    webVC.webTitle = homePageModel.url_title;
                    [homePageVC.navigationController pushViewController:webVC animated:YES];
        
    }];
     [HeaderView addSubview:apView];
 
}

//初始化头部视图
-(UIView*)InitHeader
{
   
    HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 107*Proportion)];
    HeaderView.backgroundColor = [UIColor clearColor];
    return HeaderView;
    
}
//初始化底部视图
-(UIView*)InitFooter
{
    
    UILabel * horizontalLabel = [[UILabel alloc]init];
    horizontalLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, .5);
    horizontalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(0, 1, SCREEN_WIDTH, 29);
    moreButton.backgroundColor = [UIColor clearColor];
    [moreButton setTitle:@"更 多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  
    
    FooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    FooterView.backgroundColor = [UIColor whiteColor];
    FooterView.hidden = YES;
    [FooterView addSubview:horizontalLabel];
    [FooterView addSubview:moreButton];
    return FooterView;
}


//页面布局
-(void)InitTabelView
{
    
    if (!TableView) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-113) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor colorWithHexString:@"#F1F1F1"];
        TableView.scrollEnabled = YES;
        TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        TableView.tableHeaderView = [self InitHeader];
        TableView.tableFooterView = [self InitFooter];
        TableView.tag = 1;
        [self addRefresh];
        [self.view addSubview:TableView];
        
    }

 
}
#pragma mark table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    //获取当前行 数据模型
    HomePageFloorDTO * homePageModel = _NewHomePageArray[indexPath.section];
    
    //根据数据模型赋值
    CGFloat rowHeight = [HomePageTabelViewCell heightForRow:homePageModel];
    
    return rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section==3) {
        return .1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_NewHomePageArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
       //初始化每行的数据模型
        HomePageFloorDTO * homePageDTO = _NewHomePageArray[indexPath.section];
        homePageDTO.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    
        static NSString * cellID = @"HomePageCell";
        HomePageTabelViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    
        if(!cell)
        {
            cell = [[HomePageTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }else{
            
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homePageModel = homePageDTO;
        cell.delegate = self;
        return cell;
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   HomePageFloorDTO * homePageModel = _NewHomePageArray[indexPath.section];
    if (indexPath.section==2) {
        ShopAllViewController * shopAllVC = [[ShopAllViewController alloc]init];
        shopAllVC.categoryArray = _shopCatList;
        [self.navigationController pushViewController:shopAllVC animated:YES];
    }else if (indexPath.section>2)
    {
        SM = [SingleManage shareManage];
        
        if (SM.isLogin) {
            
            if ([homePageModel.shop_type isEqualToString:@"1"]) {
                
                WebViewController * webVC = [[WebViewController alloc]init];
                webVC.webViewType = WebViewTypeShiYongShuo;
                webVC.webTitle = homePageModel.shop_name;
                webVC.requestURL = homePageModel.shop_click_url;
                [self.navigationController pushViewController:webVC animated:YES];
            }
            else if ([homePageModel.shop_type isEqualToString:@"2"])
            {
                
                CommodityViewController * commodityVC = [[CommodityViewController alloc]init];
                commodityVC.shop_id = homePageModel.shop_id;
                commodityVC.title = homePageModel.shop_name;
                [self.navigationController pushViewController:commodityVC animated:YES];
            }
            
            
            
        }else if(!SM.isLogin)
        {
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        
    }
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
        CGRect frame = CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64);
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
//未来可能会上
//-(void)BarCodeClick:(UIButton*)sender
//{
//
//    BarCodeViewController * barcodeVC = [[BarCodeViewController alloc]init];
//    [self.navigationController pushViewController:barcodeVC animated:NO];
//}
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //下面tableview移到大概4个cell时显示向上按钮
    if (scrollView.tag == 1 && scrollView.contentOffset.y > 600) {
        GoTopButton.alpha = .8;
    } else {
        GoTopButton.alpha = 0;
    }

}
-(void)babyButtonClick:(HomePageTabelViewCell*)cell;
{
    
    CategoryViewController * categoryVC = [[CategoryViewController alloc]init];
    categoryVC.selectIndex = 0;
    categoryVC.categoryArray = _categoryArray;
   [self.navigationController pushViewController:categoryVC animated:YES];
}
-(void)beautyButtonClick:(HomePageTabelViewCell*)cell;
{
 
    CategoryViewController * categoryVC = [[CategoryViewController alloc]init];
    categoryVC.selectIndex = 1;
    categoryVC.categoryArray = _categoryArray;
    [self.navigationController pushViewController:categoryVC animated:YES];
    
}

-(void)attentionButtonClick:(UIButton*)sender 
{
    UIButton * btn = (UIButton*)sender;
    HomePageFloorDTO * homePageModel = _NewHomePageArray[btn.tag];
    btn.userInteractionEnabled = NO;
    SM = [SingleManage shareManage];
    
    if (SM.isLogin) {
        
        [HDHud showHUDInView:self.view title:@"正在关注..."];
        
        NSString * shopID = [NSString stringWithFormat:@"%@",homePageModel.shop_id];
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id", nil];
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_DoAttentShop pragma:postDict ImageData:nil];
        
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            
            NSLog(@"666%@",obj);
            NSString * code  = [obj valueForKey:@"code"];
            
            btn.userInteractionEnabled = YES;
            if ([code isEqualToString:@"0"]) {
                NSLog(@"呵呵");
            }else if ([code isEqualToString:@"1"])
            {
        
                NSDictionary * resultDict = [obj valueForKey:@"result"];
                NSString * attentCount = [resultDict valueForKey:@"atte_count"];
                NSString * user_id = SM.userID;

                homePageModel.user_id = user_id;
                homePageModel.atte_count = attentCount;
                [TableView reloadData];

            }
            
            NSString * message = [obj valueForKey:@"message"];
            [HDHud showMessageInView:self.view title:message];
            
           
            
        };
        request.failureGetData = ^(void){
            
            btn.userInteractionEnabled = YES;
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
    
    
}

-(void)moreButtonClick:(UIButton*)sender
{
    ShopAllViewController * shopAllVC = [[ShopAllViewController alloc]init];
    shopAllVC.categoryArray = _shopCatList;
    [self.navigationController pushViewController:shopAllVC animated:YES];
}

-(void)collectioncellClick:(NSString*)url WithTitle:(NSString *)title
{
    WebViewController * webVC = [[WebViewController alloc]init];
    webVC.webViewType = WebViewTypeNormal;
    webVC.requestURL = url;
    webVC.webTitle = title;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
