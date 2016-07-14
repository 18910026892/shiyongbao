//
//  GoodsModel.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

+ (instancetype)goodsModelWithDict:(NSDictionary *)dict
{
    GoodsModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
