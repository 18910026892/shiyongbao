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
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"我的消息";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initBackButton];
    
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }
    
     [MobClick beginLogPageView:@"我的消息"];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
     [MobClick endLogPageView:@"我的消息"];

}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
    
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

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.update = YES;
    
   
    [self PageLayout];
}

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
   
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page", nil];
    NSLog(@"%@",postDict);

    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_myMessage pragma:postDict ImageData:nil];
    

    request.successGetData = ^(id obj){
        //加载框消失
    
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        NSLog(@"^^%@",obj);
        NSString * code = [_objDict valueForKey:@"code"];
        NSString * message = [_objDict valueForKey:@"message"];
        if ([code isEqualToString:@"1"]) {
            
             [[NSNotificationCenter defaultCenter]postNotificationName:@"HiddenPoint" object:nil];
            
            
            _ModelArray = [MessageModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
            
            if (Type == 1) {
                _messageList = [NSMutableArray arrayWithArray:_ModelArray];
                [TableView.header endRefreshing];
                [TableView reloadData];
                
            }else if(Type == 2){
                
                NSMutableArray * Array = [[NSMutableArray alloc] init];
                [Array addObjectsFromArray:_messageList];
                [Array addObjectsFromArray:_ModelArray];
                _messageList = Array;
                [TableView.footer endRefreshing];
                [TableView reloadData];
            }
            if ([_messageList count]==0) {
                 [HDHud showMessageInView:self.view title:@"暂无任何消息"];
            }else if([_messageList count]>9)
            {
                [TableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                [TableView reloadData];
                
            }
     
            
            
        }else if([code isEqualToString:@"0"])
        {
            
            NSLog(@"%@",message);
            if ([message isEqualToString:@"身份令牌验证错误！"]) {
              [HDHud showMessageInView:self.view title:@"身份认证过期，请您重新登录！"];
                
            }else
            {
                [HDHud showMessageInView:self.view title:message];
            }
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
    return 110;
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
    
    return [_messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    MessageModel * messageModel = _messageList[indexPath.row];
    
    static NSString * cellID = @"messageCell";
    MessageTableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
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
     MessageModel * messageModel = _messageList[indexPath.row];
    NSString * messageID = messageModel.message_id;
    [self deleteData:messageID];
    [_messageList removeObjectAtIndex:indexPath.row];
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
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_mymessagedel pragma:postDict ImageData:nil];
   
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        NSMutableDictionary * resultDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        NSString * reason = [resultDict valueForKey:@"message"];
        NSString * result = [resultDict valueForKey:@"code"];
        
        
        if ([result isEqualToString:@"1"]) {
            [HDHud showMessageInView:self.view title:@"删除成功"];
        }else if([result isEqualToString:@"0"])
        {
            [HDHud showMessageInView:self.view title:reason];
        }
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}

@end
