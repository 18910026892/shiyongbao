//
//  GoodsViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "GoodsViewController.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController

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
    
    NSDictionary * parameter = @{@"num":@"20",@"page":_page,@"cat_id":_cat_id};
    
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetStoreGoodsByCatId pragma:parameter];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {

            NSMutableArray * array1 = [[response valueForKey:@"result"] valueForKey:@"brand_group"];
            
            NSMutableArray * array2 = [[response valueForKey:@"result"] valueForKey:@"goods_list"];
            
            //列表数据
            
            if ( IS_ARRAY_CLASS(array1))
            {
            
                _brandArray = array1;
                _brandModelArray = [brandModel mj_objectArrayWithKeyValuesArray:_brandArray];
                _brandListArray  = [NSMutableArray arrayWithArray:_brandModelArray];
          
            }
        
            if (IS_ARRAY_CLASS(array2)) {
                _goodArray = array2;
                _goodModelArray = [good320Model mj_objectArrayWithKeyValuesArray:_goodArray];
                
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
    _cat_id = @"RX";
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
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStyleGrouped];
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
    if (indexPath.section==[_brandListArray count]) {
        return 100;
    }else
    return 102*Proportion;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==[_brandListArray count]) {
        return [_goodListArray count];
    }else
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_brandListArray count]+1;
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
    static NSString * brandCell = @"brandCell";

    
    BrandCell * cell = [tableView dequeueReusableCellWithIdentifier:brandCell];
    
    if (!cell) {
        cell = [[BrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:brandCell];

    }

     if (indexPath.section==[_brandListArray count]) {
        
         static NSString * goodsTableViewCell = @"GoodsTableViewCell";
         
         GoodsTableViewCell * goodscell = [tableView dequeueReusableCellWithIdentifier:goodsTableViewCell];
         
         if (!goodscell) {
             goodscell = [[GoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsTableViewCell];
             
         }
         
         goodscell.goodsModel = _goodListArray[indexPath.row];
         
    }else
    {
        
        brandModel * brandModel = _brandListArray[indexPath.section];
        cell.model = brandModel;
        
    }

    
    
    
    
    return cell;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
