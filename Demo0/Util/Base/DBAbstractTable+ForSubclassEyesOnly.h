/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBAbstractTable.h"
#import "FMDB/FMDB.h"
@interface DBAbstractTable (ForSubclassEyesOnly)

- (NSError*)createTableIfNeeded;

- (BOOL)allowAddEmptyItem;

- (NSArray*)itemsFromResultSet:(FMResultSet*)set;

- (NSArray*)colFromResultSet:(FMResultSet*)set;
@end
