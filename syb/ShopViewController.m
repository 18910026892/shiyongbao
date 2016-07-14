//
//  ShopViewController.m
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "WebViewController.h"
#import "CommodityViewController.h"
@implementation ShopViewController
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
    
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }
   [MobClick beginLogPageView:@"店铺分类"];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"店铺分类"];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self OtherSetup];
    [self PageLayout];

}


//页面设置
-(void)PageSetup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.navigationItem.hidesBackButton = YES;
    
}
//其他设置
-(void)OtherSetup
{
    self.update = YES;
    
}

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id1,@"cat_id",_page,@"page", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_ShopList pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
 
   
        _ShopsListArray = [obj valueForKey:@"result"];
    
        
        _ModelArray = [ShopsModel mj_objectArrayWithKeyValuesArray:_ShopsListArray];
    
        
        if (Type == 1) {
            _ShopsList = [NSMutableArray arrayWithArray:_ModelArray];
            [TableView.header endRefreshing];
            [TableView reloadData];
            
        }else if(Type == 2){
            
            NSMutableArray * Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:_ShopsList];
            [Array addObjectsFromArray:_ModelArray];
            _ShopsList = Array;
            [TableView.footer endRefreshing];
            [TableView reloadData];
        }
        
        if ([_ShopsList count]==0) {
            [HDHud showMessageInView:self.view title:@"暂无数据"];
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
#pragma menuViewDelegate

//页面布局
-(void)PageLayout
{
    
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT-153) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor clearColor];
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
    ShopsCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
   ShopsModel * shopModel = _ShopsList[indexPath.section];
   
    SM = [SingleManage shareManage];
    
    if (SM.isLogin) {
        
        if ([shopModel.shop_type isEqualToString:@"1"]) {
            
            WebViewController * webVC = [[WebViewController alloc]init];
            webVC.webViewType = WebViewTypeShiYongShuo;
            webVC.webTitle = shopModel.shop_name;
            webVC.requestURL = shopModel.shop_click_url;
       
           [self.navigationController pushViewController:webVC animated:YES];
        }
        else if ([shopModel.shop_type isEqualToString:@"2"])
        {
            
            CommodityViewController * commodityVC = [[CommodityViewController alloc]init];
            commodityVC.shop_id = shopModel.shop_id;
            commodityVC.title = shopModel.shop_name;
            [self.navigationController pushViewController:commodityVC animated:YES];
        }
        
        
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
    
}
-(void)attentionButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
    ShopsModel * shopModel = _ShopsList[btn.tag];
    btn.userInteractionEnabled = NO;
    SM = [SingleManage shareManage];
    
    if (SM.isLogin) {
        
        [HDHud showHUDInView:self.view title:@"正在关注..."];
        
        NSString * shopID = [NSString stringWithFormat:@"%@",shopModel.shop_id];
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
                
                shopModel.user_id = user_id;
                shopModel.atte_count = attentCount;
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
@end
