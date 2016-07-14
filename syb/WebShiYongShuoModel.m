//
//  WebShiYongShuoModel.m
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "WebShiYongShuoModel.h"

@implementation WebShiYongShuoModel
+ (instancetype)WebShiYongShuoModelWithDict:(NSDictionary *)dict
{
    WebShiYongShuoModel * model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
