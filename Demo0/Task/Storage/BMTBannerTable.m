/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTBannerTable.m 
 * Created by ray wang on 16/12/20.
 */

#import "BMTBannerTable.h"
#import "NSDictionary+ForStorageField.h"



#define BANNER_COLUMN_NAME @"name"
//#define BANNER_COLUMN_ID @"bannerId"
#define BANNER_COLUMN_ALTTEXT @"altText"
#define BANNER_COLUMN_HEIGHT @"height"
#define BANNER_COLUMN_WIDTH @"width"
#define BANNER_COLUMN_HREF @"href"
#define BANNER_COLUMN_IMGSRC @"imgSrc"
#define BANNER_COLUMN_LANGUAGE @"language"
#define BANNER_COLUMN_STATUS @"status"
#define BANNER_COLUMN_TYPE @"type"

#define BMT_TABLENAME_BANNER@"banner"

/*
#define BANNER_COLUMN_EMAIL @"email"
#define BANNER_COLUMN_BIRTHDAY @"birthday"
#define BANNER_COLUMN_LASTMENSTRUATION @"lastMenstruation"
#define BANNER_COLUMN_MENSTRUATIONDAYS @"menstruationDays"
#define BANNER_COLUMN_MENSTRUATIONPERIOD @"menstruationPeriod"
#define BANNER_COLUMN_CREATETIME @"createTime"
#define BANNER_COLUMN_SELFMEMBERID @"selfMemberId"
#define BANNER_COLUMN_AVATARURL @"avatarURL"
#define BANNER_COLUMN_TYPE @"type"
#define BANNER_COLUMN_REGISTERTIMEZONE @"registerTimezone"
#define BANNER_COLUMN_MINPERIODDAYS @"minPeriodDays"
#define BANNER_COLUMN_MAXPERIODDAYS @"maxPeriodDays"
#define BANNER_COLUMN_FLAG @"flag"
#define BANNER_COLUMN_LCINSTALLATIONID @"lcInstallationId"
#define BANNER_COLUMN_PHONEID @"phoneId"
#define BANNER_COLUMN_ROLE @"role"
#define BANNER_COLUMN_SENDERCODE @"senderCode"
#define BANNER_COLUMN_RECEIVERCODE @"receiverCode"
#define BANNER_AVATAR_URL_PREFIX @"http://lollypop-avatar.qiniudn.com/"
#define BANNER_COLUMN_SOURCE @"source"
#define BANNER_COLUMN_IMTOKEN @"imToken"
*/

@implementation  BMTEntityBanner

- (instancetype)initWithDBRecord:(NSDictionary *)content {
  self = [super init];
  if (!self) {
    return nil;
  }

  self.name = [content stringValueForDBFieldName:BANNER_COLUMN_NAME];

  self.altText = [content stringValueForDBFieldName:BANNER_COLUMN_ALTTEXT];
  self.imgSrc = [content stringValueForDBFieldName:BANNER_COLUMN_IMGSRC];
  self.height = [content numberValueForDBFieldName:BANNER_COLUMN_HEIGHT];
  self.href = [content stringValueForDBFieldName:BANNER_COLUMN_HREF];
  self.width = [content numberValueForDBFieldName:BANNER_COLUMN_WIDTH];

  self.language = [content stringValueForDBFieldName:BANNER_COLUMN_LANGUAGE];

  self.type = [content numberValueForDBFieldName:BANNER_COLUMN_TYPE];
  self.status = [content numberValueForDBFieldName:BANNER_COLUMN_STATUS];

  return self;
}

- (NSDictionary *)encodeForDBRecord {

  NSMutableDictionary *result = [NSMutableDictionary dictionary];

  [result setValue:self.name
            forKey:BANNER_COLUMN_NAME];
  [result setValue:self.altText
            forKey:BANNER_COLUMN_ALTTEXT];
  [result setValue:self.imgSrc
            forKey:BANNER_COLUMN_IMGSRC];
  [result setValue:self.type
            forKey:BANNER_COLUMN_TYPE];
  [result setValue:self.status
            forKey:BANNER_COLUMN_STATUS];
  [result setValue:self.language
            forKey:BANNER_COLUMN_LANGUAGE];
  [result setValue:self.height
            forKey:BANNER_COLUMN_HEIGHT];
  [result setValue:self.width
            forKey:BANNER_COLUMN_WIDTH];
  [result setValue:self.href
            forKey:BANNER_COLUMN_HREF];

  return result;
}

- (instancetype)initWithResource:(BMTResourceBanner *)resource {
  self = [super init];
  if (!self) {
    return nil;
  }
  self.altText = resource.altText;
  self.status = resource.status;
  self.href = resource.href;
  self.imgSrc = resource.imgSrc;
  self.language = resource.language;
  self.width = resource.width;
  self.height = resource.height;

  return self;
}

- (BOOL)updateBanner:(BMTEntityBanner *)banner {
    return NO;
}


@end

@implementation BMTBannerTable {

}

- (instancetype)initWithDatabase:(FMDatabase *)db {
  return [self initWithTableName:BMT_TABLENAME_BANNER
                      inDatabase:db
                     withKeyName:BANNER_COLUMN_IMGSRC];
}
- (BOOL)addBanner:(BMTEntityBanner *)banner {
  return [self addItemOrReplace:banner];
}
- (BOOL)addBanners:(NSArray *)bannerArray {
  BOOL success=YES;
  for(BMTEntityBanner *banner in bannerArray){
    success=success&&[self addBanner:banner];
  }
  return success;
}
- (BOOL)deleteAllBanners {
  return [self deleteAllItems];
}

- (NSArray<BMTEntityBanner *> *)getBannersOrderedByName:(NSUInteger)num {
  NSInteger count=[self selectItemCount];
  if(num>count){
    return nil;
  }
  NSArray *resArray=[self selectItemsWithOtherPart:[NSString stringWithFormat:@"order by name desc "
          "LIMIT 0,%@",@(num)]
                                         withParam:nil];
  return resArray;
}

- (NSArray *)getBannersOrderedById:(NSUInteger)num {
  NSString *otherPart = [NSString stringWithFormat:@"order by %@ desc",
          BANNER_COLUMN_IMGSRC];
  return [self selectItemsWithOtherPart:otherPart
                              withParam:nil];
}

#pragma mark - override

- (NSError *)createTableIfNeeded {
  NSString *sql = @"CREATE TABLE IF NOT EXISTS " BMT_TABLENAME_BANNER @"("
      //BANNER_COLUMN_ID @" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      BANNER_COLUMN_NAME@" TEXT PRIMARY KEY NOT NULL,"
      BANNER_COLUMN_STATUS @" INTEGER,"
      BANNER_COLUMN_TYPE @" INTEGER,"
      BANNER_COLUMN_IMGSRC @" TEXT ,"
      BANNER_COLUMN_HREF @" TEXT,"
      BANNER_COLUMN_ALTTEXT @" TEXT,"
      BANNER_COLUMN_LANGUAGE @" TEXT,"
      BANNER_COLUMN_HEIGHT @" INTEGER,"
      BANNER_COLUMN_WIDTH @" INTEGER)";

  BOOL success = [self.db executeUpdate:sql];

  if (!success) {
    return [self.db lastError];
  }
  return nil;
}

- (Class)queryClassWithResultDictionary:(NSDictionary *)dict {
  return [BMTEntityBanner class];
}
@end
