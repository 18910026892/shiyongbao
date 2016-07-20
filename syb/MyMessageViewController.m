//
//  MyMessageViewController.m
//  syb
//
//  Created by GX on 15/10/23.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "MyMessageViewController.h"
#import "LoginViewController.h"
@implementation MyMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"我的消息"];
    [self showBackButton:YES];
    
    [self setupDatas];
    [self setupViews];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
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
    
    [request RequestDataWithUrl:URL_myMessage pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
           
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HiddenPoint" object:nil];
                
            _tableArray = [response valueForKey:@"result"];
            
            if (IS_ARRAY_CLASS(_tableArray)) {
              
                _tableModelArray = [MessageModel mj_objectArrayWithKeyValuesArray:_tableArray];
                
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
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth,kMainScreenHeight-64) style:UITableViewStylePlain];
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
   return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_tableListArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    //初始化每行的数据模型
    MessageModel * messageModel = _tableListArray[indexPath.row];
    
    static NSString * cellID = @"messageCell";
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.messageModel = messageModel;
    return cell;
    
}

//UITable编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//执行编辑风格
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     MessageModel * messageModel = _tableListArray[indexPath.row];
    NSString * messageID = messageModel.message_id;
    [self deleteData:messageID];
    [_tableListArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)deleteData:(NSString*)messageID
{

    NSString * messageID1 = messageID;
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:messageID1,@"id", nil];

    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_mymessagedel pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            //加载框消失
            NSMutableDictionary * resultDict = [NSMutableDictionary dictionaryWithDictionary:response];
            NSString * reason = [resultDict valueForKey:@"message"];
            NSString * result = [resultDict valueForKey:@"code"];
            
            
            if ([result isEqualToString:@"1"]) {
                [HDHud showMessageInView:self.view title:@"删除成功"];
            }else if([result isEqualToString:@"0"])
            {
                [HDHud showMessageInView:self.view title:reason];
            }

            
            
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
