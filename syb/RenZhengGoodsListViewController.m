//
//  RenZhengGoodsListViewController.m
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RenZhengGoodsListViewController.h"
#import "RenZhengGoodsDetailViewController.h"
@implementation RenZhengGoodsListViewController
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
    [self initBackButton];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
     [MobClick beginLogPageView:@"认证详情1"];
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

    [MobClick endLogPageView:@"认证详情1"];
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
    self.navigationItem.title = @"认证商品";
    
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
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getQtAuthenticationGoods pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        NSLog(@"%@",obj);
        

        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        _ModelArray = [RenZhengGoodsModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        
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
            [HDHud showMessageInView:self.view title:@"暂无结果"];
        }else if ([_GoodsList count]>9)
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

#pragma mark - morecell method
#pragma mark 加载更多相关
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    float y = TableView.contentOffset.y;
    int x = [_page intValue];
    float z = x * SCREEN_HEIGHT;
    if (y>z) {
          [self loadMoreData];
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
//设置请求参数
-(void)addParameter
{
    _page = @"1";
}
//更新数据
-(void)headerRereshing
{
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
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
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
    return 128*Proportion;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_GoodsList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    RenZhengGoodsModel * renZhengModel = _GoodsList[indexPath.section];
    
    static NSString * cellID = @"GoodsCell";
    RenZhengGoodsCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[RenZhengGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.renzhengmodel = renZhengModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    RenZhengGoodsModel * renZhengModel = _GoodsList[indexPath.section];
    RenZhengGoodsDetailViewController * rzgdVc =[[RenZhengGoodsDetailViewController alloc]init];
    rzgdVc.model = renZhengModel;
    [self.navigationController pushViewController:rzgdVc animated:YES];
    
}

@end
