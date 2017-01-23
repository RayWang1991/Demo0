/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSDictionary (ForStorageField)

- (NSString*)stringValueForDBFieldName:(NSString*)key;

- (NSNumber*)numberValueForDBFieldName:(NSString*)key;

- (NSDate*)dateValueForDBFieldName:(NSString*)key;

- (id)valueForDBFieldName:(NSString*)key withClass:(Class)cls;

- (NSArray*)arrayValueForDBFieldName:(NSString*)key withInternalClass:(Class)cls;

@end
