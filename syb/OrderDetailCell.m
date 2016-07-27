//
//  OrderDetailCell.m
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.orderNumber];
        [self.contentView addSubview:self.lineLabel];
        //[self.contentView addSubview:self.orderFrom];
        [self.contentView addSubview:self.orderStore];
        [self.contentView addSubview:self.orderDate];
        [self.contentView addSubview:self.orderPrice];
        [self.contentView addSubview:self.orderIntegral];
        
        
        
        
    }
    return self;
}

-(UILabel*)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.frame = CGRectMake(0, 39.5, kMainScreenWidth, 0.5);
        _lineLabel.backgroundColor = kSeparatorLineColor;
    }
    return _lineLabel;
}

-(UILabel*)orderNumber
{
    if (!_orderNumber) {
        _orderNumber = [UILabel labelWithFrame:CGRectMake(20,
                                                        0,
                                                        kMainScreenWidth-40,
                                                        39.5) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _orderNumber;
}


-(UILabel*)orderFrom
{
    if (!_orderFrom) {
        _orderFrom = [UILabel labelWithFrame:CGRectMake(10,
                                                        40,
                                                        40,
                                                        44) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _orderFrom;
}


-(UILabel*)orderStore
{
    if (!_orderStore) {
        _orderStore = [UILabel labelWithFrame:CGRectMake(10,
                                                         40,
                                                         kMainScreenWidth-110,
                                                         44) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _orderStore;
}

-(UILabel*)orderDate
{
    if (!_orderDate) {
        _orderDate = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth-100,
                                                        40,
                                                        90,
                                                        44) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        
    }
    return _orderDate;
}

-(UILabel*)orderPrice
{
    if (!_orderPrice) {
        _orderPrice = [UILabel labelWithFrame:CGRectMake(100,
                                                         [self.orderModel.order_items count]*100+84,
                                                         100,
                                                         44) text:@"" textColor:HexRGBAlpha(0x000000, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _orderPrice;
}
-(UILabel*)orderIntegral
{
    if (!_orderIntegral) {
        _orderIntegral = [UILabel labelWithFrame:CGRectMake(200,
                                                            [self.orderModel.order_items count]*100+84,
                                                            100,
                                                            44) text:@"" textColor:HexRGBAlpha(0x000000, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _orderIntegral;
}

- (UITableView *)orderList
{
    if (!_orderList)
    {
        
        _orderList = [[UITableView alloc] initWithFrame:CGRectMake(0,84, kMainScreenWidth,[self.orderModel.order_items count]*100) style:UITableViewStyleGrouped];
        _orderList.dataSource = self;
        _orderList.delegate = self;
        _orderList.scrollEnabled = YES;
        _orderList.backgroundColor = kDefaultBackgroundColor;
        _orderList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
        
    }
    
    return _orderList;
}
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_tableListArray count];
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
    OrderItem * orderItem = _tableListArray[indexPath.section];
    
    static NSString * cellID = @"OrderGoodsCell";
    OrderGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[OrderGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.orderItem = orderItem;
    return cell;
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    self.orderNumber.text = orderModel.order_id;
    self.orderFrom.text = orderModel.site_name;
    self.orderStore.text = orderModel.shop_title;
    self.orderDate.text =  [TimeTool timePrToTime:orderModel.create_order_time];
    
    _tableArray = orderModel.order_items;
    
    _tableListArray = [OrderItem mj_objectArrayWithKeyValuesArray:_tableArray];
    
    [self.contentView addSubview:self.orderList];
    
    
    
    self.orderPrice.frame = CGRectMake(20,
                                       [self.orderModel.order_items count]*100+84,
                                       kMainScreenWidth/2-20,44);
    
    self.orderIntegral.frame = CGRectMake(kMainScreenWidth/2,
                                          [self.orderModel.order_items count]*100+84,
                                          kMainScreenWidth/2-20,44);
    
    
    
    
    float price = [orderModel.order_price floatValue];
    

    float intergral = [orderModel.total_point floatValue];
    

    self.orderPrice.text = [NSString stringWithFormat:@"合计￥%.2f" ,price];
    self.orderIntegral.text = [NSString stringWithFormat:@"合计积分：%.2f" ,intergral];
    
    
}
+ (CGFloat)CellRowHeightForObject:(id)object;
{
    OrderModel * orderModel = (OrderModel *)object;
    
    NSInteger imgNum =  [orderModel.order_items count];
    float itemHeight =  100*imgNum;
    
    return 128+itemHeight;
}

@end
