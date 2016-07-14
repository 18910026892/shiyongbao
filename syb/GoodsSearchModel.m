//
//  GoodsSearchModel.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GoodsSearchModel.h"

@implementation GoodsSearchModel

+ (instancetype)goodsModelWithDict:(NSDictionary *)dict
{
    GoodsSearchModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
