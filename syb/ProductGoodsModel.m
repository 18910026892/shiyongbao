//
//  ProductGoodsModel.m
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ProductGoodsModel.h"

@implementation ProductGoodsModel
+ (instancetype)ProductGoodsModelWithDict:(NSDictionary *)dict
{
    ProductGoodsModel*model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
