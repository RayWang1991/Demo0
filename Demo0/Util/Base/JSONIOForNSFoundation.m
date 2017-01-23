/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "JSONIOForNSFoundation.h"

#import "NSString+BMTExtension.h"
#import "JSONIO.h"

id toNSNull(id object)
{
    return object == nil ? [NSNull null] : object;
}

@implementation NSArray (JSONIO)

- (id)encodeToJSON
{
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        if ([item respondsToSelector:@selector(encodeToJSON)]) {
            [result addObject:toNSNull([item encodeToJSON])];
        } else {
            DDLogError(@"NSArray.encodeToJSON failed, please support @selector(encodeToJSON:) in item:%@", [NSString stringForBMTLog:item]);
            assert(false);
        }
    }
    return result;
}

+ (NSArray*)arrayFromJSON:(id)json withInternalClass:(Class)cls
{
    if (![json isKindOfClass:[NSArray class]]) {
        DDLogError(@"NSArray.arrayFromJSON failed, json is not an array, json: %@", [NSString stringForBMTLog:json]);
        assert(false);
        return nil;
    }
    if ([cls isSubclassOfClass:[NSArray class]]) {
        DDLogError(@"NSArray.arrayFromJSON Can't support NSArray of NSArray!");
        assert(false);
        return nil;
    }
    if ([cls isSubclassOfClass:[NSDictionary class]]) {
        DDLogError(@"NSArray.arrayFromJSON Can't support NSArray of NSDictionary!");
        assert(false);
        return nil;
    }
    
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:[json count]];
    for (id jsonItem in json) {
        id item = [cls alloc];
        if ([item respondsToSelector:@selector(initWithJSON:)]) {
            [result addObject:toNSNull([item initWithJSON:jsonItem])];
        } else {
            DDLogError(@"JSONUtil.arrayFromJSON failed, please support @selector(initWithJSON:) in class:%@", cls);
            assert(false);
        }
    }
    return result;
}

@end

@implementation NSNumber (JSONIO)

- (id)initWithNSNumber:(NSNumber*)number
{
    self = [self initWithShort:0];      // to disable warning : Convenience initializer missing a 'self' call to another initializer
    if (self) {
        self = [number copy];
    }
    return self;
}

- (id)initWithJSON:(id)json
{
    if (json == [NSNull null]) {
        return nil;
    }
    if (![json isKindOfClass:[NSNumber class]]) {
        DDLogError(@"NSNumber.initWithJSON failed, json is not a number, json: %@", [NSString stringForBMTLog:json]);
        assert(false);
        return nil;
    }
    return [self initWithNSNumber:json];
}

- (id)encodeToJSON
{
    return self;
}

@end

@implementation NSString (JSONIO)

- (id)initWithJSON:(id)json
{
    if (json == [NSNull null]) {
        return nil;
    }
    if (![json isKindOfClass:[NSString class]]) {
        DDLogError(@"NSString.initWithJSON failed, json is not a string, json: %@", [NSString stringForBMTLog:json]);
        assert(false);
        return nil;
    }
    return [self initWithString:json];
}

- (id)encodeToJSON
{
    return self;
}

@end
