//
//  OrderDetailViewController.h
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"
#import "OrderDetailCell.h"
@interface OrderDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * TableView;

@property(nonatomic,copy)NSString * page;

@property (nonatomic,strong)OrderModel * orderModel;

@end
