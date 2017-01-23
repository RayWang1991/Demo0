/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBAbstractTable.h"

@interface DBTableWithUniquePrimaryKey : DBAbstractTable

@property (nonatomic, readonly) NSString* keyName;

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db withKeyName:(NSString*)keyName;

- (NSArray*)selectKeysWithOtherPart:(NSString*)otherPart withParam:(NSArray*)param;

- (id)selectItemByKey:(id)keyValue;

- (NSArray*)selectItemsByKeys:(NSArray*)keyValues;

- (BOOL)updateItem:(id)item;

- (BOOL)updateItem:(id)item key:(id)key;

- (BOOL)deleteItemByKey:(id)keyValue;

- (BOOL)deleteItemsByKeys:(NSArray*)keyValues;

@end
