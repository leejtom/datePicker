//
//  JTDatePickManager.m
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTDatePickManager.h"
#import "JTDatePickerHeaderView.h"

@interface JTDatePickManager ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *dismissView;
@property (nonatomic, strong) JTDatePickerHeaderView *headerView;


@end

@implementation JTDatePickManager

- (instancetype)initWithPickerModel:(JTDatePickerMode)mode{
	self = [super init];
	if(self){
		self.pickerMode = mode;
		[self setupView];
	}
	return self;
}
- (void)setupView{
	[self.view addSubview:self.dismissView];
	
	[self.view addSubview:self.headerView];
	[self.view addSubview:self.contentView];
	if(self.pickerMode == JTDatePickerModeDateAndWeekday){
		[self.contentView addSubview:self.datePicker];
	}else{
		[self.contentView addSubview:self.starAndEndTimePicker];
	}
	self.modalPresentationStyle = UIModalPresentationCustom;
	[self setupDismissViewTapHandler];
	[self headerViewButtonHandler];
}


- (void)viewWillLayoutSubviews{
	[super viewWillLayoutSubviews];
	
}

- (void)setupContentView{
	
	NSInteger pickHeight = 220;
	NSInteger headHeight = 40;
	
	CGRect contentFrame = CGRectMake(0, self.view.bounds.size.height -pickHeight, self.view.bounds.size.width, pickHeight);
	CGRect headerViewFrame = CGRectMake(0, self.view.bounds.size.height -pickHeight -headHeight, self.view.bounds.size.width, headHeight);
	
	self.dismissView.frame = self.view.bounds;
	self.contentView.frame = contentFrame;
	self.headerView.frame = headerViewFrame;
	if(self.pickerMode == JTDatePickerModeDateAndWeekday){
		self.datePicker.frame = self.contentView.bounds;
	}else{
		self.starAndEndTimePicker.frame = self.contentView.bounds;
	}
}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
	[self setupContentView];
	[self.view bringSubviewToFront:self.contentView];
}


- (void)headerViewButtonHandler {
	__weak id weak_self = self;
	self.headerView.cancelButtonHandlerBlock = ^{
		__strong id strong_self = weak_self;
		[strong_self cancelButtonHandler];
	};
	self.headerView.confirmButtonHandlerBlock =^{
		__strong JTDatePickManager *strong_self = weak_self;
		if(strong_self.pickerMode == JTDatePickerModeDateAndWeekday){
			[strong_self.datePicker tapSelectedHandler];
		}else{
			[strong_self.starAndEndTimePicker tapSelectedHandler];
		}
		[strong_self cancelButtonHandler];
	};
}

- (void)setupDismissViewTapHandler {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelButtonHandler)];
	[self.dismissView addGestureRecognizer:tap];
}

- (void)cancelButtonHandler {
	CGRect contentViewFrame = self.contentView.frame;
	contentViewFrame.origin.y = self.view.bounds.size.height;
	
	CGRect headerViewFrame = self.headerView.frame;
	headerViewFrame.origin.y = self.view.bounds.size.height;
	
	[UIView animateWithDuration:0.2 animations:^{
		self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
		self.contentView.frame = contentViewFrame;
		self.headerView.frame = headerViewFrame;
	}completion:^(BOOL finished) {
		[self dismissViewControllerAnimated:NO completion:nil];
	}];
}

- (UIView *)dismissView{
	if (!_dismissView) {
		_dismissView = [[UIView alloc] init];
		_dismissView.backgroundColor = [UIColor blackColor];
		_dismissView.alpha = 0.1;
	}
	return _dismissView;
}

- (JTDatePickerHeaderView *)headerView{
	if (!_headerView) {
		_headerView = [[JTDatePickerHeaderView alloc] init];
	}
	return _headerView;
}
- (UIView *)contentView{
	if (!_contentView) {
		_contentView = [[UIView alloc] init];
		_contentView.backgroundColor = [UIColor whiteColor];
	}
	return _contentView;
}

- (JTDatePicker *)datePicker{
	if (!_datePicker) {
		_datePicker = [[JTDatePicker alloc] init];
		_datePicker.backgroundColor = [UIColor whiteColor];
		_datePicker.minimumDate = [JTDateCommon getNextDayDate];
		_datePicker.maximumDate = [NSDate setYear:[JTDateCommon getCurrentYear]+1 month:12 day:31];
		_datePicker.autoSelect = YES;
	}
	return _datePicker;
}

- (JTStarAndEndTimePicker *)starAndEndTimePicker{
	if(!_starAndEndTimePicker){
		_starAndEndTimePicker = [[JTStarAndEndTimePicker alloc] init];
		_starAndEndTimePicker.backgroundColor = [UIColor whiteColor];
		_starAndEndTimePicker.autoSelect = YES;
	}
	return _starAndEndTimePicker;
}
@end
