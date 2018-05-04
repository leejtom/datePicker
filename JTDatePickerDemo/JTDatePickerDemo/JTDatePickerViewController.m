//
//  JTDatePickerViewController.m
//  JTDatePickerDemo
//
//  Created by JTom on 2018/5/4.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTDatePickerViewController.h"
#import "JTDatePickManager.h"

@interface JTDatePickerViewController ()<JTDatePickerDelegate>

@end

@implementation JTDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		JTDatePickManager *datePickManager = [[JTDatePickManager alloc] initWithPickerModel:JTDatePickerModeDateAndWeekday];
		JTDatePicker *datePicker = datePickManager.datePicker;
		datePicker.delegatePicker = self;
		[self presentViewController:datePickManager animated:YES completion:nil];
	});
	
}

- (void)datePicker:(JTDatePicker *)datePicker didSelectDateComponents:(NSDateComponents *)components{
	NSLog(@"dateString：%@", components);
}

@end
