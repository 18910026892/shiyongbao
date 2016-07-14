//
//  Goods320ViewController.m
//  syb
//
//  Created by GongXin on 16/7/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "Goods320ViewController.h"

@implementation Goods320ViewController
//初始化  视图生命周期
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

   
    if (self.update == YES) {
        [TableView.header beginRefreshing];
        self.update = NO;
    }

    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.update = YES;
    
    [self InitTabelView];

  
    
}


//页面布局
-(void)InitTabelView
{
    
    if (!TableView) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-113) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor colorWithHexString:@"#F1F1F1"];
        TableView.scrollEnabled = YES;
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TableView.tag = 1;
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [self addRefresh];
        
        
    }
    [self.view addSubview:TableView];
    
}
-(void)viewDidLayoutSubviews
{
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //获取当前行 数据模型
    return 102*Proportion;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 6.6;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    
    return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString * cellID = @"BrandCell";
    BrandCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[BrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }

    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
}

//添加更新控件
-(void)addRefresh
{
    [TableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [TableView.header setTitle:@"下拉可以刷新了" forState:MJRefreshHeaderStateIdle];
    [TableView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [TableView.header setTitle:@"正在刷新 ..." forState:MJRefreshHeaderStateRefreshing];
}
//更新数据
-(void)headerRereshing
{

}

//设置请求参数
-(void)addParameter
{
    _page = @"1";
}



@end
