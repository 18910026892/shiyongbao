//
//  HomePageViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "HomePageViewController.h"
#import "SearchViewController.h"
#import "ClassifyViewController.h"
#import "ShopsViewController.h"
#import "brandGoodsViewController.h"
#import "ClassifyViewController.h"
#import "LoginViewController.h"
#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>
#import "MyMessageViewController.h"
#import "SybWebViewController.h"

@interface HomePageViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (nonatomic,assign)int page;
@property (nonatomic,copy)NSString *cat_id;
@property (strong,nonatomic) NSArray *categoryArray;
@property (strong,nonatomic) NSMutableArray *catIdArray;
@property (strong,nonatomic) NSMutableArray *titleArray;
@property (strong,nonatomic) UIView *contentSmallSV;
@property (strong,nonatomic) NSArray *adDatas;
@property (strong,nonatomic) NSMutableArray *brandArray;
@property (strong,nonatomic) NSMutableArray *goodsList;


@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;


@end

@implementation HomePageViewController{
    UIScrollView * bigScrollView;
    UIScrollView *smallScrollView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:NO];
    
     self.navigationController.navigationBarHidden = YES;
}
-(UIButton*)GoTopButton
{
    if(!_GoTopButton)
    {
        _GoTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _GoTopButton.backgroundColor = [UIColor clearColor];
        _GoTopButton.frame = CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-107, 50, 50);
        _GoTopButton.alpha = 1;
        [_GoTopButton setImage:[UIImage imageNamed:@"gotop"] forState:UIControlStateNormal];
        [_GoTopButton addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
     
        
    }
    return _GoTopButton;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //下面tableview移到大概4个cell时显示向上按钮
    if (scrollView ==self.tableView&&scrollView.contentOffset.y>=self.tableView.height/2) {
        self.GoTopButton.alpha = .8;
    } else {
        self.GoTopButton.alpha = 0;
    }
    
}


//回到顶部
- (void)goToTop
{
    NSLog(@"go to top");
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(CCAdsPlayView*)BannerView
{
    if (!_BannerView) {
        
        _BannerView = [CCAdsPlayView adsPlayViewWithFrame:CGRectMake(0, 0,kMainScreenWidth,107*Proportion) imageGroup:nil];
        
        _BannerView.placeHoldImage  = [UIImage imageNamed:@"fillimage"];
        //设置小圆点位置
        _BannerView.pageContolAliment = CCPageContolAlimentCenter;
        //设置动画时间
        _BannerView.animationDuration = 3.;
    }
    
    
    return _BannerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScroll];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHomePageCategory) name:@"RefreshHomePageCategory" object:nil];
    [self requestAD];
    // Do any additional setup after loading the view.
    [self setUpTableView];
    [self setUpDatas];
    [self setupViews];
    _cat_id = @"RX";
    
    _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];
    
}
- (void)refreshHomePageCategory
{
    [self setUpDatas];
}
- (void)requestAD
{
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    [request RequestDataWithUrl:URL_HomePageAD pragma:nil];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            self.adDatas = [response valueForKey:@"result"];
            NSMutableArray *imageUrls = [NSMutableArray array];
            [self.adDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = obj;
                NSString *imageUrl = [dict objectForKey:@"img_url"];
                [imageUrls addObject:imageUrl];
            }];
            self.tableView.tableHeaderView = self.BannerView;
            self.BannerView.dataArray = imageUrls;
            __weak HomePageViewController * hpVC = self;
            
            [self.BannerView startWithTapActionBlock:^(NSInteger index) {
                
                
                NSDictionary * adDict = self.adDatas[index];
                SybWebViewController * WebVc = [SybWebViewController viewController];
                WebVc.RequestUlr = [adDict valueForKey:@"url_link"];
                WebVc.WebTitle = [adDict valueForKey:@"url_title"];
                [hpVC.navigationController pushViewController:WebVc animated:YES];
            
            }];
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
}
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.BannerView;
    __unsafe_unretained __typeof(self) weakSelf = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.brandArray = [NSMutableArray array];
        self.goodsList = [NSMutableArray array];
        [weakSelf addParameter];
        [weakSelf requestDataWithPage:1];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataWithPage:2];
    }];
    
    [self.tableView.mj_header beginRefreshing];

}
//设置请求参数
-(void)addParameter
{
    _page = 1;

   
}
-(void)setupViews
{
    [self.Customview addSubview:self.logoImageView];
    [self.Customview addSubview:self.searchButton];
    [self.Customview addSubview:self.messageButton];
    
    [self.view addSubview:self.GoTopButton];
    [self.view bringSubviewToFront:self.GoTopButton];
}

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.frame = CGRectMake(20, 35, 45, 15);
        _logoImageView.image = [UIImage imageNamed:@"shiyongbaologo"];
    }
    return _logoImageView;
}

