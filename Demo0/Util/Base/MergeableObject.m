/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "MergeableObject.h"

#import <objc/runtime.h>
#import "MergeableObject+ForSubclassEyesOnly.h"

@implementation MergeableObject

- (NSArray*)allPropertyName:(MergeableObject*)otherEntity
{
    NSMutableArray* result = [NSMutableArray array];
    for (Class currentClass = [otherEntity class]; currentClass != [MergeableObject class]; currentClass = [currentClass superclass]) {
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

- (void)mergeFrom:(MergeableObject*)otherEntity
{
    NSArray *propertys = [self allPropertyName:otherEntity];
    for(NSString *propertyName in propertys)
    {
        id propertyValue = [otherEntity valueForKey:propertyName];
        if ([self willMergeValue:propertyValue forKey:propertyName]) {
            // in default, we only merge non-null values
            if (propertyValue != nil && propertyValue != [NSNull null]) {
                id originPropertyValue = [self valueForKey:propertyName];
                if ([originPropertyValue respondsToSelector:@selector(mergeFrom:)]) {
                    [originPropertyValue mergeFrom:propertyValue];
                } else
                {
                    if ([propertyName isEqualToString:@"superclass"]
                        || [propertyName isEqualToString:@"hash"]
                        || [propertyName isEqualToString:@"description"]
                        || [propertyName isEqualToString:@"debugDescription"]) {
                        continue;
                    }
                    [self setValue:propertyValue forKey:propertyName];
                }
            }
        }
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DDLogError(@"%@.setValue:%@ forUndefinedKey:%@", NSStringFromClass([self class]), value, key);
}

@end
