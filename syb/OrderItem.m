//
//  OrderItem.m
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem
+ (instancetype)OrderItemWithDict:(NSDictionary *)dict
{
    OrderItem *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
