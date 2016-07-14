//
//  TimeTool.m
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
+(NSString *)TimeToTimePr:(NSDate *)timeDate WithFormat:(NSString *)_fomatter;
{
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;
    [dateday setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    [dateday setDateFormat:_fomatter];
    //转化时间戳
    NSString *timePr = [NSString stringWithFormat:@"%ld", (long)[timeDate timeIntervalSince1970]];
    return timePr;
}

+(NSString *)timePrToTime:(NSString *)timepr;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timepr longLongValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"MM月dd日"];
    //////////////////////
    NSString *time = [formatter stringFromDate:date];
    return time;
}

//1代表星期日、如此类推
+(NSString *)getWeekdayWithNumber:(NSInteger)number
{
    switch (number) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            return @"";
            break;
    }
}
+(NSString *)TimeStrToTimePr:(NSString *)timeStr WithFormat:(NSString *)_fomatter;
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:_fomatter];
    NSDate *fromdate=[format dateFromString:timeStr];
    
    NSString *timePr = [NSString stringWithFormat:@"%ld", (long)[fromdate timeIntervalSince1970]];
    
    // NSString *timePr = [Config TimeToTimePr:fromdate WithFormat:_fomatter];
    return timePr;
}

@end
