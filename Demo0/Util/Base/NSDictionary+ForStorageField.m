/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSDictionary+ForStorageField.h"
#import "NSString+BMTExtension.h"
#import "JSONUtil.h"
#import "JSONIO.h"
#import "JSONIOForNSFoundation.h"
#import "NSDate+ForStorageField.h"

@implementation NSDictionary (ForStorageField)
- (NSString*)stringValueForDBFieldName:(NSString*)key
{
    id result = [self objectForKey:key];
    if (result == nil || result == [NSNull null]) {
        return nil;
    }
    if (![result isKindOfClass:[NSString class]]) {
        DDLogError(@"NSDirectory.stringValueFromDictionary failed, value is not a NSString : %@", [NSString stringForBMTLog:result]);
        assert(false);
        return nil;
    }
    return result;
}

- (NSNumber*)numberValueForDBFieldName:(NSString*)key
{
    id result = [self objectForKey:key];
    if (result == nil || result == [NSNull null]) {
        return nil;
    }
    if (![result isKindOfClass:[NSNumber class]]) {
        DDLogError(@"NSDirectory.numberValueFromDictionary failed, value is not a NSNumber : %@", [NSString stringForBMTLog:result]);
        assert(false);
        return nil;
    }
    return result;
}

- (NSDate*)dateValueForDBFieldName:(NSString*)key
{
    id result = [self objectForKey:key];
    if (result == nil || result == [NSNull null]) {
        return nil;
    }
    
    if (![result isKindOfClass:[NSNumber class]]) {
        DDLogError(@"NSDirectory.dateValueFromDictionary failed, value is not a NSNumber : %@", [NSString stringForBMTLog:result]);
        assert(false);
        return nil;
    }
    return [NSDate dateWithDBFieldNumber:result];
}

- (id)valueForDBFieldName:(NSString*)key withClass:(Class)cls
{
    id result = [self objectForKey:key];
    if (result == nil || result == [NSNull null]) {
        return nil;
    }
    if (![result isKindOfClass:[NSString class]]) {
        DDLogError(@"NSDirectory.valueFromDictionary failed, value is not a NSString : %@", [NSString stringForBMTLog:result]);
        assert(false);
        return nil;
    }
    return [[cls alloc] initWithJSON:[JSONUtil jsonFromString:result]];
}

- (NSArray*)arrayValueForDBFieldName:(NSString*)key withInternalClass:(Class)cls
{
    id result = [self objectForKey:key];
    if (result == nil || result == [NSNull null]) {
        return nil;
    }
    if (![result isKindOfClass:[NSString class]]) {
        DDLogError(@"NSDirectory.arrayValueFromDictionary failed, value is not a NSString : %@", [NSString stringForBMTLog:result]);
        assert(false);
        return nil;
    }
    return [NSArray arrayFromJSON:[JSONUtil jsonFromString:result] withInternalClass:cls];
}
@end
