//
//  ReportDetailModel.h
//  syb
//
//  Created by GongXin on 16/4/14.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportDetailModel : NSObject

@property (nonatomic,copy)NSString * content_text;
@property (nonatomic,strong)NSArray *  imageList;
@property (nonatomic,copy)NSString * info_id;


@end
