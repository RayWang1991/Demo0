/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "FMDB/FMDatabase.h"
#import "FMDB/FMDatabaseQueue.h"

@interface FMDatabase (Extension)

- (NSError*)inAutoRollbackSavePoint:(NSError* (^)())block;

@end

@interface FMDatabaseQueue (Extension)

- (NSError*)inAutoRollbackSavePoint:(NSError* (^)(FMDatabase* db))block;

@end
