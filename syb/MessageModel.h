//
//  MessageModel.h
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

//消息名称
@property (nonatomic,copy) NSString * message_title;

//消息类型
@property (nonatomic,copy) NSString * messagetype;

//消息时间
@property (nonatomic,copy) NSString * send_time;

//消息ID

@property (nonatomic,copy) NSString * message_id;

//消息描述
@property (nonatomic,copy) NSString * message_desc;

//消息来源
@property (nonatomic,copy) NSString * message_from;


@end
