//
//  AttentionShopsDto.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "AttentionShopsDto.h"

@implementation AttentionShopsDto
+ (instancetype)shopsModelWithDict:(NSDictionary *)dict
{
    AttentionShopsDto *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
