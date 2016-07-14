//
//  WebShiYongShuoModel.h
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebShiYongShuoModel : NSObject
//商品的名称
@property (nonatomic,copy)NSString * p_name;
//商品的图片
@property (nonatomic,copy)NSString * p_img_url;
//商品的价格
@property (nonatomic,copy)NSString * ref_price;
//商品的ID
@property (nonatomic,copy)NSString * code_id;

//识用说
@property (nonatomic,strong)NSDictionary * shuoshuo;



+ (instancetype)WebShiYongShuoModelWithDict:(NSDictionary *)dict;
@end
