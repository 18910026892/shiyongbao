//
//  goodsAttentionViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "goodsAttentionViewController.h"

@implementation goodsAttentionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDatas];
    [self setupViews];
   
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
    
    NSDictionary * parameter = @{@"num":@"10",@"page":_page};
    

    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_AttentedStoreGoodsList  pragma:parameter];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            NSLog(@" %@ ",response);
            
            NSMutableArray * array = [response valueForKey:@"result"] ;
            
            //列表数据
            
            
            if (IS_ARRAY_CLASS(array)) {
                _goodArray = array;
                _goodModelArray = [goodsAttentionModel mj_objectArrayWithKeyValuesArray:_goodArray];
                
                if (Type == 1) {
                    _goodListArray = [NSMutableArray arrayWithArray:_goodModelArray];
                    [self stopLoadData];
                    [_TableView reloadData];
                    
                }else if(Type == 2){
                    
                    NSMutableArray * Array = [[NSMutableArray alloc] init];
                    [Array addObjectsFromArray:_goodListArray];
                    [Array addObjectsFromArray:_goodModelArray];
                    _goodListArray = Array;
                    [self stopLoadData];
                    [_TableView reloadData];
                }
                
                
         
            
            
            if ([_goodListArray count]>9) {
                
                __unsafe_unretained __typeof(self) weakSelf = self;
                
                self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    // 进入刷新状态后会自动调用这个block
                    [weakSelf loadMoreData];
                }];
                
                
            }
            if([_goodListArray count]==0)
                
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
    
    [self requestDataWithPage:2];
}


- (UITableView *)TableView
{
    if (!_TableView)
    {
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
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
    
    return 102*Proportion;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_goodListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 6.99;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    goodsAttentionModel * goodsModel = _goodListArray[indexPath.section];
    
    goodsModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    static NSString * cellid = @"goodsAttentionCell";

    goodsAttentionCell * goodscell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!goodscell) {
        
        goodscell = [[goodsAttentionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        goodscell.delegate = self;
    }
    
    goodscell.goodsModel = goodsModel;
    
    
    return goodscell;
    
}
-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;
{
    [HDHud showHUDInView:self.view title:@"取消中.."];
    
    goodsAttentionModel * goodModel = (goodsAttentionModel*)celldata;
    

    NSString * goodId = [NSString stringWithFormat:@"%@",goodModel.goods_id];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:goodId,@"goods_id", nil];
    

    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_UndoAttentStoreGoods pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            [_goodListArray removeObjectAtIndex:sender.tag];
            
            [self.TableView deleteSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationRight];
            
            [self.TableView reloadData];
            
        }
        
    } DataFaiure:^(id error) {
        [HDHud hideHUDInView:self.view];
        [HDHud showMessageInView:self.view title:error];
        
        
    } Failure:^(id error) {
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
        
        
    }];
    
    
}
@end
