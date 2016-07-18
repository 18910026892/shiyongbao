//
//  OrderModel.m
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
+ (instancetype)OrderModelWithDict:(NSDictionary *)dict
{
    OrderModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
