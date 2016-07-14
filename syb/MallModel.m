//
//  MallModel.m
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "MallModel.h"

@implementation MallModel
//初始化数据模型
+ (instancetype)MallModelWithDict:(NSDictionary *)dict
{
    MallModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
