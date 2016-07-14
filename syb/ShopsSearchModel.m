//
//  ShopsSearchModel.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsSearchModel.h"

@implementation ShopsSearchModel

+ (instancetype)shopsModelWithDict:(NSDictionary *)dict
{
    ShopsSearchModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
