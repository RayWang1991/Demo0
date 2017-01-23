/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithCouplePrimaryKey.h"
#import "DBRecordIO.h"

@implementation CoupleKey

+ (CoupleKey *)keyCoupleWithKey1:(id)key1 key2:(id)key2
{
    CoupleKey* key = [[CoupleKey alloc] init];
    key.key1 = key1;
    key.key2 = key2;
    return key;
}

@end

@interface DBTableWithCouplePrimaryKey ()

@property (nonatomic) NSString* keyName1;
@property (nonatomic) NSString* keyName2;

@end

@implementation DBTableWithCouplePrimaryKey

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase *)db withKeyName1:(NSString *)keyName1 withKeyName2:(NSString *)keyName2
{
    self = [super initWithTableName:name inDatabase:db];
    if (self) {
        self.keyName1 = keyName1;
        self.keyName2 = keyName2;
    }
    return self;
}

- (NSArray *)selectItemByKey1:(id)key1
{
    if (key1 == nil) {
        return nil;
    }
    NSString* wherePart = [NSString stringWithFormat:@"WHERE %@ = ?", self.keyName1];
    return [self selectItemsWithOtherPart:wherePart withParam:@[key1]];
}

- (NSArray *)selectItemByKey2:(id)key2
{
    if (key2 == nil) {
        return nil;
    }
    NSString* wherePart = [NSString stringWithFormat:@"WHERE %@ = ?", self.keyName2];
    return [self selectItemsWithOtherPart:wherePart withParam:@[key2]];
}

- (id)selectItemByKey:(CoupleKey *)key
{
    NSArray* results = [self selectItemsByKeys:[NSArray arrayWithObject:key]];
    assert([results count] <= 1);
    if ([results count] == 0) {
        return nil;
    }
    return [results objectAtIndex:0];
}

- (NSArray *)selectItemsByKeys:(NSArray *)keys
{
    if (keys.count == 0) {
        return nil;
    }
    NSMutableString* wherePart = [NSMutableString stringWithString:@"WHERE "];
    NSMutableArray* conditionParts = [NSMutableArray array];
    NSMutableArray* parameters = [NSMutableArray array];
    for (CoupleKey* key in keys) {
        NSString* part = [NSString stringWithFormat:@"(%@ = ? AND %@ = ?)", self.keyName1, self.keyName2];
        [conditionParts addObject:part];
        [parameters addObject:key.key1];
        [parameters addObject:key.key2];
    }
    [wherePart appendString:[conditionParts componentsJoinedByString:@" OR "]];
    return [self selectItemsWithOtherPart:wherePart withParam:parameters];
}

- (BOOL)updateItem:(id)item key:(CoupleKey *)key
{
    if (key == nil || key.key1 == nil || key.key2 == nil) {
        DDLogError(@"you should update a %@ with %@,%@", NSStringFromClass([item class]), self.keyName1, self.keyName2);
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
                     @"UPDATE %@ SET %@ WHERE %@ = ? AND %@ = ?",
                     self.name,
                     [parameterKeyStrings componentsJoinedByString:@","],
                     self.keyName1, self.keyName2];
    [parameterValueStrings addObject:key.key1];
    [parameterValueStrings addObject:key.key2];
    BOOL success = [self.db executeUpdate:sql withArgumentsInArray:parameterValueStrings];
    if (!success) {
        DDLogError(@"%@.updateItemBykey Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
    }
    return success;
}

- (BOOL)deleteItemByKey:(CoupleKey *)key
{
    return [self deleteItemsByKeys:@[key]];
}

- (BOOL)deleteItemsByKeys:(NSArray *)keys
{
    if ([keys count] == 0) {
        return YES;     // since there is no data need to delete, we can consider it as 'success'
    }
    NSMutableString* wherePart = [NSMutableString stringWithString:@"WHERE "];
    NSMutableArray* conditionParts = [NSMutableArray array];
    NSMutableArray* parameters = [NSMutableArray array];
    for (CoupleKey* key in keys) {
        NSString* part = [NSString stringWithFormat:@"(%@ = ? AND %@ = ?)", self.keyName1, self.keyName2];
        [conditionParts addObject:part];
        [parameters addObject:key.key1];
        [parameters addObject:key.key2];
    }
    [wherePart appendString:[conditionParts componentsJoinedByString:@" OR "]];
    return [self deleteItemsWithOtherPart:wherePart withParam:parameters];
}

@end
