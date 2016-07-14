//
//  MyOrderViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderDetailViewController.h"
@implementation MyOrderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    [MobClick beginLogPageView:@"我的订单"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"我的订单"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"我的订单"];
    [self showBackButton:YES];
    [self setupViews];
    
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
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page", nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GoodsOrderRecord pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            NSLog(@" %@ ",response);
       
            _tableArray = [response valueForKey:@"result"];
            
            if (IS_ARRAY_CLASS(_tableArray)) {
                
                _tableModelArray = [OrderModel mj_objectArrayWithKeyValuesArray:_tableArray];
                
                if (Type == 1) {
                    _tableListArray = [NSMutableArray arrayWithArray:_tableModelArray];
                    [self stopLoadData];
                    [_TableView reloadData];
                    
                }else if(Type == 2){
                    
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:_tableListArray];
                    [Array addObjectsFromArray:_tableModelArray];
                    _tableListArray = Array;
                    [self stopLoadData];
                    [_TableView reloadData];
                }
                
                
                
                
                if ([_tableListArray count]>9) {
                    
                    __unsafe_unretained __typeof(self) weakSelf = self;
                    
                    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        // 进入刷新状态后会自动调用这个block
                        [weakSelf loadMoreData];
                    }];
                    
                    
                }
                if([_tableListArray count]==0)
                    
                {
                    [HDHud showMessageInView:self.view title:@"暂无数据"];
                }
                
                
                if([_tableArray count]==0)
                {
                    [self.TableView.mj_footer endRefreshingWithNoMoreData];
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
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    OrderModel * orderModel = _tableListArray[indexPath.section];
    return    [OrderCell CellRowHeightForObject:orderModel];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_tableListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 6.99;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    //初始化每行的数据模型
    OrderModel * orderModel = _tableListArray[indexPath.section];
    
    static NSString * cellID = @"OrderCell";
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.orderModel = orderModel;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
     OrderModel * orderModel = _tableListArray[indexPath.section];
    
    OrderDetailViewController * odVc = [OrderDetailViewController viewController];
    odVc.orderModel = orderModel;
    [self.navigationController pushViewController:odVc animated:YES];
    
    
}
-(void)cellselect:(OrderModel *)model;
{
    OrderDetailViewController * odVc = [OrderDetailViewController viewController];
    odVc.orderModel = model;
    [self.navigationController pushViewController:odVc animated:YES];
}

@end
