//
//  OrderDetailViewController.m
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "OrderDetailViewController.h"

@implementation OrderDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    [MobClick beginLogPageView:@"订单详情"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"订单详情"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"订单详情"];
    [self showBackButton:YES];
    [self setupViews];
    
}

-(void)setupViews
{
    
    [self.view addSubview:self.TableView];
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
        
        
    }
    
    return _TableView;
}
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return    [OrderDetailCell CellRowHeightForObject:self.orderModel];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
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
    return 6.99;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    //初始化每行的数据模型
    
    static NSString * cellID = @"OrderDetailCell";
    OrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[OrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.orderModel = self.orderModel;
    return cell;
    
}

@end
