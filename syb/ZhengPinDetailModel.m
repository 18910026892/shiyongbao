//
//  ZhengPinDetailModel.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPinDetailModel.h"

@implementation ZhengPinDetailModel
+ (instancetype)ZhengPinDetailModelWithDict:(NSDictionary *)dict
{
    ZhengPinDetailModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
