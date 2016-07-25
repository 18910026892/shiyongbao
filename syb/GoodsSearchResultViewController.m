//
//  GoodsSearchResultViewController.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GoodsSearchResultViewController.h"
#import "SybWebViewController.h"
#import "LoginViewController.h"

#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>
@interface GoodsSearchResultViewController ()
@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;

@end
@implementation GoodsSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self showBackButton:YES];
    [self setupDatas];
    [self setupViews];
    
        _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
}

-(void)setupViews
{
    [self.Customview addSubview:self.searchButton];
    [self.view addSubview:self.TableView];
}

#pragma mark - ********************** Functions **********************

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    [self hideNoDataView];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_KeyWord,@"keyword",_page,@"page", nil];
    
    NSLog(@" %@ ",postDict);
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_SearchStoreGoodsList pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            

            
            NSDictionary * resultDict = [response valueForKey:@"result"];
            
            NSMutableArray * tableArray = [resultDict valueForKey:@"data"];
            
            NSLog(@" %@ ",response);
            
            if (IS_ARRAY_CLASS(tableArray)) {
                
       
                
                _ModelArray = [GoodsSearchModel mj_objectArrayWithKeyValuesArray:tableArray];
                
                if (Type == 1) {
                    _GoodsList = [NSMutableArray arrayWithArray:_ModelArray];
                    [self stopLoadData];
                    [self.TableView reloadData];
                    
                }else if(Type == 2){
                    
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:_GoodsList];
                    [Array addObjectsFromArray:_ModelArray];
                    _GoodsList = Array;
                    [self stopLoadData];
                    [self.TableView reloadData];
                }
                
                
                if ([_GoodsList count]>9) {
                    
                    __unsafe_unretained __typeof(self) weakSelf = self;
                    
                    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        // 进入刷新状态后会自动调用这个block
                        [weakSelf loadMoreData];
                    }];
                    
                    
                }
                if([_GoodsList count]==0)
                    
                {
                    [HDHud showMessageInView:self.view title:@"暂无数据"];
                }
                
                
        
                
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
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStylePlain];
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


-(UIButton*)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(kMainScreenWidth/2-120, 28, 240, 28);
        [_searchButton setTitle:@"搜索商品/店铺" forState:UIControlStateNormal];
        [_searchButton setTitleColor:RGBACOLOR(120, 120, 120, 1) forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _searchButton.layer.cornerRadius = 5;
        _searchButton.layer.borderWidth = 0.4;
        _searchButton.layer.borderColor = [UIColor grayColor].CGColor;
        _searchButton.backgroundColor = [UIColor whiteColor];
        [_searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;

}


-(void)searchClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
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
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return [_GoodsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    GoodsSearchModel * goodsModel = _GoodsList[indexPath.row];
    
    goodsModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    static NSString * cellID = @"GoodsCell";
    GoodsSearchTableViewCell * cell = [_TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[GoodsSearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.goodsModel = goodsModel;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductGoodsModel * goodsModel = _GoodsList[indexPath.row];
    
    TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
    //    NSNumber *realitemId= [[[NSNumberFormatter alloc]init] numberFromString:_tradeTestData.realItemId];
    
    ALBBTradeTaokeParams *taoKeParams=[[ALBBTradeTaokeParams alloc] init];
    taoKeParams.pid= goodsModel.goods_id;
    
    ALBBTradePage *page=[ALBBTradePage itemDetailPage:goodsModel.goods_id params:nil];
    //params 指定isv code等。
    [_tradeService  show:self.navigationController isNeedPush:NO webViewUISettings:viewSettings page:page taoKeParams:taoKeParams tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
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
    GoodsSearchModel * goodsModel = (GoodsSearchModel *)celldata;
    
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
