/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBAbstractTable.h"
#import "DBAbstractTable+ForSubclassEyesOnly.h"
#import "DBRecordIO.h"
#import "FMDB/FMDB.h"

@interface DBAbstractTable ()
@property (nonatomic) FMDatabase* db;
@property (nonatomic) NSString* name;
@end

@implementation DBAbstractTable

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.db = db;
    self.name = name;
    return self;
}

- (Class) queryClassWithResultDictionary:(NSDictionary*)resultDictionary {
    assert(NO);
    DDLogError(@"subclass of DBAbstractTable Must Implement queryClassWithResultDictionary!");
    return nil;
}

- (BOOL)createTable
{
    NSError* error = [self createTableIfNeeded];
    if (error) {
        DDLogError(@"%@.createTableIfNeeded failed: %@", NSStringFromClass([self class]), error);
        assert(NO);
    }
    return error == nil;
}

- (BOOL)exists
{
    FMResultSet* result = [self.db executeQuery:[NSString stringWithFormat:@"SELECT count(rowid) FROM sqlite_master WHERE type='table' AND name='%@'", self.name]];
    if (result == nil) {
        DDLogError(@"%@.exist failed: %@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
    }
    [result next];
    if ([[result objectForColumnIndex:0] isEqual:@1]) {
      [result close];
      return YES;
    }
    [result close];
    return NO;
}

- (BOOL)addItem:(id)item
{
    return [self addItem:item allowReplace:NO allowIgnore:NO];
}

- (BOOL)addItemOrReplace:(id)item
{
    return [self addItem:item allowReplace:YES allowIgnore:NO];
}

- (BOOL)addItemOrIgnore:(id)item
{
    return [self addItem:item allowReplace:NO allowIgnore:YES];
}

- (BOOL)addItem:(id)item allowReplace:(BOOL)replace allowIgnore:(BOOL)ignore
{
    if (![item conformsToProtocol:@protocol(DBRecordIO)] && ![item respondsToSelector:@selector(encodeForDBRecord)]) {
        DDLogError(@"%@.addItem Failed: %@ doesn't comform to protocol DBRecordIO", NSStringFromClass([self class]), NSStringFromClass([item class]));
        assert(NO);
        return NO;
    }
    NSDictionary* parameter = [item encodeForDBRecord];
    NSArray* keys = [parameter allKeys];
    BOOL success = NO;
    if ([keys count] == 0) {
        if (![self allowAddEmptyItem]) {
            DDLogError(@"%@.addItem Failed: you shouldn't add empty item", NSStringFromClass([self class]));
            assert(NO);
            return NO;
        }
        NSString* sql = [NSString stringWithFormat:@"INSERT INTO %@ DEFAULT VALUES", self.name];
        success = [self.db executeUpdate:sql];
    } else {
        NSMutableArray* values = [NSMutableArray arrayWithCapacity:[keys count]];
        NSMutableArray* marks = [NSMutableArray arrayWithCapacity:[keys count]];
        for (NSString* key in keys) {
            [values addObject:[parameter objectForKey:key]];
            [marks addObject:@"?"];
        }
        NSString* sql = nil;
        if (ignore) {
            sql = [NSString stringWithFormat:@"INSERT OR IGNORE INTO %@ (%@) VALUES (%@)", self.name, [keys componentsJoinedByString:@", "], [marks componentsJoinedByString:@", "]];
        } else if (replace) {
            sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)", self.name, [keys componentsJoinedByString:@", "], [marks componentsJoinedByString:@", "]];
        } else {
            sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", self.name, [keys componentsJoinedByString:@", "], [marks componentsJoinedByString:@", "]];
        }
        success = [self.db executeUpdate:sql withArgumentsInArray:values];
    }
    return success;
}

