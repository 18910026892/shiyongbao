//
//  ShopsModel.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopsModel : NSObject

@property (nonatomic,copy)NSString * action_id;
@property (nonatomic,copy)NSString * atte_count;
@property (nonatomic,copy)NSString * c_name;
@property (nonatomic,copy)NSString * cat_id;
@property (nonatomic,copy)NSString * is_auto_update;
@property (nonatomic,copy)NSString * is_show;
@property (nonatomic,strong)NSMutableArray * recommend_goods;
@property (nonatomic,copy)NSString * shop_click_url;
@property (nonatomic,copy)NSString * shop_content;
@property (nonatomic,copy)NSString * shop_desc;
@property (nonatomic,copy)NSString * shop_dyna_inspection_url;
@property (nonatomic,copy)NSString * shop_dyna_services_url;
@property (nonatomic,copy)NSString * shop_goodslist_url;
@property (nonatomic,copy)NSString * shop_id;
@property (nonatomic,copy)NSString * shop_image;
@property (nonatomic,copy)NSString * shop_logo;
@property (nonatomic,copy)NSString * shop_name;
@property (nonatomic,copy)NSString * shop_scal_standard_url;
@property (nonatomic,copy)NSString * shop_type;
@property (nonatomic,copy)NSString * shop_url;
@property (nonatomic,copy)NSString * sort_order;
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * tag;
@property (nonatomic,copy)NSString * tb_shop_id;
+ (instancetype)shopsModelWithDict:(NSDictionary *)dict;
@end
