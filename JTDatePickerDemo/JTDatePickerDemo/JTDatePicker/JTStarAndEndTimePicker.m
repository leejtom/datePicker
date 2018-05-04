//
//  JTStarAndEndTimePicker.m
//  JTDatePickerDemo
//
//  Created by JTom on 2018/4/27.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTStarAndEndTimePicker.h"
#import "UIColor+JTHex.h"

#define StartPickerTAG 233
#define ENDPickerTAG 244
#define MAX_Hour 24
#define MAX_Minute 60
#define FONT [UIFont systemFontOfSize:25]
@interface JTStarAndEndTimePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>{
	NSInteger startHour, startMinute, endHour, endMinute;
}

@property (nonatomic, strong) NSArray *hourList, *endHourList;
@property (nonatomic, strong) NSArray *minuteList, *endMinuteList;
@property (nonatomic, strong) UILabel *intervalLab1, *intervalLab2, *intervalLab3;
@property (nonatomic, strong) UIView *line1, *line2;
@end


@implementation JTStarAndEndTimePicker

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self addSubview:self.intervalLab1];
		[self addSubview:self.intervalLab2];
		[self addSubview:self.intervalLab3];
		
		[self addSubview:self.startPickerView];
		[self addSubview:self.endPickerView];
		[self addSubview:self.line1];
		[self addSubview:self.line2];
		
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat intervalWidth = 20;
	CGFloat rowHeigt = 32;
	CGFloat lineHeigt = 0.667;
	CGFloat viewHeight = self.bounds.size.height;
	CGFloat viewWidth = self.bounds.size.width;
	CGFloat pickWidth = self.bounds.size.width/2 - intervalWidth ;
	CGFloat pickHeight = viewHeight;
	
	self.intervalLab1.frame = CGRectMake(pickWidth / 2, 0, intervalWidth, pickHeight);
	self.intervalLab2.frame = CGRectMake(pickWidth, 0, intervalWidth, pickHeight);
	self.intervalLab3.frame = CGRectMake(pickWidth / 2 + pickWidth + intervalWidth, 0, intervalWidth, pickHeight);
	
	self.startPickerView.frame = CGRectMake(0, 0, pickWidth, pickHeight);
	self.endPickerView.frame = CGRectMake(pickWidth + intervalWidth, 0, pickWidth, pickHeight);
	
	self.line1.frame = CGRectMake(0, (viewHeight - rowHeigt -lineHeigt)/2, viewWidth, lineHeigt);
	self.line2.frame = CGRectMake(0, (viewHeight + rowHeigt +lineHeigt)/2, viewWidth, lineHeigt);
	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if (pickerView.tag == StartPickerTAG) {
		return component == 0? self.hourList.count : self.minuteList.count;
	}else{
		return component == 0? self.endHourList.count : self.endMinuteList.count;
	}
}

//实现此方法后： pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 方法将不会执行
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	//讲分隔线设置为透明色
	for (UIView *singleLine in pickerView.subviews) {
		if (singleLine.frame.size.height < 1) {
			singleLine.backgroundColor = [UIColor clearColor];
		}
	}
	//自定义row内容
	UILabel *timeLabe = [UILabel new];
	timeLabe.textAlignment = NSTextAlignmentCenter;
	//setting
	NSString *content = @"-";
	if (component == 0) {
		if (pickerView.tag == StartPickerTAG && row < self.hourList.count) {
			content = self.hourList[row];
		}else if (row < self.endHourList.count){
			content = self.endHourList[row];
		}
	}else{
		if (pickerView.tag == StartPickerTAG && row < self.minuteList.count) {
			content = self.minuteList[row];
		} else if(row < self.endMinuteList.count){
			content = self.endMinuteList[row];
		}
	}
	timeLabe.text = content;
	timeLabe.textColor = [UIColor blackColor];
	timeLabe.font = FONT;
	return timeLabe;
}

//selsect
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	[self updateSelectData];
	
	[self updatePickerWithTag:pickerView.tag inComponent:component];
	
	if (self.isAutoSelect) {
		[self tapSelectedHandler];
	}
}

- (void)updateSelectData{
	startHour = [self.hourList[[self.startPickerView selectedRowInComponent:0]] integerValue];
	startMinute = [self.minuteList[[self.startPickerView selectedRowInComponent:1]] integerValue];
	endHour = [self.endHourList[[self.endPickerView selectedRowInComponent:0]] integerValue];
	endMinute = [self.endMinuteList[[self.endPickerView selectedRowInComponent:1]] integerValue];
}

