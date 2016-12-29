/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeInfoTable.m 
 * Created by ray wang on 16/12/22.
 */

#import "BMTKnowledgeInfoTable.h"
#import "NSDictionary+ForStorageField.h"

#define KNOWLEDGEINFO_COLUMN_INFOID @"infoId"
#define KNOWLEDGEINFO_COLUMN_TIMESTAMP @"timestamp"
#define KNOWLEDGEINFO_COLUMN_CATEGOTYID @"categotyId"
#define KNOWLEDGEINFO_COLUMN_LIKE @"like"
#define KNOWLEDGEINFO_COLUMN_CLICK @"click"
#define KNOWLEDGEINFO_COLUMN_TITLE @"title"
#define KNOWLEDGEINFO_COLUMN_SUMMARY @"summary"
#define KNOWLEDGEINFO_COLUMN_THUMBSRC @"thumbSrc"
#define KNOWLEDGEINFO_COLUMN_STATUS @"status"
#define KNOWLEDGEINFO_COLUMN_CONTENTSRC @"contentSrc"
#define KNOWLEDGEINFO_COLUMN_LANGUAGE @"language"
#define KNOWLEDGEINFO_COLUMN_CONTENT @"content"

#define BMT_TABLENAME_KNOWLEDGEINFO_CAT @"knowledgeInfo_cat"

@implementation BMTEntityKnowledgeInfo

- (instancetype)initWithDBRecord:(NSDictionary *)content {
  self = [super init];
  if (!self) {
    return nil;
  }

  self.infoId =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_INFOID];
  self.timestamp =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_TIMESTAMP];
  self.categoryId =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_CATEGOTYID];
  self.like =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_LIKE];
  self.click =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_CLICK];
  self.title =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_TITLE];
  self.summary =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_SUMMARY];
  self.thumbSrc =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_THUMBSRC];
  self.status =
      [content numberValueForDBFieldName:KNOWLEDGEINFO_COLUMN_STATUS];
  self.contentSrc =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_CONTENTSRC];
  self.language =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_LANGUAGE];
  self.content =
      [content stringValueForDBFieldName:KNOWLEDGEINFO_COLUMN_CONTENT];

  return self;
}

- (NSDictionary *)encodeForDBRecord {

  NSMutableDictionary *result = [NSMutableDictionary dictionary];

  [result setValue:self.infoId
            forKey:KNOWLEDGEINFO_COLUMN_INFOID];
  [result setValue:self.timestamp
            forKey:KNOWLEDGEINFO_COLUMN_TIMESTAMP];
  [result setValue:self.categoryId
            forKey:KNOWLEDGEINFO_COLUMN_CATEGOTYID];
  [result setValue:self.like
            forKey:KNOWLEDGEINFO_COLUMN_LIKE];
  [result setValue:self.click
            forKey:KNOWLEDGEINFO_COLUMN_CLICK];
  [result setValue:self.title
            forKey:KNOWLEDGEINFO_COLUMN_TITLE];
  [result setValue:self.summary
            forKey:KNOWLEDGEINFO_COLUMN_SUMMARY];
  [result setValue:self.thumbSrc
            forKey:KNOWLEDGEINFO_COLUMN_THUMBSRC];
  [result setValue:self.status
            forKey:KNOWLEDGEINFO_COLUMN_STATUS];
  [result setValue:self.contentSrc
            forKey:KNOWLEDGEINFO_COLUMN_CONTENTSRC];
  [result setValue:self.language
            forKey:KNOWLEDGEINFO_COLUMN_LANGUAGE];
  [result setValue:self.content
            forKey:KNOWLEDGEINFO_COLUMN_CONTENT];

  return result;
}


#pragma mark -override

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]
            initWithJSONToModelBlock:^(NSString *JsonkeyName) {
                if ([JsonkeyName isEqualToString:@"id"] || [JsonkeyName
                                                            isEqualToString:@"ID"]) {
                    return @"infoId";
                } else if ([JsonkeyName isEqualToString:@"categoty"]) {
                    return @"categoryId";
                } else {
                    return JsonkeyName;
                }
            }
            modelToJSONBlock:^(NSString *propertyName) {
                if ([propertyName isEqualToString:@"infoId"]) {
                    return @"id";
                } else if ([propertyName isEqualToString:@"categoryId"]) {
                    return @"category";
                } else {
                    return propertyName;
                }
            }
            ];
}
@end

