/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "FMDatabase+Extension.h"

@implementation FMDatabase (Extension)

- (NSError*)inAutoRollbackSavePoint:(NSError* (^)())block
{
    __block NSError* internalError = nil;
    NSError* error = [self inSavePoint:^(BOOL* rollback) {
        internalError = block();
        if (internalError != nil) {
            *rollback = YES;
        }
    }];

    return internalError != nil ? internalError : error;
}

@end


@implementation FMDatabaseQueue (Extension)

- (NSError*)inAutoRollbackSavePoint:(NSError* (^)(FMDatabase* db))block
{
    __block NSError* internalError = nil;
    NSError* error = [self inSavePoint:^(FMDatabase *db, BOOL* rollback) {
        internalError = block(db);
        if (internalError != nil) {
            *rollback = YES;
        }
    }];
    
    return internalError != nil ? internalError : error;
}

@end

