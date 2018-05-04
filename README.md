
## 目前的进度
支持两种类型：
1. 年月日周
2. 起止时间
## 使用
#### 年月日周
```
代理 JTDatePickerDelegate
```
```
//年月日周
- (IBAction)yearMonthDayWeekAction:(UIButton *)sender {
	JTDatePickManager *datePickManager = [[JTDatePickManager alloc] initWithPickerModel:JTDatePickerModeDateAndWeekday];
	JTDatePicker *datePicker = datePickManager.datePicker;
	datePicker.delegate = self;
	[self presentViewController:datePickManager animated:YES completion:nil];
}
```
```
#pragma mark - JTDatePickerDelegate
- (void)datePicker:(JTDatePicker *)datePicker didSelectDateComponents:(NSDateComponents *)components{
	NSLog(@"dateString：%@", components);
}
```

#### 起止时间

```
代理 JTStarAndEndTimePickerDelegate
```
```
- (IBAction)startAndEndTimeAction:(UIButton *)sender {
	JTDatePickManager *datePickManager = [[JTDatePickManager alloc] initWithPickerModel:JTDatePickerModeStartAndEndTime];
	JTStarAndEndTimePicker *datePicker = datePickManager.starAndEndTimePicker;
	datePicker.delegate = self;
	[self presentViewController:datePickManager animated:YES completion:nil];
}
```
```
#pragma mark - JTStarAndEndTimePickerDelegate
- (void)datePicker:(JTStarAndEndTimePicker *)datePicker didSelectSartDateComponents:(NSDateComponents *)startCompon endDateComponents:(NSDateComponents *)endCompon{
	NSLog(@"%02zd:%02zd - %02zd:%02zd", startCompon.hour, startCompon.minute, endCompon.hour, endCompon.minute);
}
```





