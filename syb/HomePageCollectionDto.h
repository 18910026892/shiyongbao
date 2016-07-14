//
//  HomePageCollectionDto.h
//  syb
//
//  Created by GX on 15/11/14.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageCollectionDto : NSObject
//title
@property (nonatomic,copy)NSString * title;

//轮播图地址
@property (nonatomic,copy)NSString * image_url;

//不知道是什么
@property (nonatomic,copy)NSString * content;

//是否需要登录的标志
@property (nonatomic,copy)NSString * needLogin;

//跳转地址
@property (nonatomic,copy)NSString * link_url;

+ (instancetype)shopsModelWithDict:(NSDictionary *)dict;

@end
