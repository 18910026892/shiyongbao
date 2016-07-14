//
//  ShopsModel.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsModel.h"

@implementation ShopsModel

+ (instancetype)shopsModelWithDict:(NSDictionary *)dict
{
    ShopsModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
