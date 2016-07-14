//
//  TimeTool.h
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject


+(NSString *)TimeToTimePr:(NSDate *)timeDate WithFormat:(NSString *)_fomatter;
+(NSString *)timePrToTime:(NSString *)timepr;
+(NSString *)getWeekdayWithNumber:(NSInteger)number;
+(NSString *)TimeStrToTimePr:(NSString *)timeStr WithFormat:(NSString *)_fomatter;



@end