-(UIButton*)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(kMainScreenWidth/2-67.5, 30, 175, 25);
        [_searchButton setImage:[UIImage imageNamed:@"searchButton"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UIButton*)messageButton
{
    
    if (!_messageButton) {
        UIImage * messageImage = [UIImage imageNamed:@"message_pink"];
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
        [_messageButton setImage:messageImage forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _messageButton;
    
    
}
-(void)searchButtonClick:(UIButton*)sender

{
    [self.navigationController pushViewController:[SearchViewController viewController] animated:YES];
}


-(void)messageClick:(UIButton*)sender
{
    NSLog(@"message");
    
    MyMessageViewController * messageVc = [MyMessageViewController viewController];
    [self.navigationController pushViewController:messageVc animated:YES];
    

    
}

-(void)setUpDatas
{
    NSArray *data = [UserDefaultsUtils valueWithKey:@"goodCatList"];
    _categoryArray = data;
    if (_categoryArray.count>0) {
        _titleArray = [NSMutableArray array];
        _catIdArray = [NSMutableArray array];
        for (NSDictionary * dict in _categoryArray) {
            NSString * catid = [dict valueForKey:@"cat_id"];
            NSString * title = [dict valueForKey:@"cat_name"];
            
            [_catIdArray addObject:catid];
            [_titleArray addObject:title];
        }
        [self initScroll];
    }
}


-(void)initScroll
{
    self.contentSmallSV = [[UIView alloc] initWithFrame:CGRectMake(0, 64*2,SCREEN_WIDTH , 40)];
    UIButton *fenlei = [UIButton buttonWithType:UIButtonTypeCustom];
    [fenlei setFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/7, 0, 60, self.contentSmallSV.height)];
    [fenlei setBackgroundImage:[UIImage imageNamed:@"catbutton"] forState:UIControlStateNormal];
    [fenlei addTarget:self action:@selector(fenleiAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentSmallSV addSubview:fenlei];
    
    
    smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH-60, 40)];
    smallScrollView.backgroundColor = [UIColor whiteColor];
    smallScrollView.bounces = YES;
    smallScrollView.pagingEnabled = YES;
    smallScrollView.showsHorizontalScrollIndicator = NO;
    smallScrollView.showsVerticalScrollIndicator = NO;
    smallScrollView.opaque = YES;
    [self addLable];
    
    ShopsTitle *lable = [smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    [self.contentSmallSV addSubview:smallScrollView];
    [self.contentSmallSV bringSubviewToFront:fenlei];
}
/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < [self.categoryArray count]; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        ShopsTitle *lbl1 = [[ShopsTitle alloc]init];
        lbl1.text = [_titleArray objectAtIndex:i];
        NSLog(@"%@",_titleArray[i]);
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    smallScrollView.contentSize = CGSizeMake(70 * [_titleArray count]+SCREEN_WIDTH/7, 0);
    
}
/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    ShopsTitle *titlelable = (ShopsTitle *)recognizer.view;
    CGFloat offsetX = titlelable.tag * bigScrollView.frame.size.width;
    CGFloat offsetY = bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [bigScrollView setContentOffset:offset animated:YES];
    _cat_id = self.catIdArray[titlelable.tag];
    
    NSLog(@" %@ ",_cat_id);
    
    
   [self.tableView.mj_header beginRefreshing];
}
#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView==smallScrollView) {
        // 获得索引
        NSUInteger index = scrollView.contentOffset.x /bigScrollView.frame.size.width;
        // 滚动标题栏
        ShopsTitle *titleLable = (ShopsTitle *)smallScrollView.subviews[index];
        
        CGFloat offsetx = titleLable.center.x - smallScrollView.frame.size.width * 0.5;
        
        CGFloat offsetMax =smallScrollView.contentSize.width -smallScrollView.frame.size.width;
        
        
        
        if (offsetx < 0) {
            offsetx = 0;
        }else if (offsetx > offsetMax){
            offsetx = offsetMax;
        }
        
        CGPoint offset = CGPointMake(offsetx,smallScrollView.contentOffset.y);
        [smallScrollView setContentOffset:offset animated:YES];
    }
    
    
    
    
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/*********分类**********/
- (void)fenleiAction
{
    ClassifyViewController *pushVC = [[ClassifyViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.brandArray.count) {
        static NSString * brandCell = @"brandCell";
        
        
        BrandCell * cell = [tableView dequeueReusableCellWithIdentifier:brandCell];
        
        if (!cell) {
            cell = [[BrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:brandCell];
            
        }
        brandModel * brandModel = self.brandArray[indexPath.row];
        cell.model = brandModel;
        return cell;
    }else{
        
        NSInteger index = indexPath.row- self.brandArray.count;
        
        ProductGoodsModel * goodsModel = self.goodsList[index];
        
        goodsModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        
        static NSString * goodsTableViewCell = @"ProductGoodsCell";
        
        ProductGoodsCell * goodscell = [tableView dequeueReusableCellWithIdentifier:goodsTableViewCell];
        
        if (!goodscell) {
            
            goodscell = [[ProductGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsTableViewCell];
            
            goodscell.delegate = self;
            
        }
        
        goodscell.goodsModel = goodsModel;
        
        
        return goodscell;
    }
    
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brandArray.count+self.goodsList.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.contentSmallSV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.brandArray.count) {
        return 102*Proportion;
    }else{
        return 100;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row<self.brandArray.count) {
      
        brandModel * brandModel = self.brandArray[indexPath.row];
        
        brandGoodsViewController * Vc = [brandGoodsViewController viewController];
        Vc.group_id = brandModel.group_id;
        
        [self.navigationController pushViewController:Vc animated:YES];
        
        
    }else{
      
        NSInteger index = indexPath.row- self.brandArray.count;
        
        ProductGoodsModel * goodsModel = self.goodsList[index];
        
        TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
        //    NSNumber *realitemId= [[[NSNumberFormatter alloc]init] numberFromString:_tradeTestData.realItemId];
        
        ALBBTradeTaokeParams *taoKeParams=[[ALBBTradeTaokeParams alloc] init];
        taoKeParams.pid= goodsModel.goods_id;
        
        ALBBTradePage *page=[ALBBTradePage itemDetailPage:goodsModel.goods_id params:nil];
        //params 指定isv code等。
        [_tradeService  show:self.navigationController isNeedPush:NO webViewUISettings:viewSettings page:page taoKeParams:taoKeParams tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
        
        
    }
}

-(TaeWebViewUISettings *)getWebViewSetting{
    
    TaeWebViewUISettings *settings = [[TaeWebViewUISettings alloc] init];
    settings.titleColor = [UIColor blueColor];
    settings.tintColor = [UIColor redColor];
    settings.barTintColor = kNavBackGround;
    
    return settings;
}

-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;

{
    ProductGoodsModel * goodsModel = (ProductGoodsModel *)celldata;
    
    if ([goodsModel.user_id length]>0) {
        [HDHud showMessageInView:self.view title:@"您已关注过该商品"];
    }else
    {
        UIButton * btn = (UIButton*)sender;
        
        btn.userInteractionEnabled = NO;
        
        if(!userSession)
        {
            userSession = [SingleManage shareManage];
        }
        
        
        
        if (userSession.isLogin) {
            
            [HDHud showHUDInView:self.view title:@"关注中..."];
            
            NSString * goodID = [NSString stringWithFormat:@"%@",goodsModel.goods_id];
            NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:goodID,@"goods_id", nil];
            
            
            
            GXHttpRequest *request = [[GXHttpRequest alloc]init];
            
            [request RequestDataWithUrl:URL_DoAttentStoreGoods pragma:postDict];
            
            [request getResultWithSuccess:^(id response) {
                /// 加保护
                if ([response isKindOfClass:[NSDictionary class]])
                {
                    
                    //加载框消失
                    [HDHud hideHUDInView:self.view];
                    
                    
                    btn.userInteractionEnabled = YES;
                    
                    [btn setTitle:@"已关注" forState:UIControlStateNormal];
                    
                }
                
            } DataFaiure:^(id error) {
                [HDHud hideHUDInView:self.view];
                [HDHud showMessageInView:self.view title:error];
                
                btn.userInteractionEnabled = YES;
            } Failure:^(id error) {
                [HDHud hideHUDInView:self.view];
                [HDHud showNetWorkErrorInView:self.view];
                
                btn.userInteractionEnabled = YES;
            }];
            
            
        }else if(!userSession.isLogin)
        {
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        
        
        
    }
    
    
}

#pragma mark - end tableView

#pragma mark - request
//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    [self hideNoDataView];
    
    NSDictionary * parameter = @{@"num":@"10",@"page":@(_page),@"cat_id":_cat_id};
    
    NSLog(@"  %@ ",parameter);
    
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetStoreGoodsByCatId pragma:parameter];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if (Type==1) {
                self.brandArray = [NSMutableArray array];
                self.goodsList = [NSMutableArray array];
            }
            NSArray *array1 = [[response valueForKey:@"result"] valueForKey:@"brand_group"];
            
            NSArray *array2 = [[response valueForKey:@"result"] valueForKey:@"goods_list"];
            //列表数据
            
            if ( IS_ARRAY_CLASS(array1))
            {
                self.brandArray = [brandModel mj_objectArrayWithKeyValuesArray:array1];
            }
            if (IS_ARRAY_CLASS(array2)) {
                
                NSArray *goods = [ProductGoodsModel mj_objectArrayWithKeyValuesArray:array2];
                [self.goodsList addObjectsFromArray:goods];
                [self stopLoadData];
                [self.tableView reloadData];
                
                

                
            }
        }
        
    } DataFaiure:^(id error) {
        [self stopLoadData];
        [HDHud showMessageInView:self.view title:error];
    } Failure:^(id error) {
        [self stopLoadData];
        [HDHud showNetWorkErrorInView:self.view];
    }];
}

//停止刷新
-(void)stopLoadData
{
    [HDHud hideHUDInView:self.view];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - end request
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
