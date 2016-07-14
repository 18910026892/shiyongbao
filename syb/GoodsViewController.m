//
//  GoodsViewController.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GoodsViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
@implementation GoodsViewController
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
    
     [MobClick beginLogPageView:@"商品列表"];
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
    [MobClick endLogPageView:@"商品列表"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Finish = NO;
    [self getGoodsFilterList];    
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

//请求条件
-(void)getGoodsFilterList
{
   

    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id,@"cat_id", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GoodsFilterList pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
       
        _backDict = [obj valueForKey:@"result"];
       
        NSLog(@"^^^%@",_backDict);
        
        //初始化最终的数组
        _FinalArray = [NSMutableArray array];
        
        //初始化筛选数组
        _ScreeningArray = [_backDict valueForKey:@"cond"];
        
        //初始化排序对象
        _SortDict = [_backDict valueForKey:@"order"];
        
        //便利排序条件的数组
        _Item1Array = [NSMutableArray array];
        
        NSString * kv = [_SortDict valueForKey:@"order_para"];
        NSString * vv = [_SortDict valueForKey:@"order_name"];
        
        NSDictionary * dict4 =  @{ @"k" : kv, @"v" :vv};
        [_Item1Array addObject:dict4];
        
        NSMutableArray * arr2 = [_SortDict valueForKey:@"order_list"];
        
        for (NSDictionary * dict6 in arr2) {
            [_Item1Array addObject:dict6];
        }
        
        if ([arr2 count]==0)
        {
            NSLog(@"没有可以添加筛选的条件");
        }else
        {
            [_FinalArray addObject:_Item1Array];
        }
        

        //便利筛选条件的数组
        for (NSDictionary * dict1 in _ScreeningArray) {
            
            //初始化元素数组
            _Item2Array = [NSMutableArray array];
            
            NSString * kv = [dict1 valueForKey:@"cond_para"];
            NSString * vv = [dict1 valueForKey:@"cond_name"];
            NSDictionary * dict2 =  @{ @"k" : kv, @"v" :vv};
            [_Item2Array addObject:dict2];
            
            NSMutableArray * arr1 = [dict1 valueForKey:@"cond_list"];
            
            for (NSDictionary * dict3 in arr1) {
                
               [_Item2Array addObject:dict3];
                
            }
            if ([arr1 count]==0)
            {
                NSLog(@"没有可以添加筛选的条件");
            }else
            {
                  [_FinalArray addObject:_Item2Array];
            }
         
            
          
 
  
        }
        
        NSLog(@"最终的数组^^^%@",_FinalArray);
        
        [self InitMenuView];
    };
    request.failureGetData = ^(void){
        
        [TableView.header endRefreshing];        
        [HDHud showNetWorkErrorInView:self.view];
    };

}
//请求数据的方法
-(void)requestDataWithPage:(int)Type ScreenDict:(NSMutableDictionary*)dict
{
  
    NSDictionary * PostDict;
    
 
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id,@"cat_id",_page,@"page", nil];
    
    
    if (dict) {
        PostDict = dict;
    }else
    {
        PostDict = postDict;
    }

   
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_ShopGoodsList pragma:PostDict ImageData:nil];

    request.successGetData = ^(id obj){
        

        
        _objDict = [obj valueForKey:@"result"];
       
        //最后拿到的参数字典
        _paraDict = [_objDict valueForKey:@"para"];
        
        
        //第一次参数字典
        if (!_Finish) {
            _FirstDict = [_objDict valueForKey:@"para"];
            _Finish = YES;
        }
  
        _ModelArray = [GoodsModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"data"]];
        
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
    };
    request.failureGetData = ^(void){
        
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
    [self requestDataWithPage:1 ScreenDict:_postDict];
}
//加载更多数据
-(void)loadMoreData
{
    int page = [_page intValue];
    page ++;
    _page = [NSString stringWithFormat:@"%d",page];
    [self requestDataWithPage:2 ScreenDict:_postDict];
}
#pragma menuViewDelegate

-(void)InitMenuView
{
    if (!menuView) {
        
        menuView  = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
        menuView.dataSource = self;
        menuView.delegate = self;
        [self.view addSubview:menuView];
    }

}
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return [_FinalArray count];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    
    NSArray * array = [_FinalArray objectAtIndex:column];
    return [array count];
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    NSArray * array = [_FinalArray objectAtIndex:indexPath.column];
    
    NSString * title = [array[indexPath.row] valueForKey:@"v"];
    
    return title;
    
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
   
    //获取用户索引条件的数组
    NSArray * postArray = [_FinalArray objectAtIndex:indexPath.column];
 
    //取这个数组的第一个对象
     NSString * key = [postArray[0]valueForKey:@"k"];
    //取要传的参数值
     NSString * newvalue = [postArray[indexPath.row]valueForKey:@"k"];

    //判断当选择第一个默认条件的时
    if ([key isEqualToString:newvalue]) {
        
        _postDict = [NSMutableDictionary dictionaryWithDictionary:_paraDict];
        [_postDict removeObjectForKey:key];
        
    }else
    {
        _postDict = [NSMutableDictionary dictionaryWithDictionary:_paraDict];
        
         [_postDict setObject:newvalue forKey:key];
        
    }


    
  [self requestDataWithPage:1 ScreenDict:_postDict];
}


//页面布局
-(void)PageLayout
{

    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,103,SCREEN_WIDTH, SCREEN_HEIGHT-103) style:UITableViewStyleGrouped];
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
    GoodsModel * goodsModel = _GoodsList[indexPath.row];
    
    static NSString * cellID = @"GoodsCell";
    GoodsCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.GoodsModel = goodsModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型

    GoodsModel * goodsModel = _GoodsList[indexPath.row];
    
    SM = [SingleManage shareManage];
    if (SM.isLogin&&![goodsModel.goods_click_url isEmpty]) {
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webViewType = WebViewTypeShiYongShuo;
        webVC.requestURL = goodsModel.goods_click_url;
        webVC.webTitle = goodsModel.goods_title;
        [self.navigationController pushViewController:webVC animated:YES];
    }if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    

    
}

@end
