//
//  MyOrderViewController.h
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"
#import "OrderCell.h"
@interface MyOrderViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,OrderCellDelegate>

@property (nonatomic,strong)UITableView * TableView;

@property(nonatomic,copy)NSString * page;

@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;

@end
