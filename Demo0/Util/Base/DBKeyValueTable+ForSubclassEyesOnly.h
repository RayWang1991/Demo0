/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBKeyValueTable.h"
#import "DBAbstractTable+ForSubclassEyesOnly.h"

@interface DBKeyValueTable (ForSubclassEyesOnly)

- (NSString*)dbKeyName;

- (NSString*)dbKeyValue;

@end
