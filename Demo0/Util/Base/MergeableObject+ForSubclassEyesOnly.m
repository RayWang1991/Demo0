/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "MergeableObject+ForSubclassEyesOnly.h"

@implementation MergeableObject (ForSubclassEyesOnly)

- (BOOL)willMergeValue:(id)value forKey:(NSString*)key
{
    return YES;
}

@end
