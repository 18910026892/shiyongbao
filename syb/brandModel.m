//
//  brandModel.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "brandModel.h"

@implementation brandModel
+ (instancetype)brandModelWithDict:(NSDictionary *)dict
{
    brandModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
