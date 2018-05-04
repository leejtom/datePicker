//
//  JTDateCommon.m
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTDateCommon.h"
#define Calendar [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]

@implementation JTDateCommon
+ (NSDateComponents *)getCurrentDateComponents{
	// 获取当前日期
	NSDate* dt = [NSDate date];
	// 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒、周几的信息
	unsigned unitFlags = NSCalendarUnitYear |
	NSCalendarUnitMonth |  NSCalendarUnitDay |
	NSCalendarUnitHour |  NSCalendarUnitMinute |
	NSCalendarUnitSecond | NSCalendarUnitWeekday;
	// 获取不同时间字段的信息
	NSDateComponents* comp = [Calendar components: unitFlags
										  fromDate:dt];
	return comp;
}

+ (NSDate *)getCurrentDate{
	return [Calendar dateFromComponents:[self getCurrentDateComponents]];
}

+ (NSDate *)getNextDayDate{
	return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[self getCurrentDate]];
}

+ (NSDate *)getLastDayDate{
	return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[self getCurrentDate]];
}

+ (NSInteger)getCurrentYear{
	return [self getCurrentDateComponents].year;
}

+ (NSInteger)getCurrentMonth{
	return [self getCurrentDateComponents].month;
}

+ (NSInteger)getCurrentDay{
	return [self getCurrentDateComponents].day;
}

/**
 返回周几
 
 @param weekdy 下标
 @return 周几
 */
+ (NSString *)weekdayStringFromInteger:(NSInteger)weekdy{
	NSArray *weekdays = [NSArray arrayWithObjects: @"", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
	if (weekdy < weekdays.count) {
		return weekdays[weekdy];
	}else{
		return @"";
	}
}

/**
 获取周几
 
 @param year 年
 @param month 月
 @param day 日
 @return 周几
 */
+ (NSString *)weekdayIndexForYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
	NSString *dateString =  [NSString stringWithFormat:@"%@-%@-%@", year , month, day];
	NSDateComponents *myDateComponents = [self dateComponentsWithTimeInterval:[self  getTimestampWithDateString:dateString formatter:@"YYYY-MM-dd"]];
	
	return [self weekdayStringFromInteger:myDateComponents.weekday];
}

/**
 获取时间戳

 @param dateStr dateString
 @param formatterStr 格式
 @return 时间戳
 */
+ (NSTimeInterval) getTimestampWithDateString:(NSString *)dateStr formatter:(NSString*)formatterStr{
	NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:formatterStr];
	NSDate *date =[dateFormatter dateFromString:dateStr];
	return [date timeIntervalSince1970];
}

/**
 根据时间戳创建DateComponents
 
 @param interval 时间戳
 @return DateComponents
 */
+ (NSDateComponents *)dateComponentsWithTimeInterval:(NSTimeInterval ) interval{
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
	NSCalendar *calendar = [NSCalendar currentCalendar];//当前用户的calendar
	NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
	
	return components;
}

+ (NSInteger)howManyDaysWithMonthInThisYear:(NSInteger)year withMonth:(NSInteger)month {
	if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
		return 31 ;
	if((month == 4) || (month == 6) || (month == 9) || (month == 11))
		return 30;
	if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
		return 28;
	if(year % 400 == 0)
		return 29;
	if(year % 100 == 0)
		return 28;
	return 29;
}

@end
