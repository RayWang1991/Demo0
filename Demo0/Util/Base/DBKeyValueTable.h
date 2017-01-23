/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithUniquePrimaryKey.h"

@interface DBKeyValueTable : DBTableWithUniquePrimaryKey

@property (nonatomic, readonly) Class wholeClass;

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db withWholeClass:(Class)wholeClass;

- (id)getWhole;

- (BOOL)updateWhole:(id)whole;

- (BOOL)deleteWhole;

- (BOOL)removeKeys:(NSArray*)keys;

@end
