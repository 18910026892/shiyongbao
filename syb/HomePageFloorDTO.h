//
//  HomePageFloorDTO.h
//  syb
//
//  Created by GX on 15/10/20.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageFloorDTO : NSObject
//banner的数据

//轮播图标题
@property (nonatomic,copy)NSString * url_title;

//轮播图地址
@property (nonatomic,copy)NSString * img_url;

//跳转类型
@property (nonatomic,copy)NSString * jump_sign;

//是否需要登录的标志
@property (nonatomic,copy)NSString * permis;

//跳转地址
@property (nonatomic,copy)NSString * url_link;


//floor1的数据

//集合视图数组
@property (nonatomic,copy)NSArray * floor1Array;

@property (nonatomic,copy)NSString * xunzhen;



//floor2的数据
//商品汇
@property (nonatomic,copy)NSString * shangpinhuiImageName;
//母婴产品
@property (nonatomic,copy)NSString * babybuttonImageName;
//美妆
@property  (nonatomic,copy)NSString * beautyButtonImageName;
//分类ID
@property  (nonatomic,copy)NSString * cat_id1;
@property  (nonatomic,copy)NSString * cat_id2;

//floor3的数据
//网店汇
@property (nonatomic,copy)NSString * wangdianhuiImageName;
//更多
@property (nonatomic,copy)NSString * moreImageName;


//floor 4 的数据
//店铺名称
@property (nonatomic,copy)NSString * shop_name;
//平台Logo
@property (nonatomic,copy)NSString * shop_logo;
//店铺ID
@property (nonatomic,copy)NSString * shop_id;
//店铺地址
@property (nonatomic,copy)NSString * shop_url;
//店铺图片地址
@property (nonatomic,copy)NSString * shop_image;
//店铺的点击地址
@property (nonatomic,copy)NSString * shop_click_url;
//店铺类型
@property (nonatomic,copy)NSString * shop_type;
//楼层名称
@property (nonatomic, copy) NSString *floorName;
//店铺的关注数量
@property (nonatomic,copy)NSString * atte_count;

@property (nonatomic,strong)NSString * tag;


//用户ID
@property (nonatomic,copy)NSString * user_id;
+ (instancetype)shopsModelWithDict:(NSDictionary *)dict;
@end
