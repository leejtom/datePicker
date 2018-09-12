//
//  ViewController.h
//  JTDatePickerDemo
//
//  Created by JTom on 2018/4/25.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)yearMonthDayWeekAction:(UIButton *)sender;
- (IBAction)startAndEndTimeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *yearMonthDay;
@property (weak, nonatomic) IBOutlet UILabel *startAndEndTime;

@end

