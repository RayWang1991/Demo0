/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import <Foundation/Foundation.h>

#import "BMTResourceUserPurposeType.h"

@class BMTEntityPeriodInfo;

@interface BMTStringDataDictionaryUtil : NSObject

+ (NSString *)getDailyStatusTipsWithEntityPeriodInfo:(BMTEntityPeriodInfo *)entityPeriodInfo
                                         purposeType:(BMTAccountType)accountType;

@end
