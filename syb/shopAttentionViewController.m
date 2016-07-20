//
//  shopAttentionViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "shopAttentionViewController.h"
#import "shopGoodsViewController.h"
@implementation shopAttentionViewController
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
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page", nil];
    
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_AttentedShop pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            _ShopsListArray = [response valueForKey:@"result"];
            
            NSLog(@" %@ ",_ShopsListArray);
            
            _ModelArray = [shopAttentionModel mj_objectArrayWithKeyValuesArray:_ShopsListArray];
            
            
            if (Type == 1) {
                _ShopsList = [NSMutableArray arrayWithArray:_ModelArray];
                [self stopLoadData];
                [_TableView reloadData];
                
            }else if(Type == 2){
                
                NSMutableArray * Array = [[NSMutableArray alloc] init];
                [Array addObjectsFromArray:_ShopsList];
                [Array addObjectsFromArray:_ModelArray];
                _ShopsList = Array;
                [self stopLoadData];
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
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStyleGrouped];
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
    shopAttentionModel * shopModel = _ShopsList[indexPath.section];
    shopModel.tag = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    static NSString * cellID = @"shopAttentionCell";
    shopAttentionCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[shopAttentionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

-(void)goodsButtonClickWithDict:(NSDictionary*)dict;
{
    NSLog(@" %@ ",dict);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    shopAttentionModel * shopModel = _ShopsList[indexPath.section];
    shopGoodsViewController * shopGoodsVc = [shopGoodsViewController viewController];
    shopGoodsVc.shop_id = shopModel.shop_id;
    
    [self.navigationController pushViewController:shopGoodsVc animated:YES];
    
    
}


#pragma TableViewDelegate
-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;
{

    [HDHud showHUDInView:self.view title:@"取消中.."];
    
          shopAttentionModel * shopModel = (shopAttentionModel*)celldata;
    

            
            NSString * shopID = [NSString stringWithFormat:@"%@",shopModel.shop_id];
            NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shopID,@"shop_id", nil];
            
            
            
            GXHttpRequest *request = [[GXHttpRequest alloc]init];
            
            [request RequestDataWithUrl:URL_UndoAttentShop pragma:postDict];
            
            [request getResultWithSuccess:^(id response) {
                /// 加保护
                if ([response isKindOfClass:[NSDictionary class]])
                {
                    
                    //加载框消失
                    [HDHud hideHUDInView:self.view];
                    
                    [_ShopsList removeObjectAtIndex:sender.tag];
                    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
