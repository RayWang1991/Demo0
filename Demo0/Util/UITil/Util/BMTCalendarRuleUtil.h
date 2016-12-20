/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuzesheng@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "CocoaLumberjack/CocoaLumberjack.h"
#import "BMTResourceMenstruationPeriodStatusType.h"

@class BMTEntityAccount;
@class BMTEntityPeriodInfo;

@interface BMTCalendarRuleUtil : NSObject

+ (BMTMenstruationPeriodStatusType)getStatusTypeForDayDate:(NSDate *)dayDate
                                                   account:(BMTEntityAccount *)account
                                           periodInfoDatas:(NSArray *)periodInfoDatas;

+ (NSInteger)getMenstruationDayFromDayDate:(NSDate *)dayDate
                                forAccount:(BMTEntityAccount *)account;

+ (NSInteger)getOvulationDayFromDayDate:(NSDate *)dayDate
                             forAccount:(BMTEntityAccount *)account;

+ (NSInteger)getFertileDayFromDayDate:(NSDate *)dayDate
                           forAccount:(BMTEntityAccount *)account;

+ (BMTMenstruationPeriodStatusType)getStatusTypeForDayDate:(NSDate *)dayDate
                                                   account:(BMTEntityAccount *)account;

+ (BMTEntityPeriodInfo *)getCurrentEntityPeriodInfoWithTime:(NSDate *)dayDate
                                            periodInfoDatas:(NSArray *)periodInfoDatas;

@end
