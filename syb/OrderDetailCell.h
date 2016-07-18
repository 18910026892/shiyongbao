//
//  OrderDetailCell.h
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderItem.h"
#import "OrderGoodsCell.h"
@interface OrderDetailCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)OrderModel * orderModel;

@property (nonatomic,strong)UILabel * lineLabel;
@property (nonatomic,strong)UILabel * orderNumber;
@property (nonatomic,strong)UILabel * orderFrom;
@property (nonatomic,strong)UILabel * orderStore;
@property (nonatomic,strong)UILabel * orderDate;
@property (nonatomic,strong)UITableView * orderList;
@property (nonatomic,strong)UILabel * orderPrice;
@property (nonatomic,strong)UILabel * orderIntegral;

@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;


+ (CGFloat)CellRowHeightForObject:(id)object;

@end
