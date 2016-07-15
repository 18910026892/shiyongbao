//
//  ClassifyTableModel.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyTableModel : NSObject

//分类名称
@property (nonatomic,copy)NSString * cat_name;
//分类ID
@property (nonatomic,copy)NSString * cat_id;

+ (instancetype)ClassifyTableModelWithDict:(NSDictionary *)dict;
@end
