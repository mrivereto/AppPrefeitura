//
//  DateUtils.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils


+(NSString *)formatDate:(NSDate *)date{
    return [self formatDate:date withFormat:DATE_PATTERN_DD_MM_YYYY_HH_mm];
}

+(NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

+(NSDate *)convetToDate:(NSString *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:DATE_PATTERN_YYYY_MM_DD_HH_mm_SS];
    
    NSDate *dateFromString = [dateFormatter dateFromString:date];
    
    return dateFromString;
}

+(NSDate *)getDateFrom:(long)milliseconds{
    
    NSDate *dateWeather = [NSDate dateWithTimeIntervalSince1970:milliseconds];
    
    return dateWeather;
}


+(NSString *)getVerboseMonthFromDate:(NSDate *)date{
    
    int month = [[self formatDate:date withFormat:DATE_PATTERN_MM] intValue] - 1;
    
    return [MONTHS objectAtIndex:month];
}


+(NSString *)getDayOfWeek:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];

    return [DAY_WEEK objectAtIndex:([components weekday] - 1)];
}


@end
