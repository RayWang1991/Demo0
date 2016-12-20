/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "BMTUIConfig.h"

@implementation BMTUIConfig

+ (NSArray*)selectableRangeForMenstrucationDays {
  NSMutableArray* array = [NSMutableArray array];
  for (NSUInteger days = 1; days < 21; ++days) {
    [array addObject:@(days)];
  }
  return array;
}

+ (NSArray*)selectableDisplayStringsForMenstrucationDays {
  NSMutableArray* array = [NSMutableArray array];
  for (NSNumber* day in [self selectableRangeForMenstrucationDays]) {
    [array addObject:[NSString stringWithFormat:l10n(@"DatePicker.DayOnlyTempalte"), day]];
  }
  return array;
}

+ (NSArray*)selectableRangeForMenstrucationPeriodDays {
  NSMutableArray* array = [NSMutableArray array];
  for (NSUInteger days = 20; days < 91; ++days) {
    [array addObject:@(days)];
  }
  return array;
}

+ (NSArray*)selectableDisplayStringsForMenstrucationPeriodDays {
  NSMutableArray* array = [NSMutableArray array];
  for (NSNumber* day in [self selectableRangeForMenstrucationPeriodDays]) {
    [array addObject:[NSString stringWithFormat:l10n(@"DatePicker.DayOnlyTempalte"), day]];
  }
  return array;
}

+ (NSArray *)selectableDisplayStringsForFrequency {
  return @[l10n(@"Reminder.FrequencyDay"),l10n(@"Reminder.FrequencyWeek")];
}

+ (NSArray *)selectableDisplayStringsForTimes {
  return @[l10n(@"Reminder.FrequencyOnce"),
           l10n(@"Reminder.FrequencyTwice"),
           l10n(@"Reminder.FrequencyThreeTimes"),
           l10n(@"Reminder.FrequencyFourTimes"),
           l10n(@"Reminder.FrequencyFiveTimes")];
}

+ (NSArray*)selectableRangeForHour {
  NSMutableArray* array = [NSMutableArray array];
  for (NSUInteger hour = 0; hour < 24; ++hour) {
    [array addObject:@(hour)];
  }
  return array;
}

+ (NSArray *)selectableDisplayStringsForHour {
  NSMutableArray *array = [NSMutableArray array];
  for (NSNumber *hour in [self selectableRangeForHour]) {
    if ([hour integerValue] < 10) {
      [array addObject:[NSString stringWithFormat:@"0%@",hour]];
    } else {
      [array addObject:[NSString stringWithFormat:@"%@",hour]];
    }
  }
  return array;
}

+ (NSArray*)selectableRangeForMinute {
  NSMutableArray* array = [NSMutableArray array];
  for (NSUInteger minute = 0; minute < 60; ++minute) {
    [array addObject:@(minute)];
  }
  return array;
}

+ (NSArray *)selectableDisplayStringsForMinute {
  NSMutableArray *array = [NSMutableArray array];
  for (NSNumber *minute in [self selectableRangeForMinute]) {
    if ([minute integerValue] < 10) {
      [array addObject:[NSString stringWithFormat:@"0%@",minute]];
    } else {
      [array addObject:[NSString stringWithFormat:@"%@",minute]];
    }
  }
  return array;
}

+ (NSArray *)selectableDisplayStringsForWeek {
  return @[l10n(@"Reminder.Sat"),
           l10n(@"Reminder.Sun"),
           l10n(@"Reminder.Mon"),
           l10n(@"Reminder.Tue"),
           l10n(@"Reminder.Wed"),
           l10n(@"Reminder.Thu"),
           l10n(@"Reminder.Fri")];
}

@end
