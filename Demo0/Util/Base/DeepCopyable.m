/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DeepCopyable.h"
#import <objc/runtime.h>
#import "CocoaLumberjack/CocoaLumberjack.h"
@implementation DeepCopyable

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self != nil) {
        for (NSString* propertyName in [self allPropertyName]) {
            if ([propertyName isEqualToString:@"superclass"]
                || [propertyName isEqualToString:@"hash"]
                || [propertyName isEqualToString:@"description"]
                || [propertyName isEqualToString:@"debugDescription"]) {
                continue;
            }
            id value = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:value forKey:propertyName];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    for (NSString* propertyName in [self allPropertyName]) {
        if ([propertyName isEqualToString:@"superclass"]
            || [propertyName isEqualToString:@"hash"]
            || [propertyName isEqualToString:@"description"]
            || [propertyName isEqualToString:@"debugDescription"]) {
            continue;
        }
        
        id value = [self valueForKey:propertyName];
        [aCoder encodeObject:value forKey:propertyName];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DDLogError(@"%@.setValue:%@ forUndefinedKey:%@", NSStringFromClass([self class]), value, key);
}

- (NSArray*)allPropertyName
{
    NSMutableArray* result = [NSMutableArray array];
    for (Class currentClass = [self class]; currentClass != [DeepCopyable class]; currentClass = [currentClass superclass]) {
        unsigned int propertyCount = 0;
        objc_property_t* properties = class_copyPropertyList(currentClass, &propertyCount);
        for(unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSString* propertyName = [NSString stringWithUTF8String:property_getName(property)];
            [result addObject:propertyName];
        }
        free(properties);
    }
    return result;
}

// see https://developer.apple.com/library/mac/documentation/cocoa/conceptual/Collections/Articles/Copying.html
- (instancetype)deepCopy
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end
