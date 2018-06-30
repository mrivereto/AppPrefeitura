//
//  DateUtils.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+(NSString *)formatDate:(NSDate *)date;
+(NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format;
+(NSDate *)convetToDate:(NSString *)date;
+(NSDate *)getDateFrom:(long)milliseconds;
+(NSString *)getVerboseMonthFromDate:(NSDate *)date;
+(NSString *)getDayOfWeek:(NSDate *)date;


@end


#define DATE_PATTERN_DD_MM_YYYY @"dd/MM/yyyy"
#define DATE_PATTERN_DD_MM_YYYY_HH_mm @"dd/MM/yyyy HH:mm"
#define DATE_PATTERN_YYYY_MM_DD_HH_mm_SS @"yyyy-MM-dd HH:mm:SS"
#define DATE_PATTERN_DD @"dd"
#define DATE_PATTERN_MM @"MM"
#define MONTHS  [NSArray arrayWithObjects: @"Janeiro",@"Fevereiro",@"Março",@"Abril",@"Maio",@"Junho",@"Julho",@"Agosto",@"Setembro",@"Outubro",@"Novembro",@"Dezembro",nil]
#define DAY_WEEK  [NSArray arrayWithObjects: @"Domingo",@"Segunda-Feira",@"Terça-Feira",@"Quarta-Feira",@"Quinta-Feira",@"Sexta-Feira",@"Sábado",nil]
