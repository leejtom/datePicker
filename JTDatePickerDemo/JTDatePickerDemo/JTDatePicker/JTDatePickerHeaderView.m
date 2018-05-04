//
//  JTDatePickerHeaderView.m
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import "JTDatePickerHeaderView.h"
#import "UIColor+JTHex.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@implementation JTDatePickerHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
		[self addSubview:self.titleLabel];
		[self addSubview:self.cancelButton];
		[self addSubview:self.confirmButton];
	}
	return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	CGSize size = self.frame.size;
	NSInteger padding = 10;
	NSInteger btnWidth = 40;
	
	self.cancelButton.frame = CGRectMake(padding, 0, btnWidth, size.height);
	self.confirmButton.frame = CGRectMake(size.width - btnWidth- padding, 0, btnWidth, size.height);
	self.titleLabel.frame = CGRectMake(btnWidth+padding, 0, size.width - btnWidth*2 - padding*2, size.height);
}

- (void)cancelButtonHandler {
	if (self.cancelButtonHandlerBlock) {
		self.cancelButtonHandlerBlock();
	}
}

- (void)confirmButtonHandler {
	if (self.confirmButtonHandlerBlock) {
		self.confirmButtonHandlerBlock();
	}
}

- (UILabel *)titleLabel{
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.font = [UIFont systemFontOfSize:17];
		_titleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
		_titleLabel.text = @"请选择时间";
		_titleLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleLabel;
}

- (UIButton *)cancelButton{
	if (!_cancelButton) {
		_cancelButton = [[UIButton alloc] init];
		[_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
		[_cancelButton setTitleColor:[UIColor colorWithHexString:@"#87888D"] forState:UIControlStateNormal];
		[_cancelButton addTarget:self action:@selector(cancelButtonHandler) forControlEvents:UIControlEventTouchUpInside];
	}
	return _cancelButton;
}

- (UIButton *)confirmButton{
	if (!_confirmButton) {
		_confirmButton = [[UIButton alloc] init];
		[_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
		[_confirmButton setTitleColor:[UIColor colorWithHexString:@"#5282EB"] forState:UIControlStateNormal];
		[_confirmButton addTarget:self action:@selector(confirmButtonHandler) forControlEvents:UIControlEventTouchUpInside];
	}
	return _confirmButton;
}
@end
