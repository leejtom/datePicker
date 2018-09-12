//
//  JTDateCommon.h
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTDateCommon : NSObject
/**
 获取周几
 
 @param year 年
 @param month 月
 @param day 日
 @return 周几
 */
+ (NSString *)weekdayIndexForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSString *)weekdayStringFromInteger:(NSInteger)weekdy;
+ (NSString *)weekdayStringFromDateComponents:(NSDateComponents *)dateComponents;
/**
 获取本月的最大天数

 @param year 年
 @param month 月
 @return 天数
 */
+ (NSInteger)howManyDaysWithMonthInThisYear:(NSInteger)year withMonth:(NSInteger)month;

+ (NSDateComponents *)getCurrentDateComponents;
+ (NSDate *)getCurrentDate;
+ (NSInteger)getCurrentYear;
+ (NSInteger)getCurrentMonth;
+ (NSInteger)getCurrentDay;
+ (NSDate *)getNextDayDate;//获取下一天的date
+ (NSDate *)getLastDayDate;//获取上一天的date
@end
