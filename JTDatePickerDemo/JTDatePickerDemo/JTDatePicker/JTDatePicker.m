//
//  JTDatePicker.m
//  Demo
//
//  Created by JTom on 2018/4/19.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTDatePicker.h"

@interface JTDatePicker()
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, copy) NSString *selectedDate;
@end

@implementation JTDatePicker

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self addSubview:self.pickView];
		self.backgroundColor = [UIColor blackColor];
	}
	return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	self.pickView.frame = self.bounds;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return self.dateAndWeekdayList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return self.dateAndWeekdayList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	self.selectedDate = self.dateAndWeekdayList[row];
	if (self.isAutoSelect) {
		[self tapSelectedHandler];
	}
}

- (void)tapSelectedHandler{
	if (_delegate && [_delegate respondsToSelector:@selector(datePicker:didSelectDateComponents:)]) {
		
		NSArray *array = [self.selectedDate componentsSeparatedByString:@" "];
		if (array.count ==2) {
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"yyyy年MM月dd日";
			NSDate *date = [formatter dateFromString:array[0]];
			[_delegate datePicker:self didSelectDateComponents:[self.calendar components:self.unitFlags fromDate:date]];
		}
	}
	
}


- (UIPickerView *)pickView{
	if (!_pickView) {
		_pickView = [[UIPickerView alloc] init];
		_pickView.delegate = self;
		_pickView.dataSource = self;
	}
	return _pickView;
}

- (NSCalendar *)calendar {
	if (!_calendar) {
		_calendar = [NSCalendar currentCalendar];
		_calendar.timeZone = self.timeZone;
		_calendar.locale = self.locale;
	}
	return _calendar;
}

- (NSLocale *)locale {
	if (!_locale) {
		_locale = [NSLocale currentLocale];
	}
	return _locale;
}

- (NSTimeZone *)timeZone{
	if (!_timeZone) {
		_timeZone = [NSTimeZone  localTimeZone];
	}
	return _timeZone;
}

- (NSCalendarUnit)unitFlags {
	if (!_unitFlags) {
		_unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
	}
	return _unitFlags;
}

- (NSArray *)yearList {
	if (!_yearList) {
		NSInteger index = self.maximumComponents.year - self.minimumComponents.year;
		NSMutableArray *years = [NSMutableArray arrayWithCapacity:index];
		for (NSUInteger i = self.minimumComponents.year; i <= self.maximumComponents.year ; i ++) {
			[years addObject:[@(i) stringValue]];
		}
		_yearList = years;
	}
	return _yearList;
}

- (NSArray *)dateAndWeekdayList{
	if (!_dateAndWeekdayList) {
		NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
		NSString *yearMonthDay;
		NSString *yearString;
		NSString *monthString;
		NSString *dayString;
		NSString *weekdayString;
		
		for (NSUInteger yearInddx =0; yearInddx < self.yearList.count ; yearInddx++) {
			yearString = self.yearList[yearInddx];
			//计算开始月
			NSInteger monthStartIndex = (yearInddx==0? self.minimumComponents.month : 1);
			for (; monthStartIndex <= 12; monthStartIndex++) {
				monthString = [@(monthStartIndex) stringValue];
				NSInteger dayCount = [JTDateCommon howManyDaysWithMonthInThisYear:[yearString integerValue] withMonth:monthStartIndex];
				
				//计算开始日
				NSInteger dayStartIndex = (monthStartIndex==self.minimumComponents.month? self.minimumComponents.day : 1);
				for (; dayStartIndex<= dayCount; dayStartIndex++) {
					dayString = [@(dayStartIndex) stringValue];
					weekdayString = [JTDateCommon weekdayIndexForYear:yearString month:monthString day:dayString];
					yearMonthDay = [NSString stringWithFormat:@"%@年%@月%@日 %@", yearString, monthString, dayString, weekdayString];
					[arrayM addObject:yearMonthDay];
				}
			}
		}
		self.selectedDate = arrayM.firstObject;
		_dateAndWeekdayList = arrayM;
	}
	return  _dateAndWeekdayList;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
	_minimumDate = minimumDate;
	self.minimumComponents = [self.calendar components:self.unitFlags fromDate:minimumDate];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
	_maximumDate = maximumDate;
	self.maximumComponents = [self.calendar components:self.unitFlags fromDate:maximumDate];
}

- (NSDateComponents *)minimumComponents {
	if (self.minimumDate) {
		_minimumComponents = [self.calendar components:self.unitFlags fromDate:self.minimumDate];
	}else {
		_minimumComponents = [self.calendar components:self.unitFlags fromDate:[NSDate distantPast]];
		_minimumComponents.day = 1;
		_minimumComponents.month = 1;
		_minimumComponents.hour = 0;
		_minimumComponents.minute = 0;
		_minimumComponents.second = 0;
	}
	return _minimumComponents;
}

- (NSDateComponents *)maximumComponents {
	if (self.maximumDate) {
		_maximumComponents = [self.calendar components:self.unitFlags fromDate:self.maximumDate];
	}else {
		_maximumComponents = [self.calendar components:self.unitFlags fromDate:[NSDate distantFuture]];
		NSInteger day = [JTDateCommon howManyDaysWithMonthInThisYear:self.currentComponents.year withMonth:self.currentComponents.month];
		_maximumComponents.day = day;
		_maximumComponents.month = 12;
		_maximumComponents.hour = 23;
		_maximumComponents.minute = 59;
		_maximumComponents.second = 59;
	}
	return _maximumComponents;
}

- (NSDateComponents *)currentComponents {
	if (!_currentComponents) {
		_currentComponents = [self.calendar components:self.unitFlags fromDate:[NSDate date]];
	}
	return _currentComponents;
}

@end
