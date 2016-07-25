//
//  OrderModel.h
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject


@property (nonatomic,strong)NSString * create_order_time;
@property (nonatomic,strong)NSString * order_id;
@property (nonatomic,strong)NSMutableArray  * order_items;
@property (nonatomic,strong)NSString * order_price;
@property (nonatomic,strong)NSString * order_status;
@property (nonatomic,strong)NSString * shop_title;
@property (nonatomic,strong)NSString * user_id;
@property (nonatomic,strong)NSString * total_point;
@property (nonatomic,strong)NSString * site_name;

@end
