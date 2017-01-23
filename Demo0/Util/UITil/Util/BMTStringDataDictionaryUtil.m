/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import "BMTStringDataDictionaryUtil.h"

#import "BMTEntityPeriodInfo.h"
#import "BMTResourceMetaInfoPeriodStageType.h"

#import "NSCalendar+BMTDateConvertor.h"

#import <objc/runtime.h>

static BMTStringDataDictionaryUtil *sharedInstance;

@interface BMTStringDataDictionaryUtil()

@end

static const NSString *tipsHead = @"Hint";
static const NSString *tipsEnd = @"Title";

@implementation BMTStringDataDictionaryUtil

+ (NSString *)getDailyStatusTipsWithEntityPeriodInfo:(BMTEntityPeriodInfo *)entityPeriodInfo
                                         purposeType:(BMTAccountType)accountType {
  BMTMetaInfoPeriodStageType stage = [entityPeriodInfo.stage integerValue];
  NSString *tips = [NSString stringWithFormat:@"%@.%@.%@.%@",
                    tipsHead,
                    BMTReflectStringForMember(accountType),
                    BMTReflectStringForMember(stage),
                    tipsEnd];
  
  NSInteger diffDay = 0;
  NSDate *nowDate = [[NSCalendar currentCalendar] bmt_dayStartDateForDate:[NSDate date]];
  
  if (entityPeriodInfo) {
    if (accountType != kBMTAccountTypePregnancyMonitor) {
      if (stage == kMetaInfoPeriodStageTypeSafeHighTemp ||
          stage == kMetaInfoPeriodStageTypePregnant) {
        diffDay = [[NSCalendar  currentCalendar] bmt_dayIntervalFromDate:entityPeriodInfo.ovulationTime
                                                                  toDate:nowDate];
      }
    } else {
      diffDay = [[NSCalendar  currentCalendar] bmt_dayIntervalFromDate:entityPeriodInfo.menstruationStartTime
                                                                toDate:nowDate] + 1;
    }
  }
  
  return [NSString stringWithFormat:l10n(tips), diffDay];
}

@end
