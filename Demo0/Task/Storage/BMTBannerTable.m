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

/*
@property(strong, nonatomic) NSString *altText;
@property(assign, nonatomic) NSInteger height;
@property(assign, nonatomic) NSInteger width;
@property(strong, nonatomic) NSString *href;
@property(strong, nonatomic) NSString *imgSrc;
@property(assign, nonatomic) LanguageType language;

@property (assign, nonatomic) StatusType status;
@property (assign, nonatomic) PosterType type;
*/

#define BANNER_COLUMN_ID @"bannerId"
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


  self.bannerId=[content numberValueForDBFieldName:BANNER_COLUMN_ID];

  self.altText=[content stringValueForDBFieldName:BANNER_COLUMN_ALTTEXT];
  self.imgSrc=[content stringValueForDBFieldName:BANNER_COLUMN_IMGSRC];
  self.height=[content numberValueForDBFieldName:BANNER_COLUMN_HEIGHT];
  self.href=[content stringValueForDBFieldName:BANNER_COLUMN_HREF];
  self.width=[content numberValueForDBFieldName:BANNER_COLUMN_WIDTH];

  self.language=[content numberValueForDBFieldName:BANNER_COLUMN_LANGUAGE];

  self.type=[content numberValueForDBFieldName:BANNER_COLUMN_TYPE];
  self.status=[content numberValueForDBFieldName:BANNER_COLUMN_STATUS];

  return self;
}

- (NSDictionary *)encodeForDBRecord {

  NSMutableDictionary *result = [NSMutableDictionary dictionary];

  [result setValue:self.bannerId forKey:BANNER_COLUMN_ID];
  [result setValue:self.altText forKey:BANNER_COLUMN_ALTTEXT];
  [result setValue:self.imgSrc forKey:BANNER_COLUMN_IMGSRC];
  [result setValue:self.type forKey:BANNER_COLUMN_TYPE];
  [result setValue:self.status forKey:BANNER_COLUMN_STATUS];
  [result setValue:self.language forKey:BANNER_COLUMN_LANGUAGE];
  [result setValue:self.height forKey:BANNER_COLUMN_HEIGHT];
  [result setValue:self.width forKey:BANNER_COLUMN_WIDTH];
  [result setValue:self.href forKey:BANNER_COLUMN_HREF];

  return result;
}



/*
- (instancetype)initWithDBKey2DBValue:(DBKey2DBValue*)key2Value {
  self = [super init];
  if (!self) {
    return nil;
  }
  self.altText=[key2Value stringValueForKey:BANNER_COLUMN_ALTTEXT];
  self.imgSrc=[key2Value stringValueForKey:BANNER_COLUMN_IMGSRC];
  self.height=[key2Value integerValueForKey:BANNER_COLUMN_HEIGHT];
  self.href=[key2Value stringValueForKey:BANNER_COLUMN_HREF];
  self.width=[key2Value integerValueForKey:BANNER_COLUMN_WIDTH];

  self.language=[key2Value integerValueForKey:BANNER_COLUMN_LANGUAGE];

  self.type=[key2Value stringValueForKey:BANNER_COLUMN_TYPE];
  self.status=[key2Value integerValueForKey:BANNER_COLUMN_STATUS];

  return self;
}


- (DBKey2DBValue *)encodeForDBKey2DBValue {
DBKey2DBValue *result=[[DBKey2DBValue alloc]init];
  [result setNumberValue:self.status
                  forKey:BANNER_COLUMN_STATUS];
  [result setNumberValue:self.width
                  forKey:BANNER_COLUMN_WIDTH];
  [result setNumberValue:self.height
                  forKey:BANNER_COLUMN_HEIGHT];
  [result setNumberValue:self.type
                  forKey:BANNER_COLUMN_TYPE];
  [result setNumberValue:self.language
                  forKey:BANNER_COLUMN_LANGUAGE];
  [result setStringValue:self.imgSrc
                  forKey:BANNER_COLUMN_IMGSRC];
  [result setStringValue:self.href
                  forKey:BANNER_COLUMN_HREF];
  [result setStringValue:self.altText
                  forKey:BANNER_COLUMN_ALTTEXT];

  return result;
}
*/

- (instancetype)initWithResource:(BMTResourceBanner*)resource{
  self = [super init];
  if (!self) {
    return nil;
  }
  self.altText=resource.altText;
  self.status=resource.status;
  self.href=resource.href;
  self.imgSrc=resource.imgSrc;
  self.language=resource.language;
  self.width=resource.width;
  self.height=resource.height;

  return self;
}

-(BOOL) updateBanner:(BMTEntityBanner *)banner{

}


@end

@implementation BMTBannerTable {

}
- (instancetype)initWithDatabase:(FMDatabase*)db {
  return [self initWithTableName:BMT_TABLENAME_BANNER
                      inDatabase:db
                  withKeyName: BANNER_COLUMN_ID];
}

- (NSArray*)getBannersOrderedById:(NSUInteger)num  {
  NSString *otherPart =[NSString stringWithFormat:@"order by %@ desc",
          BANNER_COLUMN_ID];
  return [self selectItemsWithOtherPart:otherPart
                              withParam:nil];
}

#pragma mark - override

- (NSError *)createTableIfNeeded {
  NSString *sql = @"CREATE TABLE IF NOT EXISTS " BMT_TABLENAME_BANNER @"("
  BANNER_COLUMN_ID @" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
  BANNER_COLUMN_STATUS @" INTEGER,"
  BANNER_COLUMN_TYPE @" INTEGER,"
  BANNER_COLUMN_IMGSRC @" TEXT,"
  BANNER_COLUMN_HREF @" TEXT,"
  BANNER_COLUMN_ALTTEXT @"TEXT,"
  BANNER_COLUMN_LANGUAGE @" INTEGER,"
  BANNER_COLUMN_HEIGHT @" INTEGER,"
  BANNER_COLUMN_WIDTH @" INTEGER)";

  BOOL success = [self.db executeUpdate:sql];

  if (!success) {
    return [self.db lastError];
  }
  return nil;
}

- (BOOL)upgrade {
  BOOL success = YES;
  success = success && [self checkAndAddColumn: BANNER_COLUMN_IMGSRC
                                      withType:@"TEXT"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_TYPE
                                      withType:@"INTEGER"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_ALTTEXT
                                      withType:@"TEXT"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_HREF
                                      withType:@"TEXT"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_STATUS
                                      withType:@"INTEGER"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_WIDTH
                                      withType:@"INTEGER"];
  success = success && [self checkAndAddColumn: BANNER_COLUMN_HEIGHT
                                      withType:@"INTEGER"];
  return success;
}

@end