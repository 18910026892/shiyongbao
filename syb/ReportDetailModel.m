//
//  ReportDetailModel.m
//  syb
//
//  Created by GongXin on 16/4/14.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportDetailModel.h"

@implementation ReportDetailModel

+ (instancetype)ReportDetailModelWithDict:(NSDictionary *)dict
{
    ReportDetailModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
