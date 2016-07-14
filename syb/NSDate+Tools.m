//
//  NSDate+Tools.m
//  CreditGroup
//
//  Created by JPlay on 14-3-17.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "NSDate+Tools.h"

@implementation NSDate (Tools)

+(NSString *)timeIntervalToString:(NSTimeInterval)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [fomatter stringFromDate:date];
    return dateString;
}

+(NSString *)calculateTimestamp:(NSDate *)createAt {
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];

	NSTimeInterval time = [localeDate timeIntervalSinceDate:createAt];
	int days = ((int) time)/(3600*24);
	int hours = ((int) time)/(3600);
	int minutes = ((int) time)/(60);
	
	if(days > 7){
        
        NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
        [fomatter setDateFormat:@"M月d日"];
        NSString *dateString = [fomatter stringFromDate:createAt];

		return dateString;
	}
	else if(days != 0){
		return [[NSString alloc] initWithFormat:@"%d天前", days];
	}else {
		if(hours != 0){
			return [[NSString alloc] initWithFormat:@"%d小时前", hours];
		}else {
			if (minutes > 3) {
				return [[NSString alloc] initWithFormat:@"%d分钟前", minutes];
			}else {
				return @"刚刚";
			}
		}
		
	}
	return [[NSString alloc] initWithFormat:@"未知时间"];
}

+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}

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
