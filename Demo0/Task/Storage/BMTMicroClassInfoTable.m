/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassInfoTable.m 
 * Created by ray wang on 16/12/28.
 */

#import "BMTMicroClassInfoTable.h"
#import "NSDictionary+ForStorageField.h"

#define MICROCLASSINFO_COLUMN_AVATARADDRESS @"avatarAddress"
#define MICROCLASSINFO_COLUMN_TITLE @"title"
#define MICROCLASSINFO_COLUMN_APPLICANTS @"applicants"
#define MICROCLASSINFO_COLUMN_STARTTIMESTAMP @"startTimestamp"
#define MICROCLASSINFO_COLUMN_INFOID @"infoId"

#define BMT_TABLENAME_MICROCLASSINFO @"microClassInfo"

@implementation BMTMicroClassInfoEntity {

}
- (instancetype)initWithDBRecord:(NSDictionary *)content {
  self = [super init];
  if (!self) {
    return nil;
  }

  self.infoId =
      [content numberValueForDBFieldName:MICROCLASSINFO_COLUMN_INFOID];
  self.startTimestamp =
      [content numberValueForDBFieldName:MICROCLASSINFO_COLUMN_STARTTIMESTAMP];
  self.title =
      [content stringValueForDBFieldName:MICROCLASSINFO_COLUMN_TITLE];
  self.applicants =
      [content numberValueForDBFieldName:MICROCLASSINFO_COLUMN_APPLICANTS];
  self.avatarAddress =
      [content stringValueForDBFieldName:MICROCLASSINFO_COLUMN_AVATARADDRESS];
  return self;
}
- (NSDictionary *)encodeForDBRecord {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  [dict setValue:self.avatarAddress
          forKey:MICROCLASSINFO_COLUMN_AVATARADDRESS];
  [dict setValue:self.title
          forKey:MICROCLASSINFO_COLUMN_TITLE];
  [dict setValue:self.applicants
          forKey:MICROCLASSINFO_COLUMN_APPLICANTS];
  [dict setValue:self.startTimestamp
          forKey:MICROCLASSINFO_COLUMN_STARTTIMESTAMP];
  [dict setValue:self.infoId
          forKey:MICROCLASSINFO_COLUMN_INFOID];
  return dict;
}

@end

@implementation BMTMicroClassInfoTable

#pragma mark - override

- (NSError *)createTableIfNeeded {
  NSString *sql = @"CREATE TABLE IF NOT EXISTS "
      BMT_TABLENAME_MICROCLASSINFO @"("
      MICROCLASSINFO_COLUMN_INFOID
      @"INTEGER PRIMARY KEY NOT NULL,"
      MICROCLASSINFO_COLUMN_AVATARADDRESS
      @" TEXT, "
      MICROCLASSINFO_COLUMN_TITLE
      @" INTEGER,"
      MICROCLASSINFO_COLUMN_APPLICANTS
      @" INTEGER,"
      MICROCLASSINFO_COLUMN_STARTTIMESTAMP
      @" INTEGER)";

  BOOL success = [self.db executeUpdate:sql];

  if (!success) {
    return [self.db lastError];
  }
  return nil;
}

- (Class)queryClassWithResultDictionary:(NSDictionary *)dict {
  return [BMTMicroClassInfoEntity class];
}
- (BOOL)addMicroClassInfo:(BMTMicroClassInfoEntity *)info {
  return [self addItemOrIgnore:info];
}
- (BMTMicroClassInfoEntity *)getLatestMicroClassInfo {

  BMTMicroClassInfoEntity *entity = [self selectItemsWithOtherPart:@"order by "
                                     "startTimestamp LIMIT 0 , 1"
                                                         withParam:nil][0];
  return entity;
}

@end