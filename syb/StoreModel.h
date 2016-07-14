//
//  StoreModel.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject
//"is_pass_str" = "\U5df2\U8ba4\U8bc1\U901a\U8fc7";
//"qt_store_name" = "\U63d0\U83ab\U961f\U957f\U957f\U5728\U5f85\U547d";
//"qt_store_url" = "http://www.baidu.com";
//}

@property (nonatomic,copy)NSString * is_pass_str;
@property (nonatomic,copy)NSString * qt_store_name;
@property (nonatomic,copy)NSString * qt_store_url;
@end
