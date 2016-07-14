//
//  ZhengPin312ViewController.m
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPin312ViewController.h"
#import "ReportViewController.h"
#import "ZhengPinDetailViewController.h"
@implementation ZhengPin312ViewController
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
    [self initReportButton];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
    [MobClick beginLogPageView:@"正品"];
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
-(void)initReportButton
{
    if (!reportButton) {
        UIImage * messageImage = [UIImage imageNamed:@"report"];
        reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reportButton.frame = CGRectMake(SCREEN_WIDTH-44,0, 44, 44);
        [reportButton setImage:messageImage forState:UIControlStateNormal];
        [reportButton addTarget:self action:@selector(reportButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationController.navigationBar addSubview:reportButton];
}
-(void)reportButtonClick:(UIButton*)sender
{
    NSLog(@"report");
    
    ReportViewController * reportVc = [[ReportViewController alloc]init];
    [self.navigationController pushViewController:reportVc animated:YES];
    
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
    [reportButton removeFromSuperview];
    [MobClick endLogPageView:@"正品"];
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
    self.navigationItem.title = @"正品检测认证";
    
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
    [request StartWorkPostWithurlstr:URL_getQtGoodsZBList pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
    
        _zhengpinModelArray = [ZhenPin312Model mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        
        if (Type == 1) {
            _zhengpinListArray = [NSMutableArray arrayWithArray:_zhengpinModelArray];
            [TableView.header endRefreshing];
            [TableView reloadData];
            
        }else if(Type == 2){
            
            NSMutableArray * Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:_zhengpinListArray];
            [Array addObjectsFromArray:_zhengpinModelArray];
            _zhengpinListArray = Array;
            [TableView.footer endRefreshing];
            [TableView reloadData];
        }
        
        if ([_zhengpinListArray count]==0) {
            [HDHud showMessageInView:self.view title:@"暂无结果"];
        }else if ([_zhengpinListArray count]>9)
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
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return .0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .0001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_zhengpinListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    ZhenPin312Model * Model = _zhengpinListArray[indexPath.section];
    
    static NSString * cellID = @"GoodsCell";
    ZhenPin312Cell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[ZhenPin312Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.zhengpinModel = Model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    ZhenPin312Model * Model = _zhengpinListArray[indexPath.section];
    
    ZhengPinDetailViewController * zpdVc = [[ZhengPinDetailViewController alloc]init];
    zpdVc.ZhengPinModel = Model;
    [self.navigationController pushViewController:zpdVc animated:YES];
    

    
}


@end
