//
//  CommodityModel.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityModel : NSObject
//商品的名称
@property (nonatomic,copy)NSString * goods_title;
//商品的图片
@property (nonatomic,copy)NSString * goods_image;
//商品的价格
@property (nonatomic,copy)NSString * goods_price;
//商品的ID
@property (nonatomic,copy)NSString * goods_id;
//商品的地址
@property (nonatomic,copy)NSString * goods_click_url;

//商品的来源
@property (nonatomic,copy)NSString * site_name;

+ (instancetype)goodsModelWithDict:(NSDictionary *)dict;
@end
