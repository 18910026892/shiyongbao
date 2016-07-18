//
//  BalanceOfPaymentModel.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BalanceOfPaymentModel.h"

@implementation BalanceOfPaymentModel
-(instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        for (NSString* key in dict.allKeys) {
            id value = [dict valueForKey:key];
            SEL setPropertySelctor = NSSelectorFromString(key);
            if ( [self respondsToSelector:setPropertySelctor]) {
                if (value) {
                    [self setValue:[dict valueForKey:key] forKey:key];
                }
            }
        }
    }
    return self;
}
+(NSArray *)arrayWithArrays:(NSArray *)dicts
{
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i<dicts.count; i++) {
        NSDictionary *dict = dicts[i];
        BalanceOfPaymentModel *model = [[BalanceOfPaymentModel alloc] initWithDict:dict];
        [datas addObject:model];
    }
    return datas;
}
@end
