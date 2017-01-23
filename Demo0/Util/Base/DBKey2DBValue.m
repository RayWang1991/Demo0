/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBKey2DBValue.h"
#import "DBKeyValueRecord.h"
#import "JSONIO.h"
#import "JSONUtil.h"
#import "JSONIOForNSFoundation.h"
#import "NSDate+ForStorageField.h"

@interface DBKey2DBValue ()
@property (nonatomic)NSMutableDictionary* key2value;
@end

@implementation DBKey2DBValue

- (instancetype) init
{
    return [self initWithDBKeyAndValueArray:nil];
}

- (instancetype)initWithDBKeyAndValueArray:(NSArray*)array
{
    self = [super init];
    if (self){
        [self resetFromDBKeyAndValueArray:array];
    }
    return self;
}

- (void)resetFromDBKeyAndValueArray:(NSArray*)array
{
    self.key2value = [NSMutableDictionary dictionary];
    for (DBKeyValueRecord* keyAndValue in array){
        NSCAssert([keyAndValue isKindOfClass:[DBKeyValueRecord class]], @"keyAndValue must be an instance of DBKeyValueRecord!");
        NSCAssert([self.key2value objectForKey:keyAndValue.DBkey] == nil, @"there are same keys in DBKeyValueRecords: %@!", array);
        [self.key2value setObject:keyAndValue.DBvalue forKey:keyAndValue.DBkey];
    }
}

- (NSArray*)toDBKeyAndValueArray;
{
    NSMutableArray* array = [NSMutableArray array];
    [self.key2value enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* value, BOOL *stop){
        [array addObject:[DBKeyValueRecord recordWithKey:key value:value]];
    }];
    return array;
}

- (NSNumber*)boolValueForKey:(NSString*)key
{
    return [self boolValueForKey:key defaultValue:nil];
}

- (NSNumber*)boolValueForKey:(NSString*)key defaultValue:(NSNumber *)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value boolValue]);
    } defaultValue:defaultValue];
}

- (NSNumber*)intValueForKey:(NSString*)key
{
    return [self intValueForKey:key defaultValue:nil];
}

- (NSNumber*)intValueForKey:(NSString*)key defaultValue:(NSNumber *)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value intValue]);
    } defaultValue:defaultValue];
}

- (NSNumber*)integerValueForKey:(NSString*)key
{
    return [self integerValueForKey:key defaultValue:nil];
}

- (NSNumber*)integerValueForKey:(NSString*)key defaultValue:(NSNumber*)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value integerValue]);
    } defaultValue:defaultValue];
}


- (NSNumber*)longLongValueForKey:(NSString*)key
{
    return [self longLongValueForKey:key defaultValue:nil];
}

- (NSNumber*)longLongValueForKey:(NSString*)key defaultValue:(NSNumber *)value
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value longLongValue]);
    } defaultValue:value];
}

- (NSNumber*)floatValueForKey:(NSString*)key
{
    return [self floatValueForKey:key defaultValue:nil];
}

- (NSNumber*)floatValueForKey:(NSString*)key defaultValue:(NSNumber *)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value floatValue]);
    } defaultValue:defaultValue];
}

- (NSNumber*)doubleValueForKey:(NSString*)key
{
    return [self doubleValueForKey:key defaultValue:nil];
}


- (NSNumber*)doubleValueForKey:(NSString*)key defaultValue:(NSString*)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return @([value doubleValue]);
    } defaultValue:defaultValue];
}

- (NSString*)stringValueForKey:(NSString*)key
{
    return [self stringValueForKey:key defaultValue:nil];
}

- (NSString*)stringValueForKey:(NSString*)key defaultValue:(NSString*)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return value;
    } defaultValue:defaultValue];
}

- (NSDate*)dateValueForKey:(NSString*)key
{
    return [self dateValueForKey:key defaultValue:nil];
}

- (NSDate*)dateValueForKey:(NSString *)key defaultValue:(NSDate*)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        return [NSDate dateWithDBFieldNumber:@([value longLongValue])];
    } defaultValue:defaultValue];
}


- (id)objectValueForKey:(NSString*)key withClass:(Class)cls
{
    return [self objectValueForKey:key withClass:cls defaultValue:nil];
}

- (id)objectValueForKey:(NSString*)key withClass:(Class)cls defaultValue:(id)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        id result = [cls alloc];
        NSCAssert([result conformsToProtocol:@protocol(JSONIO)] || [result respondsToSelector:@selector(initWithJSON:)], @"%@ must implement JSONIO protocol!", cls);
        return [result initWithJSON:[JSONUtil jsonFromString:value]];
    } defaultValue:defaultValue];
}

- (NSArray*)arrayValueForKey:(NSString*)key withInnerClass:(Class)cls
{
    return [self arrayValueForKey:key withInnerClass:cls defaultValue:nil];
}

- (NSArray*)arrayValueForKey:(NSString*)key withInnerClass:(Class)cls defaultValue:(NSArray *)defaultValue
{
    return [self objectValueForKey:key withDecoder:^id(NSString *value) {
        NSCAssert([[cls alloc] conformsToProtocol:@protocol(JSONIO)] || [[cls alloc] respondsToSelector:@selector(initWithJSON:)], @"%@ must implement JSONIO protocol!", cls);
        return [NSArray arrayFromJSON:[JSONUtil jsonFromString:value] withInternalClass:cls];
    } defaultValue:defaultValue];
}

- (id)objectValueForKey:(NSString*)key withDecoder:(id(^)(NSString* value))decoder
{
    return [self objectValueForKey:key withDecoder:decoder defaultValue:nil];
}

- (id)objectValueForKey:(NSString*)key withDecoder:(id(^)(NSString* value))decoder defaultValue:(id)defaultValue
{
    NSString* value = [self.key2value objectForKey:key];
    if (value == nil) {
        return defaultValue;
    }
    id result = decoder(value);
    if (result == nil) {
        return defaultValue;
    }
    return result;
}

- (void)setValue:(id)value forKey:(NSString*)key withEncoder:(NSString*(^)(id value)) encoder
{
    if (value == nil) {
        return;
    }
    NSString* result = encoder(value);
    if (result == nil) {
        return;
    }
    [self.key2value setObject:result forKey:key];
}

- (void)setNumberValue:(NSNumber*)value forKey:(NSString*)key
{
    [self setValue:value forKey:key withEncoder:^NSString *(id value) {
        return [value stringValue];
    }];
}

- (void)setStringValue:(NSString*)value forKey:(NSString*)key
{
    [self setValue:value forKey:key withEncoder:^NSString *(id value) {
        return value;
    }];
}

- (void)setDateValue:(NSDate*)value forKey:(NSString*)key
{
    [self setValue:value forKey:key withEncoder:^NSString *(id value) {
        return [[value numberValueForDBField] stringValue];
    }];
}

- (void)setObjectValue:(id)value forKey:(NSString*)key
{
    [self setValue:value forKey:key withEncoder:^NSString *(id value) {
        return [JSONUtil stringFromObject:value];
    }];
}

- (void)setArrayValue:(NSArray*)value forKey:(NSString*)key
{
    [self setValue:value forKey:key withEncoder:^NSString *(id value) {
        return [JSONUtil stringFromObject:value];
    }];
}

// 截获kvc的接口，防止误用
- (id)valueForKey:(NSString *)key
{
    NSCAssert(NO, @"You shouldn't use this inteface, try -(id)stringValueForKey instead!");
    return [super valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSCAssert(NO, @"You shouldn't use this inteface, try -(void)setStringValue:forKey: instead!");
    [super setValue:value forKey:key];
}

@end
