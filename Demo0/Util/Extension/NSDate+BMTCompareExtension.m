/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSDate+BMTCompareExtension.h"

#import "BMTMiscUtil.h"
#import "NSCalendar+BMTDateConvertor.h"

@implementation NSDate (BMTCompareExtension)

// self 是否早于 other
- (BOOL)bmt_earlierThan:(NSDate*)other
{
    assert(other != nil);
    return [self compare:other] == NSOrderedAscending;
}

// self 是否早于或等于 other
- (BOOL)bmt_earlierThanOrEqualTo:(NSDate*)other
{
    assert(other != nil);
    return [self compare:other] != NSOrderedDescending;
}

// self 是否晚于 other
- (BOOL)bmt_laterThan:(NSDate*)other
{
    assert(other != nil);
    return [self compare:other] == NSOrderedDescending;
}

// self 是否晚于或等于 other
- (BOOL)bmt_laterThanOrEqualTo:(NSDate*)other
{
    assert(other != nil);
    return [self compare:other] != NSOrderedAscending;
}

// self 是否在 a 与 b 之间
- (BOOL)bmt_isBetween:(NSDate*)a and:(NSDate*)b
{
    assert(a != nil && b != nil);
    if ([b bmt_earlierThan:a]) {
        NSDate* temp = a;
        a = b;
        b = temp;
    }
    return [self bmt_laterThanOrEqualTo:a] && [self bmt_earlierThan:b];
}

-(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  //输入格式
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
  NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
  [dateFormatter setTimeZone:localTimeZone];
  
  NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
  //输出格式
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
  return dateString;
}

+ (NSString *)timeDisplayMMDDStringFromTime:(NSDate*)time
{
  if ([BMTMiscUtil isChineseLanguageEnvironment]) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = l10n(@"DatePicker.DayFormatWithoutYear");
    return [formatter stringFromDate:time];
  } else {
    NSDateFormatter *formatterDay = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    formatterDay.dateFormat = @"d";
    formatterMonth.dateFormat = @"MMM";
    return [NSString stringWithFormat:@"%@th %@", [formatterDay stringFromDate:time],
                                                  [formatterMonth stringFromDate:time]];
  }
}

+ (NSString *)timeDisplayMMDDHHMMSSStringFromTime:(NSDate*)time
{
  if ([BMTMiscUtil isChineseLanguageEnvironment]) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = l10n(@"DatePicker.TimeFormat");
    return [formatter stringFromDate:time];
  } else {
    NSDateFormatter *formatterDay = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterHours = [[NSDateFormatter alloc] init];
    formatterDay.dateFormat = @"d";
    formatterMonth.dateFormat = @"MMM";
    formatterHours.dateFormat = @"HH:mm:ss";
    return [NSString stringWithFormat:@"%@th %@ %@", [formatterDay stringFromDate:time],
                                                     [formatterMonth stringFromDate:time],
                                                     [formatterHours stringFromDate:time]];
  }
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
  NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
  NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
  NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
  NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
  NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
  NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
  return destinationDateNow;
}

+ (NSString *)getYYYYMMddDefaultTypeDate:(NSDate *)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"YYYY-MM-dd";
  return [dateFormatter stringFromDate:date];
}

+ (NSString *)getYYYYMMddSpecialTypeDate:(NSDate *)date {
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|
                                                                          NSCalendarUnitMonth|
                                                                          NSCalendarUnitDay
                                                                 fromDate:date];
  return [NSString stringWithFormat:l10n(@"General.YearMonthDay"),
                                    components.year,
                                    components.month,
                                    components.day];
}

@end
