/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuzesheng@bongmi.com
 */

#import "BMTCalendarRuleUtil.h"

#import "BMTEntityAccount.h"
#import "BMTEntityPeriodInfo.h"
#import "BMTEntityBodyStatus.h"
#import "BMTStorageManager.h"
#import "NSCalendar+BMTDateConvertor.h"
#import "BMTPeriodInfoTable.h"
#import "BMTBodyStatusTable.h"
#import "JSONKit.h"
#import "NSCalendar+BMTDateConvertor.h"


@implementation BMTCalendarRuleUtil

+ (BMTMenstruationPeriodStatusType)getStatusTypeForDayDate:(NSDate *)dayDate
                                                   account:(BMTEntityAccount *)account
                                           periodInfoDatas:(NSArray *)periodInfoDatas {
    NSArray *bodyStatusData = [self getBodyStatus:dayDate];
    if (bodyStatusData.count > 0) {
      if ([bodyStatusData[4] integerValue]) {
        if ([[NSCalendar currentCalendar] isDateLaterStartDate:dayDate]) {
          return kReportCalendarDayTypeCalculateMenstruation;
        } else {
          return kReportCalendarDayTypeMenustration;
        }
      } else {
        return [self getPeriodInfoType:dayDate
                                 datas:periodInfoDatas
              isBodyStatusMenstruation:NO];
      }
    } else {
      return [self getPeriodInfoType:dayDate
                               datas:periodInfoDatas
            isBodyStatusMenstruation:YES];
    }
}

+ (BMTMenstruationPeriodStatusType)getStatusTypeForDayDate:(NSDate *)dayDate
                                                   account:(BMTEntityAccount *)account {
  NSArray *periodInfoDatas = [self getPeriodInfoFromLocal];
  return [[self class] getStatusTypeForDayDate:dayDate
                                       account:account
                               periodInfoDatas:periodInfoDatas];
}

+ (NSInteger)getMenstruationDayFromDayDate:(NSDate *)dayDate
                                forAccount:(BMTEntityAccount *)account {
  dayDate = [[NSCalendar currentCalendar] bmt_dayStartDateForDate:dayDate];
  NSArray *periodInfoDatas = [self getPeriodInfoFromLocal];
  NSInteger menstruationDay = -1;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  for (BMTEntityPeriodInfo *entityPeriodInfo in periodInfoDatas) {
    NSDate *menstruationStartDate = entityPeriodInfo.menstruationStartTime;
    NSDate *menstruationEndDate = entityPeriodInfo.menstruationEndTime;
    if ([calendar date:dayDate
         isBetweenDate:menstruationStartDate
               endDate:menstruationEndDate]) {
      return 0;
    } else {
      NSInteger diffDay = [calendar bmt_dayIntervalFromDate:dayDate
                                                     toDate:menstruationStartDate];
      if ((menstruationDay > diffDay || menstruationDay == -1) && diffDay > 0) {
        menstruationDay = diffDay;
      }
    }
  }
  return menstruationDay;
}

+ (NSInteger)getOvulationDayFromDayDate:(NSDate *)dayDate
                             forAccount:(BMTEntityAccount *)account {
  dayDate = [[NSCalendar currentCalendar] bmt_dayStartDateForDate:dayDate];
  NSArray *periodInfoDatas = [self getPeriodInfoFromLocal];
  NSInteger ovulationDay = -1;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  for (BMTEntityPeriodInfo *entityPeriodInfo in periodInfoDatas) {
      NSInteger diffDay = [calendar bmt_dayIntervalFromDate:dayDate
                                                     toDate:entityPeriodInfo.ovulationTime];
      if ((ovulationDay > diffDay || ovulationDay == -1) && diffDay > 0) {
        ovulationDay = diffDay;
    }
  }
  return ovulationDay;
}

