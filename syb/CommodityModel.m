//
//  CommodityModel.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel
+ (instancetype)goodsModelWithDict:(NSDictionary *)dict
{
    CommodityModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
