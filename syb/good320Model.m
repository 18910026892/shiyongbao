//
//  good320Model.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "good320Model.h"

@implementation good320Model
+ (instancetype)good320ModelWithDict:(NSDictionary *)dict
{
    good320Model*model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
