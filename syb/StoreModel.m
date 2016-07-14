//
//  StoreModel.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
+ (instancetype)StoreModelWithDict:(NSDictionary *)dict
{
    StoreModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
