/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBKeyValueTable.h"
#import "DBKeyValueRecord.h"
#import "DBKeyValueIO.h"
#import "NSDictionary+ForStorageField.h"
#import "DBKeyValueTable+ForSubclassEyesOnly.h"
#import "DBKey2DBValue.h"
#import "FMDatabase+Extension.h"
#import "BMTStorageConstant.h"
#import "NSError+BMTExtension.h"

#define DBKEYVALUETABLE_KEY @"DBkey"
#define DBKEYVALUETABLE_VALUE @"DBvalue"

@implementation DBKeyValueRecord
+ (instancetype) recordWithKey:(NSString*)key value:(NSString*)value
{
    DBKeyValueRecord* record = [[DBKeyValueRecord alloc] init];
    if (record) {
        record.DBkey = key;
        record.DBvalue = value;
    }
    return record;
}

- (id)initWithDBRecord:(NSDictionary*)content
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self.DBkey = [content stringValueForDBFieldName:DBKEYVALUETABLE_KEY];
    self.DBvalue = [content stringValueForDBFieldName:DBKEYVALUETABLE_VALUE];
    return self;
}

- (NSDictionary*)encodeForDBRecord
{
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    [result setValue:self.DBkey forKey:DBKEYVALUETABLE_KEY];
    [result setValue:self.DBvalue forKey:DBKEYVALUETABLE_VALUE];
    return result;
}
@end

@interface DBKeyValueTable ()
@property (nonatomic) Class wholeClass;
@end


@implementation DBKeyValueTable

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db withWholeClass:(Class)wholeClass
{
    self = [super initWithTableName:name inDatabase:db withKeyName:DBKEYVALUETABLE_KEY];
    if (self) {
        self.wholeClass = wholeClass;
    }
    return self;
}

- (Class)queryClassWithResultDictionary:(NSDictionary *)resultDictionary {
    return [DBKeyValueRecord class];
}

- (NSError*)createTableIfNeeded
{
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@("
                     DBKEYVALUETABLE_KEY @" TEXT PRIMARY KEY NOT NULL,"
                     DBKEYVALUETABLE_VALUE @" TEXT)", self.name];
    BOOL success = [self.db executeUpdate:sql];
    return success ? nil : [self.db lastError];
}

- (id)getWhole
{
    NSArray* allKeyAndValues = [self selectItemsWithOtherPart:nil withParam:nil];
    if (allKeyAndValues == nil) {
        DDLogError(@"%@.getWhole Failed: %@", NSStringFromClass([self class]), [self.db lastError]);
        assert(NO);
        return nil;
    }

    id result = [self.wholeClass alloc];
    NSCAssert([result conformsToProtocol:@protocol(DBKeyValueIO)], @"You must implement DBKeyValueIO protocol");
    if ([result respondsToSelector:@selector(initWithDBKey2DBValue:)]) {
        return [result initWithDBKey2DBValue:[[DBKey2DBValue alloc] initWithDBKeyAndValueArray:allKeyAndValues]];
    }
    if ([result respondsToSelector:@selector(initWithDBKeyValues:)]) {
        return [result initWithDBKeyValues:allKeyAndValues];
    }
    NSCAssert(NO, @"%@.getWhole failed: you must implement -(id)initWithDBKey2DBValue: or -(id)initWithDBKeyValues:", [self class]);
    return nil;

}

- (BOOL)updateWhole:(id)whole
{
    NSCAssert([whole conformsToProtocol:@protocol(DBKeyValueIO)], @"You must implement DBKeyValueIO protocol");
    NSError* error = [self.db inAutoRollbackSavePoint:^NSError *{
        NSArray* keyAndValues = nil;
        if ([whole respondsToSelector:@selector(encodeForDBKey2DBValue)]) {
            keyAndValues = [[whole encodeForDBKey2DBValue] toDBKeyAndValueArray];
        } else if ([whole respondsToSelector:@selector(encodeForDBKeyValues)]) {
            keyAndValues = [whole encodeForDBKeyValues];
        } else {
            return [NSError errorWithDomain:kStorageErrorDomain code:kShouldNotOccur description:@"You must implement -(NSArray*)encodeForDBKeyValues or -(DBKey2DBValue)encodeForDBKey2DBValue:", NSStringFromClass([self class])];
        }
        for (DBKeyValueRecord* keyAndValue in keyAndValues) {
            BOOL success = [self addItemOrReplace:keyAndValue];
            if (!success) {
                return [self.db lastError];
            }
        }
        return nil;
    }];
    if (error != nil) {
        DDLogError(@"%@.updateWhole Failed: %@", NSStringFromClass([self class]), error);
    }
    return error == nil;
}

- (BOOL)deleteWhole
{
    return [super deleteAllItems];
}

- (BOOL)removeKeys:(NSArray*)keys
{
    return [super deleteItemsByKeys:keys];
}

@end

@implementation DBKeyValueTable (ForSubclassEyesOnly)

- (NSString*)dbKeyName;
{
    return DBKEYVALUETABLE_KEY;
}

- (NSString*)dbKeyValue
{
    return DBKEYVALUETABLE_VALUE;
}
@end
