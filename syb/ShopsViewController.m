//
//  ShopsViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ShopsViewController.h"
#import "LoginViewController.h"
#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>
#import "shopGoodsViewController.h"
@interface ShopsViewController ()

@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;

@end

@implementation ShopsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self setupDatas];
    [self setupViews];
    _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  
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
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id1,@"cat_id",_page,@"page", nil];

 
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_StoreListByCat pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
  
            _ShopsListArray = [[response valueForKey:@"result"] valueForKey:@"data"];
            
            NSLog(@" %@ ",_ShopsListArray);
            
                _ModelArray = [ShopsModel mj_objectArrayWithKeyValuesArray:_ShopsListArray];
                
                
                if (Type == 1) {
                    _ShopsList = [NSMutableArray arrayWithArray:_ModelArray];
                    [self stopLoadData];
                    [_TableView reloadData];
                    
                }else if(Type == 2){
                    
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:_ShopsList];
                    [Array addObjectsFromArray:_ModelArray];
                    _ShopsList = Array;
                    [self stopLoadData];
                    [_TableView reloadData];
                }

                
                
                
                
                if ([_ShopsList count]>9) {
                    
                    __unsafe_unretained __typeof(self) weakSelf = self;
                    
                    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        // 进入刷新状态后会自动调用这个block
                        [weakSelf loadMoreData];
                    }];
                    
                    
                }
                if([_ShopsList count]==0)
                    
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
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight-113) style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.backgroundColor = kDefaultBackgroundColor;
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


#pragma mark TableView Datasorce;

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90*Proportion+80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 9.9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_ShopsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ShopsModel * shopModel = _ShopsList[indexPath.section];
    shopModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    static NSString * cellID = @"ShopCell";
    ShopsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[ShopsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopsModel = shopModel;
    cell.delegate = self;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopsModel * shopModel = _ShopsList[indexPath.section];
 
    shopGoodsViewController * shopGoodsVc = [shopGoodsViewController viewController];
    shopGoodsVc.shop_id = shopModel.shop_id;
    
    [self.navigationController pushViewController:shopGoodsVc animated:YES];
    
}


-(TaeWebViewUISettings *)getWebViewSetting{
    
    TaeWebViewUISettings *settings = [[TaeWebViewUISettings alloc] init];
    settings.titleColor = [UIColor blueColor];
    settings.tintColor = [UIColor redColor];
    settings.barTintColor = kNavBackGround;
    
    return settings;
}


-(void)goodsButtonClickWithDict:(NSDictionary*)dict;
{
  
    NSString * goodId = [dict valueForKey:@"goods_id"];
    
    
    if(!userSession)
    {
        userSession = [SybSession sharedSession];
    }
    
    
    
    if (userSession.isLogin) {
        
      
        TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
        //    NSNumber *realitemId= [[[NSNumberFormatter alloc]init] numberFromString:_tradeTestData.realItemId];
        
        ALBBTradeTaokeParams *taoKeParams=[[ALBBTradeTaokeParams alloc] init];
        taoKeParams.pid= goodId;
        
        
        NSMutableDictionary * customDict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:userSession.userID,@"isv_code",nil];
        
        NSLog(@"用户ID参数是 %@ ",customDict);
        
        ALBBTradePage *page=[ALBBTradePage itemDetailPage:goodId params:customDict];
        
        
        //params 指定isv code等。
        [_tradeService  show:self.navigationController isNeedPush:NO webViewUISettings:viewSettings page:page taoKeParams:taoKeParams tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
        
    }else if(!userSession.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
#pragma TableViewDelegate
-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;
{
    NSLog(@" attention");
    
    
    ShopsModel * shopModel = (ShopsModel*)celldata;
    
    if ([shopModel.user_id length]>0) {
        [HDHud showMessageInView:self.view title:@"您已关注过该店铺"];
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
            
            NSString * shopID = [NSString stringWithFormat:@"%@",shopModel.shop_id];
            NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id", nil];
            
            
            
            GXHttpRequest *request = [[GXHttpRequest alloc]init];
            
            [request RequestDataWithUrl:URL_DoAttentShop pragma:postDict];
            
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
