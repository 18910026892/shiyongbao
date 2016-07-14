//
//  AttentionShopsViewController.m
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "AttentionShopsViewController.h"
#import "WebViewController.h"
#import "CommodityViewController.h"
@implementation AttentionShopsViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"关注的店铺";
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initBackButton];
    
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }
     [MobClick beginLogPageView:@"关注的店铺"];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self OtherSetup];
    [self addParameter];
    [self PageLayout];
    
}
//页面设置
-(void)PageSetup
{
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
}
//其他设置
-(void)OtherSetup
{
    self.update = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
   
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page", nil];
    
    NSString * requestUrl = [NSString stringWithFormat:@"%@",URL_AttentedShop];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:requestUrl pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
        NSLog(@"^^%@",obj);
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        _ShopsListArray = [_objDict valueForKey:@"result"];
        
        _ModelArray = [AttentionShopsDto mj_objectArrayWithKeyValuesArray:_ShopsListArray];
        
        if (Type == 1) {
            _ShopsList = [NSMutableArray arrayWithArray:_ModelArray];
            [TableView.header endRefreshing];
            [TableView reloadData];
        }else if(Type == 2){
            
            NSMutableArray *Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:_ShopsList];
            [Array addObjectsFromArray:_ModelArray];
            _ShopsList = Array;
            [TableView.footer endRefreshing];
            [TableView reloadData];
        }
        
        if ([_ShopsList count]==0) {
            [HDHud showMessageInView:self.view title:@"您还没有关注的店铺!"];
        }else if([_ShopsList count]>9)
        {
            [TableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            [TableView reloadData];
            
        }
        
    };
    request.failureGetData = ^(void){
        
        [TableView.header endRefreshing];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}
//添加更新控件
-(void)addRefresh
{
    
    [TableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [TableView.header setTitle:@"下拉可以刷新了" forState:MJRefreshHeaderStateIdle];
    [TableView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [TableView.header setTitle:@"正在刷新 ..." forState:MJRefreshHeaderStateRefreshing];
}
//设置请求参数
-(void)addParameter
{
    _page = @"1";
}
//更新数据
-(void)headerRereshing
{
    [self addParameter];
    [self requestDataWithPage:1];
}
//加载更多数据
-(void)loadMoreData
{
    int page = [_page intValue];
    page ++;
    _page = [NSString stringWithFormat:@"%d",page];
    [self requestDataWithPage:2];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
     [MobClick endLogPageView:@"关注的店铺"];
  
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
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}

//页面布局
-(void)PageLayout
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor = [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:TableView];
        [self addRefresh];
    }
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_ShopsList count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    AttentionShopsDto * attentionshopModel  = _ShopsList[indexPath.section];
    
    static NSString * cellID = @"ShopsCell";
    
    AttentionShopTableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[AttentionShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.attentionShopsModel = attentionshopModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AttentionShopsDto * attentionshopModel  = _ShopsList[indexPath.section];
        
        if ([attentionshopModel.shop_type isEqualToString:@"1"]) {
            
            WebViewController * webVC = [[WebViewController alloc]init];
            webVC.webViewType = WebViewTypeShiYongShuo;
            webVC.webTitle = attentionshopModel.shop_name;
            webVC.requestURL = attentionshopModel.shop_click_url;
            [self.navigationController pushViewController:webVC animated:YES];
        }
        else if ([attentionshopModel.shop_type isEqualToString:@"2"])
        {
            
            CommodityViewController * commodityVC = [[CommodityViewController alloc]init];
            commodityVC.shop_id = attentionshopModel.shop_id;
            commodityVC.title = attentionshopModel.shop_name;
            [self.navigationController pushViewController:commodityVC animated:YES];
        }
        
  
    

}



-(void)attentionButtonClick:(NSString*)value;
{
    [self deleteTheShopWithShopID:value];
    
    [HDHud showHUDInView:self.view title:@"取消中..."];
        
    NSString * shopID = value;
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id",  nil];
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_UndoAttentShop pragma:postDict ImageData:nil];
        
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            NSString * result = [obj valueForKey:@"code"];
            NSString * message = [obj valueForKey:@"message"];
            
            if ([result isEqualToString:@"0"]) {
                
                  [HDHud showMessageInView:self.view title:message];
                
            }else if ([result isEqualToString:@"1"])
            {
             
                [[NSNotificationCenter defaultCenter] postNotificationName:@"attention" object:nil];
                [HDHud showMessageInView:self.view title:message];
                [self deleteTheShopWithShopID:value];
            }
  
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
 
    
    
}
-(void)deleteTheShopWithShopID:(NSString*)shopID;
{

    NSString * shopid = shopID;
    
    [_ShopsList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      
        //模型赋值
        AttentionShopsDto * model = obj;
        
        if ([shopid isEqualToString:model.shop_id]) {
   
            NSLog(@"######%d",idx);
            [_ShopsList removeObjectAtIndex:idx];
          
            [TableView reloadData];
         
        }
        
    }];


  
}
@end