+ (NSInteger)getFertileDayFromDayDate:(NSDate *)dayDate
                           forAccount:(BMTEntityAccount *)account {
  dayDate = [[NSCalendar currentCalendar] bmt_dayStartDateForDate:dayDate];
  NSArray *periodInfoDatas = [self getPeriodInfoFromLocal];
  NSInteger fertileDay = -1;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  for (BMTEntityPeriodInfo *entityPeriodInfo in periodInfoDatas) {
    NSDate *ovulationStartDate = [calendar bmt_dateFromDate:entityPeriodInfo.ovulationTime
                                               withDayOffset:-5];
    NSDate *ovulationEndDate = [calendar bmt_dateFromDate:entityPeriodInfo.ovulationTime
                                            withDayOffset:1];
    if ([calendar date:dayDate
         isBetweenDate:ovulationStartDate
               endDate:ovulationEndDate]) {
      return 0;
    } else {
      NSInteger diffDay = [calendar bmt_dayIntervalFromDate:dayDate
                                                     toDate:ovulationStartDate];
      if ((fertileDay > diffDay || fertileDay == -1) && diffDay > 0) {
        fertileDay = diffDay;
      }
    }
  }
  return fertileDay;
}

+ (NSArray *)getPeriodInfoFromLocal {
  __block NSArray *periodInfoDatas = [[NSArray alloc] init];
  [[BMTStorageManager sharedInstance]
   inDBForPeriodInfo:^NSError *(FMDatabase *db, BMTPeriodInfoTable *table) {
     periodInfoDatas = [table getAllPeriodInfo];
     return nil;
   }];
  return periodInfoDatas;
}

+ (NSArray *)getBodyStatus:(NSDate *)date {
  __block NSArray *allBodyStatus;
  [[BMTStorageManager sharedInstance]
   inDBForBodyStatus:^NSError *(FMDatabase *db, BMTBodyStatusTable *table) {
     allBodyStatus =
     [table getBodyStatusWithTimestamp:[[NSCalendar currentCalendar] bmt_dayStartDateForDate:date]
                               andType:@(kBMTBodyStatusPeriod)];
     return nil;
   }];
  if (allBodyStatus.count != 0) {
    BMTEntityBodyStatus *bodyStatus = allBodyStatus[0];
    NSDictionary *dic = [bodyStatus.detail objectFromJSONString];
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *entityAttributes = @[@"bloodClot", @"color", @"cramps", @"isEnd", @"isInProgress",
                                  @"isStart", @"volume"];
    for (int i = 0; i < entityAttributes.count; i++) {
      [arr addObject:[dic valueForKey:entityAttributes[i]]];
    }
    return arr;
  } else {
    return nil;
  }
}

+ (BMTMenstruationPeriodStatusType)getPeriodInfoType:(NSDate *)dayDate
                                               datas:(NSArray *)periodInfoDatas
                            isBodyStatusMenstruation:(BOOL)isBodyStatusMenstruation {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  dayDate = [calendar bmt_dayStartDateForDate:dayDate];
  for (BMTEntityPeriodInfo *entityPeriodInfo in periodInfoDatas) {
    if ([calendar date:dayDate
              isBetweenDate:entityPeriodInfo.fertileWindowStartTime
                    endDate:entityPeriodInfo.fertileWindowEndTime]) {
      if ([calendar date:dayDate
                isBetweenDate:entityPeriodInfo.ovulationTime
                      endDate:entityPeriodInfo.ovulationTime]) {
        return kReportCalendarDayTypeOvulationDays;
      }
      return kReportCalendarDayTypeOvulation;
    } else if ([calendar date:dayDate
         isBetweenDate:entityPeriodInfo.menstruationStartTime
               endDate:entityPeriodInfo.menstruationEndTime]) {
      if (!isBodyStatusMenstruation) {
        return kReportCalendarDayTypeNormal;
      }
      if ([calendar isDateLaterStartDate:dayDate]) {
        return kReportCalendarDayTypeCalculateMenstruation;
      } else {
        return kReportCalendarDayTypeMenustration;
      }
    }
  }
  return kReportCalendarDayTypeNormal;
}

+ (BMTEntityPeriodInfo *)getCurrentEntityPeriodInfoWithTime:(NSDate *)dayDate
                                            periodInfoDatas:(NSArray *)periodInfoDatas {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  dayDate = [calendar bmt_dayStartDateForDate:dayDate];
  BMTEntityPeriodInfo *entityPeriodInfo = nil;
  for (BMTEntityPeriodInfo *entity in periodInfoDatas) {
    NSDate *startDate = entity.menstruationStartTime;
    NSDate *endDate = [calendar bmt_dateFromDate:startDate
                                   withDayOffset:entity.periodDuration.integerValue];
    if ([calendar date:dayDate
         isBetweenDate:startDate
               endDate:endDate]) {
      entityPeriodInfo = entity;
      break;
    }
  }
  return entityPeriodInfo;
}

@end
