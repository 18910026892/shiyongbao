//
//  NSDate+Tools.h
//  CreditGroup
//
//  Created by JPlay on 14-3-17.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tools)

//timeInterval转NSString
+(NSString *)timeIntervalToString:(NSTimeInterval)timeInterval;
//NSDate转可视化时间，如一周前，两小时前
+(NSString *)calculateTimestamp:(NSDate *)createAt;
+(NSString *)compareDate:(NSDate *)date;


@end