- (NSArray*)selectItemsWithCol:(NSString*)col otherPart:(NSString *)otherPart withParam:(NSArray *)param
{
    if (!col) {
        return nil;
    }
    NSString* sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", col, self.name];
    if (otherPart != nil) {
        sql = [sql stringByAppendingFormat:@" %@", otherPart];
    }
    FMResultSet* queryResult = [self.db executeQuery:sql withArgumentsInArray:param];
    if (queryResult == nil) {
        DDLogError(@"%@.selectItems Failed:%@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return nil;
    }
    NSArray *array = [self colFromResultSet:queryResult];
    [queryResult close];
    return array;
}

- (NSArray*)selectItemsWithOtherPart:(NSString*)otherPart withParam:(NSArray*)param
{
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM %@", self.name];
    if (otherPart != nil) {
        sql = [sql stringByAppendingFormat:@" %@", otherPart];
    }
    FMResultSet* queryResult = [self.db executeQuery:sql withArgumentsInArray:param];
    if (queryResult == nil) {
        DDLogError(@"%@.selectItems Failed:%@", NSStringFromClass([self class]), [self.db lastError]);
        //assert(NO);
        return nil;
    }
    NSArray *array = [self itemsFromResultSet:queryResult];
    [queryResult close];
    return array;
}

- (BOOL)existsWithOtherPart:(NSString*)otherPart withParam:(NSArray*)param
{
    NSString* sql = [NSString stringWithFormat:@"SELECT 1 FROM %@", self.name];
    if (otherPart != nil) {
        sql = [sql stringByAppendingFormat:@" %@", otherPart];
    }
    sql = [sql stringByAppendingString:@" LIMIT 1"];
    FMResultSet* queryResult = [self.db executeQuery:sql withArgumentsInArray:param];
    if (queryResult == nil) {
        DDLogError(@"%@.existsItems Failed:%@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return NO;
    }
    BOOL isNext = [queryResult next];
    [queryResult close];
    return isNext;
}


- (BOOL)deleteItemsWithOtherPart:(NSString *)otherPart withParam:(NSArray *)param
{
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM %@", self.name];
    if (otherPart != nil) {
        sql = [sql stringByAppendingFormat:@" %@", otherPart];
    }
    BOOL success = [self.db executeUpdate:sql withArgumentsInArray:param];
    if (!success) {
        DDLogError(@"%@.deleteItemsWithOtherPart Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return NO;
    }
    return success;
}

- (BOOL)deleteAllItems
{
    return [self deleteItemsWithOtherPart:@"" withParam:nil];
}

- (BOOL)dropSelf
{
    NSString* sql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", self.name];
    BOOL success = [self.db executeUpdate:sql];
    if (!success) {
        DDLogError(@"%@.dropSelf Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
    }
    return success;
}

- (NSInteger)selectItemCount
{
    NSString* sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@", self.name];
    FMResultSet* queryResult = [self.db executeQuery:sql withArgumentsInArray:nil];
    if (queryResult == nil) {
        DDLogError(@"%@.selectItems Failed:%@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return 0;
    }
    [queryResult next];
    NSInteger count = [queryResult longForColumnIndex:0];
    [queryResult close];
    return count;
}

- (BOOL)alterTableAddColumn:(NSString *)column withType:(NSString *)type {
  NSString *sql = [NSString stringWithFormat:@"alter table %@ add %@ %@",
                   self.name, column, type];
  return [self.db executeUpdate:sql];
}

- (BOOL)hasColumn:(NSString *)column {
  NSString *sql = [NSString stringWithFormat:@"select %@ from %@ limit 1",
                   column, self.name];
  FMResultSet *queryResult = [self.db executeQuery:sql];
  BOOL hasColumn = NO;
  if (queryResult != nil) {
    hasColumn = YES;
  }
  [queryResult close];
  return hasColumn;
}

- (BOOL)checkAndAddColumn:(NSString *)column withType:(NSString *)type {
  if (![self hasColumn:column]) {
    return [self alterTableAddColumn:column withType:type];
  }
  return YES;
}

- (BOOL)upgrade {
  return YES;
}

@end