@implementation BMTKnowledgeInfoTable {

}

- (instancetype)initWithDatabase:(FMDatabase *)db
                      categoryId:(NSUInteger)catId {
  NSString *tableName = [BMT_TABLENAME_KNOWLEDGEINFO_CAT
      stringByAppendingFormat:@"%ld",
                              catId];
  self = [super initWithTableName:tableName
                       inDatabase:db
                      withKeyName:KNOWLEDGEINFO_COLUMN_INFOID];
  if (self) {
    self.catId =(CATEGORY_ID)((catId-1)%4+1);
  }
  return self;
}
- (BOOL)addKnowledgeInfo:(BMTEntityKnowledgeInfo *)info {
  return [self addItemOrReplace:info];
}
- (BOOL)addKnowledgeInfoArray:(NSArray *)infoArray {
  BOOL success = YES;
  for (BMTEntityKnowledgeInfo *info in infoArray) {
    success = success && [self addKnowledgeInfo:info];
  }
  return success;
}
- (BOOL)deleteAllKnowledgeInfo {
  return [self deleteAllItems];// clear current category table
}
- (NSUInteger)itemsCount {
  return [self selectItemCount];
}
- (NSArray<BMTEntityKnowledgeInfo *> *)getKnowledgeInfosOrderedByName:(NSUInteger)num {
  // if number of items in table < num, return all
  NSArray *resArray =
      [self selectItemsWithOtherPart:[NSString stringWithFormat:@"order by "
                                                                    "timestamp LIMIT 0, %d",
                                                                num]
                           withParam:nil];
  return resArray;
}

- (NSArray<BMTEntityKnowledgeInfo *> *)getKnowledgeInfosOrderedByName:(NSUInteger)num
                                                               offset:(NSUInteger)offset {
  NSArray *resArray =
      [self selectItemsWithOtherPart:[NSString stringWithFormat:@"order by "
                                                                    "timestamp LIMIT  %d, %d",
                                                                offset,
                                                                num]
                           withParam:nil];
  return resArray;
}

#pragma mark - override


- (NSError *)createTableIfNeeded {
  NSString *sql = [@"CREATE TABLE IF NOT EXISTS "
      BMT_TABLENAME_KNOWLEDGEINFO_CAT
      stringByAppendingFormat:@"%d( "
                                  KNOWLEDGEINFO_COLUMN_INFOID
                                  @" INTEGER PRIMARY KEY NOT NULL,"
                                  KNOWLEDGEINFO_COLUMN_TIMESTAMP
                                  @" INTEGER,"
                                  KNOWLEDGEINFO_COLUMN_CATEGOTYID
                                  @" INTEGER,"
                                  KNOWLEDGEINFO_COLUMN_LIKE
                                  @" INTEGER,"
                                  KNOWLEDGEINFO_COLUMN_CLICK
                                  @" INTEGER,"
                                  KNOWLEDGEINFO_COLUMN_TITLE
                                  @" TEXT,"
                                  KNOWLEDGEINFO_COLUMN_SUMMARY
                                  @" TEXT,"
                                  KNOWLEDGEINFO_COLUMN_THUMBSRC
                                  @" TEXT,"
                                  KNOWLEDGEINFO_COLUMN_STATUS
                                  @" INTEGER,"
                                  KNOWLEDGEINFO_COLUMN_CONTENTSRC
                                  @" TEXT,"
                                  KNOWLEDGEINFO_COLUMN_LANGUAGE
                                  @" TEXT,"
                                  KNOWLEDGEINFO_COLUMN_CONTENT
                                  @" TEXT)"
      ,
                              self.catId];

  BOOL success = [self.db executeUpdate:sql];

  if (!success) {
    return [self.db lastError];
  }
  return nil;
}

- (Class)queryClassWithResultDictionary:(NSDictionary *)dict {
  return [BMTEntityKnowledgeInfo class];
}

@end
