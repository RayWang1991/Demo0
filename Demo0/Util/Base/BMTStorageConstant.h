/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

// db
#define BMT_DB_NAME @"main.db"
#define BMT_TABLENAME_APPCONFIG @"app"
#define BMT_TABLENAME_ACCOUNT @"account"
#define BMT_TABLENAME_MESSAGE @"message"
#define BMT_TABLENAME_TEMPERATURE @"temperature"
#define BMT_TABLENAME_FIRMWARE @"firmware"
#define BMT_TABLENAME_BODYSTATUS @"bodystatus"
#define BMT_TABLENAME_REMINDER @"reminderSummary"
#define BMT_TABLENAME_REMINDERLIST @"reminderDetail"
#define BMT_TABLENAME_PERIODINFO @"periodInfo"
#define BMT_TABLENAME_DAILYTASK @"dailyTask"
#define BMT_TABLENAME_HEALTHTIP @"healthTip"
#define BMT_TABLENAME_PUSHMESSAGE @"pushMessage"
#define BMT_TABLENAME_MICROCLASSMESSAGE @"microClassMessage"
#define BMT_DB_CURRENT_VERSION @"1.0"

// error
extern NSString* const kStorageErrorDomain;

typedef NS_ENUM(NSInteger, StorageErrorCode) {
    kShouldNotOccur = 1
};
