//
//  AttentionShopsDto.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionShopsDto : NSObject
//店铺名称
@property (nonatomic,copy)NSString * shop_name;
//平台Logo
@property (nonatomic,copy)NSString * shop_logo;
//店铺ID
@property (nonatomic,copy)NSString * shop_id;
//店铺地址
@property (nonatomic,copy)NSString * shop_click_url;
//店铺图片地址
@property (nonatomic,copy)NSString * shop_image;
//店铺的关注数量
@property (nonatomic,copy)NSString * atte_count;
//是否已经关注的标志
@property (nonatomic,copy)NSString * shop_type;

+ (instancetype)shopsModelWithDict:(NSDictionary *)dict;
@end
