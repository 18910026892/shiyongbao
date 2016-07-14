//
//  RenZhengGoodsModel.m
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RenZhengGoodsModel.h"

@implementation RenZhengGoodsModel
+ (instancetype)RenZhengGoodsModelWithDict:(NSDictionary *)dict
{
    RenZhengGoodsModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
