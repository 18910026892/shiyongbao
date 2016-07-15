//
//  ClassifyTableModel.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ClassifyTableModel.h"

@implementation ClassifyTableModel

+ (instancetype)ClassifyTableModelWithDict:(NSDictionary *)dict
{
    ClassifyTableModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
