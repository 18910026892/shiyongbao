//
//  HomePageCollectionDto.m
//  syb
//
//  Created by GX on 15/11/14.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "HomePageCollectionDto.h"

@implementation HomePageCollectionDto

+ (instancetype)shopsModelWithDict:(NSDictionary *)dict
{
    HomePageCollectionDto *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