- (void)updatePickerWithTag:(NSInteger)tag inComponent:(NSInteger)component{
	if (tag == StartPickerTAG ) {
		
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			self.endHourList = [self createHourArrayWithIndex:self->startHour];
			self.endMinuteList = [self createMinuteArrayWithIndex:self->startMinute];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.endPickerView reloadAllComponents];
				[self.endPickerView selectRow:0 inComponent:0 animated:YES];
				[self.endPickerView selectRow:0 inComponent:1 animated:YES];
			});
		});
		
	}else{
		if(component == 0 ){
			dispatch_async(dispatch_get_global_queue(0, 0), ^{
				[self updateEndMinute];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.endPickerView reloadAllComponents];
					if(self->startHour == self->endHour){
						[self.endPickerView selectRow:0 inComponent:1 animated:YES];
					}
				});
			});
		}
	}
}

- (void)tapSelectedHandler{
	if(_delegate && [_delegate respondsToSelector:@selector(datePicker:didSelectSartDateComponents:endDateComponents:)]){
		NSDateComponents *startComp = [[NSDateComponents alloc] init];
		NSDateComponents *endComp = [[NSDateComponents alloc] init];
		startComp.hour = startHour;
		startComp.minute = startMinute;
		
		endComp.hour = endHour;
		endComp.minute = endMinute;
		[_delegate datePicker:self didSelectSartDateComponents:startComp endDateComponents:endComp];
	}
}

- (void)updateEndMinute{
	if(startHour >= endHour){
		self.endMinuteList = [self createMinuteArrayWithIndex:startMinute];
	}else{
		self.endMinuteList = [self createMinuteArrayWithIndex:0];
	}
}

- (NSMutableArray *)createHourArrayWithIndex:(NSInteger )index{
	return [self createArrayWithIndex:index MaxNumer:MAX_Hour];
}

- (NSMutableArray *)createMinuteArrayWithIndex:(NSInteger )index{
	return [self createArrayWithIndex:index MaxNumer:MAX_Minute];
}

- (NSMutableArray *)createArrayWithIndex:(NSInteger )index MaxNumer:(NSInteger )max{
	NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:max];
	for ( ;index <max ; index++) {
		[arrayM addObject:[NSString stringWithFormat:@"%02ld",index]];
	}
	return arrayM;
}


- (UIPickerView *)startPickerView{
	if (!_startPickerView) {
		_startPickerView = [[UIPickerView alloc] init];
		_startPickerView.delegate = self;
		_startPickerView.dataSource = self;
		_startPickerView.tag = StartPickerTAG;
	}
	return _startPickerView;
}

- (UIPickerView *)endPickerView{
	if (!_endPickerView) {
		_endPickerView = [[UIPickerView alloc] init];
		_endPickerView.delegate = self;
		_endPickerView.dataSource = self;
		_endPickerView.tag = ENDPickerTAG;
	}
	return _endPickerView;
}
- (NSArray *)hourList{
	if (!_hourList) {
		NSMutableArray *hours = [NSMutableArray arrayWithCapacity:24];
		for (NSUInteger i = 0; i <=23 ; i++) {
			[hours addObject:[NSString stringWithFormat:@"%02ld",i]];
		}
		_hourList = hours;
	}
	return _hourList;
}

- (NSArray *)endHourList{
	if (!_endHourList) {
		NSInteger miniHour = 0;
		NSMutableArray *hours = [NSMutableArray arrayWithCapacity:24];
		for (NSUInteger i = miniHour; i <=23 ; i++) {
			[hours addObject:[NSString stringWithFormat:@"%02ld",i]];
		}
		_endHourList = hours;
	}
	return _endHourList;
}


- (NSArray *)minuteList{
	if (!_minuteList) {
		NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:24];
		for (NSUInteger i = 0; i <=59 ; i++) {
			[minutes addObject:[NSString stringWithFormat:@"%02ld",i]];
		}
		_minuteList = minutes;
	}
	return _minuteList;
}

- (NSArray *)endMinuteList{
	if (!_endMinuteList) {
		NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:24];
		for (NSUInteger i = 0; i <=59 ; i++) {
			[minutes addObject:[NSString stringWithFormat:@"%02ld",i]];
		}
		_endMinuteList = minutes;
	}
	return _endMinuteList;
}

- (UILabel *)intervalLab1 {
	if (!_intervalLab1) {
		_intervalLab1 = [[UILabel alloc] init];
		_intervalLab1.text = @":";
	}
	return _intervalLab1;
}

- (UILabel *)intervalLab2 {
	if (!_intervalLab2) {
		_intervalLab2 = [[UILabel alloc] init];
		_intervalLab2.text = @"-";
	}
	return _intervalLab2;
}
- (UILabel *)intervalLab3 {
	if (!_intervalLab3) {
		_intervalLab3 = [[UILabel alloc] init];
		_intervalLab3.text = @":";
	}
	return _intervalLab3;
}

- (UIView *)line1{
	if (!_line1) {
		_line1 = [[UIView alloc] init];
		_line1.backgroundColor = [UIColor colorWithHexString:@"#32000000"];
	}
	return _line1;
}
- (UIView *)line2{
	if (!_line2) {
		_line2 = [[UIView alloc] init];
		_line2.backgroundColor = [UIColor colorWithHexString:@"#32000000"];
	}
	return _line2;
}
@end
