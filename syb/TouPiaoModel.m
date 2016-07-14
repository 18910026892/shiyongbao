//
//  TouPiaoModel.m
//  syb
//
//  Created by GongXin on 16/2/27.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "TouPiaoModel.h"

@implementation TouPiaoModel
+ (instancetype)TouPiaoModelWithDict:(NSDictionary *)dict
{
    TouPiaoModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
