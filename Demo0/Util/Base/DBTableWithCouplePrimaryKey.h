/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBAbstractTable.h"

@interface CoupleKey : NSObject

@property (nonatomic) id key1;
@property (nonatomic) id key2;

+ (CoupleKey *)keyCoupleWithKey1:(id)key1 key2:(id)key2;

@end

@interface DBTableWithCouplePrimaryKey : DBAbstractTable

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase *)db withKeyName1:(NSString *)keyName1 withKeyName2:(NSString *)keyName2;

- (NSArray*)selectItemByKey1:(id)key1;
- (NSArray*)selectItemByKey2:(id)key2;
- (id)selectItemByKey:(CoupleKey *)key;
- (NSArray*)selectItemsByKeys:(NSArray *)keys;

- (BOOL)updateItem:(id)item key:(CoupleKey *)key;

- (BOOL)deleteItemByKey:(CoupleKey *)key;
- (BOOL)deleteItemsByKeys:(NSArray *)keys;

@end
