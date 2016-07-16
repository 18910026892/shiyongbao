//
//  InteralGoodsModel.h
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InteralGoodsModel : NSObject
@property (nonatomic,copy)NSString *gift_cat_id;
@property (nonatomic,copy)NSString *gift_id;
@property (nonatomic,copy)NSString *gift_price;
@property (nonatomic,copy)NSString *gift_title;
@property (nonatomic,copy)NSString *gift_trade_price;
@property (nonatomic,copy)NSString *gift_type;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(NSArray *)arrayWithArrays:(NSArray *)dicts;
@end
