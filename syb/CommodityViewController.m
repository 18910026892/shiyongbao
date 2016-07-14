//
//  CommodityViewController.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "CommodityViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
@implementation CommodityViewController
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"&&&&&%@",_shop_id);
    [self PageSetup];
    
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }
    [self initBackButton];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
  
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
   // _shop_id = @"101";
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_shop_id,@"shop_id",_page,@"page", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_ShopGoodsListByShop pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        

        _objDict = [obj valueForKey:@"result"];
        
        
        _ModelArray = [CommodityModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"data"]];
        
        if (Type == 1) {
            _GoodsList = [NSMutableArray arrayWithArray:_ModelArray];
            [TableView.header endRefreshing];
            [TableView reloadData];
            
        }else if(Type == 2){
            
            NSMutableArray * Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:_GoodsList];
            [Array addObjectsFromArray:_ModelArray];
            _GoodsList = Array;
            [TableView.footer endRefreshing];
            [TableView reloadData];
        }
        
        if ([_GoodsList count]==0) {
            [HDHud showMessageInView:self.view title:@"暂无数据"];
        }else if([_GoodsList count]>9)
        {
            [TableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            [TableView reloadData];
            
        }
        
        
        
        NSLog(@" %@****%@*****%lu",postDict,_objDict,(unsigned long)[_GoodsList count]);
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

//页面布局
-(void)PageLayout
{
    
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    CommodityModel * commodityModel = _GoodsList[indexPath.row];
    
    static NSString * cellID = @"GoodsCell";
    CommodityTableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[CommodityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.CommodityModel = commodityModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    
   CommodityModel * commodityModel = _GoodsList[indexPath.row];
    
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webViewType = WebViewTypeShiYongShuo;
        webVC.requestURL = commodityModel.goods_click_url;
        webVC.webTitle = commodityModel.goods_title;
        [self.navigationController pushViewController:webVC animated:YES];
    }if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}



@end
