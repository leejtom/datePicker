//
//  ViewController.m
//  JTDatePickerDemo
//
//  Created by JTom on 2018/4/25.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "ViewController.h"
#import "JTDatePickManager.h"

@interface ViewController ()<JTDatePickerDelegate, JTStarAndEndTimePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)yearMonthDayWeekAction:(UIButton *)sender {
	JTDatePickManager *datePickManager = [[JTDatePickManager alloc] initWithPickerModel:JTDatePickerModeDateAndWeekday];
	JTDatePicker *datePicker = datePickManager.datePicker;
	datePicker.delegate = self;
	[self presentViewController:datePickManager animated:YES completion:nil];
}

- (IBAction)startAndEndTimeAction:(UIButton *)sender {
	JTDatePickManager *datePickManager = [[JTDatePickManager alloc] initWithPickerModel:JTDatePickerModeStartAndEndTime];
	JTStarAndEndTimePicker *datePicker = datePickManager.starAndEndTimePicker;
	datePicker.delegate = self;
	[self presentViewController:datePickManager animated:YES completion:nil];
}

#pragma mark - JTDatePickerDelegate
- (void)datePicker:(JTDatePicker *)datePicker didSelectDateComponents:(NSDateComponents *)components{
	self.yearMonthDay.text =  [NSString stringWithFormat:@"%zd年%zd月%zd日 %@",components.year, components.month, components.day,[JTDateCommon weekdayStringFromInteger:components.weekday]];
}

#pragma mark - JTStarAndEndTimePickerDelegate
- (void)datePicker:(JTStarAndEndTimePicker *)datePicker didSelectSartDateComponents:(NSDateComponents *)startCompon endDateComponents:(NSDateComponents *)endCompon{
	self.startAndEndTime.text = [NSString stringWithFormat:@"%02zd:%02zd - %02zd:%02zd", startCompon.hour, startCompon.minute, endCompon.hour, endCompon.minute];
}
@end
