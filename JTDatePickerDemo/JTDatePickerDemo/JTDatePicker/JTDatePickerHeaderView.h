//
//  JTDatePickerHeaderView.h
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^handlerBlock)(void);

@interface JTDatePickerHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton, *confirmButton;

@property (nonatomic, strong)  handlerBlock cancelButtonHandlerBlock;
@property (nonatomic, strong)  handlerBlock confirmButtonHandlerBlock;

@end
