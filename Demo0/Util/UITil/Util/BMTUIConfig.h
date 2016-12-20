/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface BMTUIConfig : NSObject

// 月经持续天数，UI上可以选择的范围, NSArray<NSNumber>
+ (NSArray*)selectableRangeForMenstrucationDays;

// 月经持续天数，UI上显示的选择字符串，NSArray<NSArray>
+ (NSArray*)selectableDisplayStringsForMenstrucationDays;

// 月经周期天数，UI上可以选择的范围, NSArray<NSNumber>
+ (NSArray*)selectableRangeForMenstrucationPeriodDays;

// 月经周期天数，UI上显示的选择字符串，NSArray<NSString>
+ (NSArray*)selectableDisplayStringsForMenstrucationPeriodDays;

+ (NSArray *)selectableDisplayStringsForFrequency;

+ (NSArray *)selectableDisplayStringsForTimes;

+ (NSArray *)selectableDisplayStringsForWeek;

+ (NSArray *)selectableDisplayStringsForHour;

+ (NSArray *)selectableDisplayStringsForMinute;

@end
