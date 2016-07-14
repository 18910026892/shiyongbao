//
//  ReportModel.m
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel

+ (instancetype)ReportModelWithDict:(NSDictionary *)dict
{
    ReportModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
