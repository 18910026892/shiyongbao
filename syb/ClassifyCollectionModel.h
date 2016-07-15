//
//  ClassifyCollectionModel.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyCollectionModel : NSObject

//分类名称
@property (nonatomic,copy)NSString * cat_name;

//分类图片
@property (nonatomic,copy)NSString * cat_image_url;
//分类ID
@property (nonatomic,copy)NSString * cat_id;

+ (instancetype)ClassifyCollectionModelWithDict:(NSDictionary *)dict;

@end
