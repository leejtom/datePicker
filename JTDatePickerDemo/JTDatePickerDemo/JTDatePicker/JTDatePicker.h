//
//  JTDatePicker.h
//  Demo
//
//  Created by JTom on 2018/4/19.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTDatePickerHeader.h"



@protocol JTDatePickerDelegate;

@interface JTDatePicker : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) id<JTDatePickerDelegate> delegatePicker;

@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;

@property (nonatomic, strong) NSDateComponents *minimumComponents;
@property (nonatomic, strong) NSDateComponents *maximumComponents;
@property (nonatomic, strong) NSDateComponents *currentComponents;
@property (nonatomic, strong) NSDateComponents *selectComponent;

@property (nonatomic, assign) NSCalendarUnit unitFlags;
@property (nonatomic, strong) NSLocale   *locale;
@property (nonatomic, copy)   NSCalendar *calendar;
@property (nonatomic, strong) NSTimeZone *timeZone;

@property (nonatomic, strong) NSArray *yearList;
@property (nonatomic, strong) NSArray *dateAndWeekdayList;

@property (nonatomic, assign, getter=isAutoSelect) BOOL autoSelect;//自动选择日期

- (void)tapSelectedHandler;

@end

@protocol JTDatePickerDelegate <NSObject>

- (void)datePicker:(JTDatePicker *)datePicker didSelectDateComponents:(NSDateComponents *)components;

@end

