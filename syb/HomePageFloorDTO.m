//
//  HomePageFloorDTO.m
//  syb
//
//  Created by GX on 15/10/20.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "HomePageFloorDTO.h"

@implementation HomePageFloorDTO


+ (instancetype)shopsModelWithDict:(NSDictionary *)dict
{
    HomePageFloorDTO *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
