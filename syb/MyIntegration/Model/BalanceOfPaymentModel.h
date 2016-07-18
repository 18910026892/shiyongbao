//
//  BalanceOfPaymentModel.h
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceOfPaymentModel : NSObject

@property (nonatomic,copy)NSString *point_num;
@property (nonatomic,copy)NSString *rel_order_id;
@property (strong,nonatomic) NSNumber *adjust_date;
@property (nonatomic,copy)NSString *adjust_status;
@property (nonatomic,copy)NSString *rel_order_title;
@property (nonatomic,copy)NSString *point_type;
@property (nonatomic,copy)NSString *rel_order_type;
@property (nonatomic,copy)NSString *user_id;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(NSArray *)arrayWithArrays:(NSArray *)dicts;
@end
