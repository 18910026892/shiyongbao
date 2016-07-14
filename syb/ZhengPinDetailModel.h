//
//  ZhengPinDetailModel.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhengPinDetailModel : NSObject

@property (nonatomic,strong)NSArray * image_list;
@property (nonatomic,strong)NSArray * video_list;
@property (nonatomic,strong)NSArray * store_List;
@property (nonatomic,strong)NSString * info_id;
@property (nonatomic,strong)NSString * content_text;
@property (nonatomic,strong)NSString * item_url;
@property (nonatomic,strong)NSString * event_time;
@property (nonatomic,strong)NSString * event_title;

@end
