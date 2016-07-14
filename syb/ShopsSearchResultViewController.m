//
//  ShopsSearchResultViewController.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsSearchResultViewController.h"
#import "LoginViewController.h"
#import "SybWebViewController.h"
//#import "CommodityViewController.h"
@implementation ShopsSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self showBackButton:YES];
    [self setupDatas];
    [self setupViews];
    
    
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
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_SearchShopList pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            _ShopsListArray = [response valueForKey:@"result"];
            
            _ModelArray = [ShopsSearchModel mj_objectArrayWithKeyValuesArray:_ShopsListArray];
            
            if (Type == 1) {
                _ShopsList = [NSMutableArray arrayWithArray:_ModelArray];
                [_TableView.mj_header endRefreshing];
                [_TableView reloadData];
                
            }else if(Type == 2){
                
                NSMutableArray * Array = [[NSMutableArray alloc] init];
                [Array addObjectsFromArray:_ShopsList];
                [Array addObjectsFromArray:_ModelArray];
                _ShopsList = Array;
                [_TableView.mj_footer endRefreshing];
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
            
            
            if([_ShopsListArray count]==0)
            {
                [self.TableView.mj_footer endRefreshingWithNoMoreData];
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
    return 90*Proportion+80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 9.9;
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
    ShopsSearchModel * shopModel = _ShopsList[indexPath.section];
    shopModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    static NSString * cellID = @"ShopCell";
    ShopSearchTableViewCell * cell = [_TableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[ShopSearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ShopsSearchModel = shopModel;
    cell.delegate = self;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ShopsSearchModel * shopModel = _ShopsList[indexPath.section];
    
    
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    
    if (userSession.isLogin) {
        
        if ([shopModel.shop_type isEqualToString:@"1"]) {
            
            SybWebViewController * webVC = [[SybWebViewController alloc]init];
            webVC.WebTitle = shopModel.shop_name;
            webVC.RequestUlr = shopModel.shop_click_url;
           
            [self.navigationController pushViewController:webVC animated:YES];
        }
//        else if ([shopModel.shop_type isEqualToString:@"2"])
//        {
//            
//            CommodityViewController * commodityVC = [[CommodityViewController alloc]init];
//            commodityVC.shop_id = shopModel.shop_id;
//            commodityVC.title = shopModel.shop_name;
//            [self.navigationController pushViewController:commodityVC animated:YES];
//        }
//        
//        
        
    }else if(!userSession.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
    
}
-(void)attentionButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
     ShopsSearchModel * shopModel = _ShopsList[btn.tag];
    btn.userInteractionEnabled = NO;
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    
    if (userSession.isLogin) {
        
        [HDHud showHUDInView:self.view title:@"正在关注..."];
        
        NSString * shopID = [NSString stringWithFormat:@"%@",shopModel.shop_id];
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id", nil];

        
        GXHttpRequest *request = [[GXHttpRequest alloc]init];
        
        [request RequestDataWithUrl:URL_DoAttentShop pragma:postDict];
        
        [request getResultWithSuccess:^(id response) {
            /// 加保护
            if ([response isKindOfClass:[NSDictionary class]])
            {
                  [HDHud hideHUDInView:self.view];
                btn.userInteractionEnabled = YES;
                NSDictionary * resultDict = [response valueForKey:@"result"];
                NSString * attentCount = [resultDict valueForKey:@"atte_count"];
                NSString * user_id = userSession.userID;
                
                shopModel.user_id = user_id;
                shopModel.atte_count = attentCount;
                [_TableView reloadData];
                
            }
            
        } DataFaiure:^(id error) {
            btn.userInteractionEnabled = YES;
       
            [HDHud showMessageInView:self.view title:error];
        } Failure:^(id error) {
            btn.userInteractionEnabled = YES;
         
            [HDHud showNetWorkErrorInView:self.view];
        }];
        
        
        
    }else if(!userSession.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}


@end
