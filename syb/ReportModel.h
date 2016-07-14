//
//  ReportModel.h
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject

// {
//     "cat_name" = "\U8de8\U5883\U7f8e\U5986";
//     "create_date" = "2016-04-06";
//     "main_image" = "/app/image/2016/4/1/2669d3be20984e01ac77510232dadc93.jpg";
//     "qa_id" = "1363fe63-4568-4169-a0f5-7d11ce0c393e";
//     "short_title" = "\U662f\U65f6\U5019\U5c55\U73b0\U6280\U672f\U4e86";
// }
@property (nonatomic,copy)NSString *cat_name;
@property (nonatomic,copy)NSString *create_date;
@property (nonatomic,copy)NSString *main_image;
@property (nonatomic,copy)NSString *qa_id;
@property (nonatomic,copy)NSString *short_title;
@end
