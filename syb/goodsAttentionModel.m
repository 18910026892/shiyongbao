//
//  goodsAttentionModel.m
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "goodsAttentionModel.h"

@implementation goodsAttentionModel
+ (instancetype)goodsAttentionModelWithDict:(NSDictionary *)dict
{
    goodsAttentionModel*model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
