//
//  shopAttentionModel.m
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "shopAttentionModel.h"

@implementation shopAttentionModel
+ (instancetype)shopAttentionModelWithDict:(NSDictionary *)dict
{
    shopAttentionModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
