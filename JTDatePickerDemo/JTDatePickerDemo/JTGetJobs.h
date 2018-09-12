//
//  JTGetJobs.h
//  JTDatePickerDemo
//
//  Created by JTom on 2018/5/31.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JTUserGender) {
	JTUserGenderUnknown,
	JTUserGenderMale,
	JTUserGenderFemale,
	JTUserGenderNeuter
};

@interface JTGetJobs : NSObject
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) NSUInteger age;
@property (nonatomic, readonly, assign) JTUserGender gender;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age gender:(JTUserGender) gender;
- (instancetype)userWithName:(NSString *)name age:(NSInteger)age gender:(JTUserGender) gender;

-(void)login;

@end
