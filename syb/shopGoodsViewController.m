//
//  shopGoodsViewController.m
//  syb
//
//  Created by GongXin on 16/7/19.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "shopGoodsViewController.h"
#import "LoginViewController.h"
#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>
@interface shopGoodsViewController ()
@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;

@end
@implementation shopGoodsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDatas];
    [self setupViews];
    
    [self showBackButton:YES];
    
    _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setNavTitle:_shop_name];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)setupViews
{
    
    [self.view addSubview:self.TableView];
}

#pragma mark - ********************** Functions **********************

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    [self hideNoDataView];
    
    NSDictionary * parameter = @{@"num":@"10",@"page":_page,@"store_id":_shop_id};
    
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetStoreGoodsByStoreId pragma:parameter];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"respones %@",response);
            
            NSMutableArray * array = [[response valueForKey:@"result"] valueForKey:@"goods_list"];
            
            //列表数据
            
            
            if (IS_ARRAY_CLASS(array)) {
                _goodArray = array;
                _goodModelArray = [ProductGoodsModel mj_objectArrayWithKeyValuesArray:_goodArray];
                
                if (Type == 1) {
                    _goodListArray = [NSMutableArray arrayWithArray:_goodModelArray];
                    [self stopLoadData];
                    [_TableView reloadData];
                    
                }else if(Type == 2){
                    
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:_goodListArray];
                    [Array addObjectsFromArray:_goodModelArray];
                    _goodListArray = Array;
                    [self stopLoadData];
                    [_TableView reloadData];
                }
                
                
            }
            
            
            if ([_goodListArray count]>9) {
                
                __unsafe_unretained __typeof(self) weakSelf = self;
                
                self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    // 进入刷新状态后会自动调用这个block
                    [weakSelf loadMoreData];
                }];
                
                
            }
            if([_goodListArray count]==0)
                
            {
                [HDHud showMessageInView:self.view title:@"暂无数据"];
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
    [_TableView.mj_header endRefreshing];
    [_TableView.mj_footer endRefreshing];
}

//设置请求参数
-(void)addParameter
{
    _page = @"1";
    
}

//加载更多数据
-(void)loadMoreData
{
    int page = [_page intValue];
    page ++;
    _page = [NSString stringWithFormat:@"%d",page];
    
    [self requestDataWithPage:2];
}


- (UITableView *)TableView
{
    if (!_TableView)
    {
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        __unsafe_unretained __typeof(self) weakSelf = self;
        
        self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf addParameter];
            [weakSelf requestDataWithPage:1];
        }];
        
        
        
        [self.TableView.mj_header beginRefreshing];
        
        
    }
    
    return _TableView;
}
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 107*Proportion;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_goodListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 6.99;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    ProductGoodsModel * goodsModel = _goodListArray[indexPath.section];
    
    goodsModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    
    static NSString * goodsTableViewCell = @"ProductGoodsCell";
    
    ProductGoodsCell * goodscell = [tableView dequeueReusableCellWithIdentifier:goodsTableViewCell];
    
    if (!goodscell) {
        
        goodscell = [[ProductGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsTableViewCell];
        
        goodscell.delegate = self;
        
    }
    
    goodscell.goodsModel = goodsModel;
    
    
    return goodscell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!userSession)
    {
        userSession = [SybSession sharedSession];
    }
    
    
    
    if (userSession.isLogin) {
        
        
        ProductGoodsModel * goodsModel = _goodListArray[indexPath.section];
        
        TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
        //    NSNumber *realitemId= [[[NSNumberFormatter alloc]init] numberFromString:_tradeTestData.realItemId];
        
        ALBBTradeTaokeParams *taoKeParams=[[ALBBTradeTaokeParams alloc] init];
        taoKeParams.pid= goodsModel.goods_id;
        
        
        NSMutableDictionary * customDict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:userSession.userID,@"isv_code",nil];
        
        NSLog(@"用户ID参数是 %@ ",customDict);
        
        ALBBTradePage *page=[ALBBTradePage itemDetailPage:goodsModel.goods_id params:customDict];
        
        
        //params 指定isv code等。
        [_tradeService  show:self.navigationController isNeedPush:NO webViewUISettings:viewSettings page:page taoKeParams:taoKeParams tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
        
    }else if(!userSession.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
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
             userSession = [SybSession sharedSession];
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
                    
                        [btn setTitleColor:HexRGBAlpha(0x999999, 1) forState:UIControlStateNormal];
                    
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

@end
