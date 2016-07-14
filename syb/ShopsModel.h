//
//  ShopsModel.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopsModel : NSObject
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
//店铺类型
@property (nonatomic,copy)NSString * shop_type;

@property (nonatomic,strong)NSString * tag;
//用户ID
@property (nonatomic,copy)NSString * user_id;
+ (instancetype)shopsModelWithDict:(NSDictionary *)dict;
@end
