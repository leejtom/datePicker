//
//  JTStarAndEndTimePicker.h
//  JTDatePickerDemo
//
//  Created by JTom on 2018/4/27.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTDatePickerHeader.h"

@protocol JTStarAndEndTimePickerDelegate;

@interface JTStarAndEndTimePicker : UIView

@property (nonatomic, strong) UIPickerView *startPickerView, *endPickerView;

@property (nonatomic, weak) id<JTStarAndEndTimePickerDelegate> delegate;

@property (nonatomic, assign, getter=isAutoSelect) BOOL autoSelect;//自动选择日期

- (void)tapSelectedHandler;

@end

@protocol JTStarAndEndTimePickerDelegate <NSObject>

- (void)datePicker:(JTStarAndEndTimePicker *)datePicker didSelectSartDateComponents:(NSDateComponents *)startCompon endDateComponents:(NSDateComponents *) endCompon;

@end
