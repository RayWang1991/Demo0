/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithUniqueIntegerPrimaryKey+ForSubclassEyesOnly.h"

@implementation DBTableWithUniqueIntegerPrimaryKey (ForSubclassEyesOnly)

- (BOOL)allowAddItemWithKeyValue
{
    return NO;
}

@end
