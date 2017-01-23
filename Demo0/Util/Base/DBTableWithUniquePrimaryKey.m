/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithUniquePrimaryKey.h"
#import "DBAbstractTable+ForSubclassEyesOnly.h"
#import "DBRecordIO.h"

@interface DBTableWithUniquePrimaryKey ()
@property (nonatomic) NSString* keyName;
@end

@implementation DBTableWithUniquePrimaryKey

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db withKeyName:(NSString*)keyName
{
    self = [super initWithTableName:name inDatabase:db];
    if (self) {
        self.keyName = keyName;
    }
    return self;
}

- (id)selectItemByKey:(id)keyValue
{
    NSArray* results = [self selectItemsByKeys:[NSArray arrayWithObject:keyValue]];
    assert([results count] <= 1);
    if ([results count] == 0) {
        return nil;
    }
    return [results objectAtIndex:0];
}

- (NSArray*)selectItemsByKeys:(NSArray*)keyValues
{
    if ([keyValues count] == 0) {
        return nil;
    }
    NSMutableArray* marks = [NSMutableArray arrayWithCapacity:[keyValues count]];
    for (id __unused key in keyValues) {
        [marks addObject:@"?"];
    }
    NSString* wherePart = [NSString stringWithFormat:@"WHERE %@ IN (%@)", self.keyName, [marks componentsJoinedByString:@", "]];
    return [self selectItemsWithOtherPart:wherePart withParam:keyValues];
}

- (NSArray*)selectKeysWithOtherPart:(NSString*)otherPart withParam:(NSArray*)param
{
    NSString* sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", self.keyName, self.name];
    if (otherPart != nil) {
        sql = [sql stringByAppendingFormat:@" %@", otherPart];
    }
    FMResultSet* queryResult = [self.db executeQuery:sql withArgumentsInArray:param];
    if (queryResult == nil) {
        DDLogError(@"%@.selectKeys Failed:%@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return nil;
    }

    NSMutableArray* result = [NSMutableArray array];
    while ([queryResult next]) {
        id key = [queryResult objectAtIndexedSubscript:0];
        [result addObject:key];
    }
    [queryResult close];
    return result;
}

- (BOOL)updateItem:(id)item key:(id)key
{
    if (key == nil || key == [NSNull null]) {
        DDLogError(@"you should update a %@ with %@", NSStringFromClass([item class]), self.keyName);
        assert(false);
        return NO;
    }

    if (![item conformsToProtocol:@protocol(DBRecordIO)] && ![item respondsToSelector:@selector(encodeForDBRecord)]) {
        DDLogError(@"%@.updateItem Failed: %@ doesn't comform to protocol DBRecordIO", NSStringFromClass([self class]), NSStringFromClass([item class]));
        assert(NO);
        return NO;
    }

    NSDictionary* parameter = [item encodeForDBRecord];
    if ([parameter count] <= 1) {       // 1 means only primary key
        return YES;     // success since no field need to updated
    }
    NSMutableArray* parameterKeyStrings = [NSMutableArray array];
    NSMutableArray* parameterValueStrings = [NSMutableArray array];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [parameterKeyStrings addObject:[NSString stringWithFormat:@"%@=?", key]];
        [parameterValueStrings addObject:obj];
    }];
    NSString* sql = [NSString stringWithFormat:
                     @"UPDATE %@ SET %@ WHERE %@ = ?",
                     self.name,
                     [parameterKeyStrings componentsJoinedByString:@","],
                     self.keyName];
    [parameterValueStrings addObject:key];
    BOOL success = [self.db executeUpdate:sql withArgumentsInArray:parameterValueStrings];
    if (!success) {
        DDLogError(@"%@.updateItemBykey Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
    }
    return success;
}

- (BOOL)updateItem:(id)item
{
    id keyValue = [item valueForKey:self.keyName];
    if (keyValue == nil || keyValue == [NSNull null]) {
        DDLogError(@"you should update a %@ with %@", NSStringFromClass([item class]), self.keyName);
        assert(false);
        return NO;
    }
    if (![item conformsToProtocol:@protocol(DBRecordIO)] && ![item respondsToSelector:@selector(encodeForDBRecord)]) {
        DDLogError(@"%@.updateItem Failed: %@ doesn't comform to protocol DBRecordIO", NSStringFromClass([self class]), NSStringFromClass([item class]));
        assert(NO);
        return NO;
    }

    NSDictionary* parameter = [item encodeForDBRecord];
    if ([parameter count] <= 1) {       // 1 means only primary key
        return YES;     // success since no field need to updated
    }
    NSMutableArray* parameterKeyStrings = [NSMutableArray array];
    NSMutableArray* parameterValueStrings = [NSMutableArray array];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![key isEqualToString:self.keyName]) {
            [parameterKeyStrings addObject:[NSString stringWithFormat:@"%@=?", key]];
            [parameterValueStrings addObject:obj];
        }
    }];
    NSString* sql = [NSString stringWithFormat:
                     @"UPDATE %@ SET %@ WHERE %@ = ?",
                     self.name,
                     [parameterKeyStrings componentsJoinedByString:@","],
                     self.keyName];
    [parameterValueStrings addObject:keyValue];
    BOOL success = [self.db executeUpdate:sql withArgumentsInArray:parameterValueStrings];
    if (!success) {
        DDLogError(@"%@.updateItem Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
    }
    return success;
}

- (BOOL)deleteItemByKey:(id)keyValue
{
    return [self deleteItemsByKeys:@[keyValue]];
}

- (BOOL)deleteItemsByKeys:(NSArray*)keyValues
{
    if ([keyValues count] == 0) {
        return YES;     // since there is no data need to delete, we can consider it as 'success'
    }
    NSMutableArray* marks = [NSMutableArray arrayWithCapacity:[keyValues count]];
    for (id __unused value in keyValues) {
        [marks addObject:@"?"];
    }
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ IN (%@)", self.name, self.keyName, [marks componentsJoinedByString:@", "]];
    BOOL success = [self.db executeUpdate:sql withArgumentsInArray:keyValues];
    if (!success) {
        DDLogError(@"%@.deleteItemsByKeys Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return NO;
    }
    return success;
}
@end
