//
//  JTDatePickManager.h
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTDatePickerHeader.h"

typedef NS_ENUM(NSUInteger, JTDatePickerMode) {
	JTDatePickerModeDateAndWeekday, //年月日周
	JTDatePickerModeStartAndEndTime 	//起止时间
};

@interface JTDatePickManager : UIViewController

@property (nonatomic, strong) JTDatePicker *datePicker;
@property (nonatomic, strong) JTStarAndEndTimePicker *starAndEndTimePicker;

@property (nonatomic, assign) JTDatePickerMode pickerMode;

- (instancetype)initWithPickerModel:(JTDatePickerMode)mode;

@end
