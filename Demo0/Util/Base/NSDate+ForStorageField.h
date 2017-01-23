/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSDate (ForStorageField)

+ (NSDate*)dateWithDBFieldNumber:(NSNumber*)time;

- (NSNumber*)numberValueForDBField;

@end
