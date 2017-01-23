/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSDate (BMTCompareExtension)

// self 是否早于 other
- (BOOL)bmt_earlierThan:(NSDate*)other;

// self 是否早于或等于 other
- (BOOL)bmt_earlierThanOrEqualTo:(NSDate*)other;

// self 是否晚于 other
- (BOOL)bmt_laterThan:(NSDate*)other;

// self 是否晚于或等于 other
- (BOOL)bmt_laterThanOrEqualTo:(NSDate*)other;

// self 是否在 a 与 b 之间，前闭后开
// 即 如果 a < b, [a isBetween:a and:b] == YES, [b isBetween:a and:b] = NO
- (BOOL)bmt_isBetween:(NSDate*)a and:(NSDate*)b;

+ (NSString *)timeDisplayMMDDStringFromTime:(NSDate*)time;

+ (NSString *)timeDisplayMMDDHHMMSSStringFromTime:(NSDate*)time;

+ (NSDate *)getNowDateFromatAnDate:(NSDate*)anyDate;

+ (NSString *)getYYYYMMddDefaultTypeDate:(NSDate *)date;

+ (NSString *)getYYYYMMddSpecialTypeDate:(NSDate *)date;

@end
