//
//  ClassifyCollectionModel.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ClassifyCollectionModel.h"

@implementation ClassifyCollectionModel

+ (instancetype)ClassifyCollectionModelWithDict:(NSDictionary *)dict
{
    ClassifyCollectionModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
