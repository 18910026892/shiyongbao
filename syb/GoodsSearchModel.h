//
//  GoodsSearchModel.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsSearchModel : NSObject

@property (nonatomic,copy)NSString * click_count;
@property (nonatomic,copy)NSString * goods_price;
@property (nonatomic,copy)NSString * goods_id;
@property (nonatomic,copy)NSString * goods_name;
@property (nonatomic,copy)NSString * revert_point;
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * open_iid;
@property (nonatomic,copy)NSString * site_name;
@property (nonatomic,copy)NSString * store_name;
@property (nonatomic,copy)NSString * goods_img_url;

+ (instancetype)goodsModelWithDict:(NSDictionary *)dict;
@end
