//
//  UIColor+JTHex.h
//  Demo
//
//  Created by JTom on 2018/4/23.
//  Copyright © 2018年 LeeJTom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JTHex)

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger) length;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
