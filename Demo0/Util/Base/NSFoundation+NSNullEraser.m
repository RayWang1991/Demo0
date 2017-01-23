/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSFoundation+NSNullEraser.h"

static void g_eraseNSNullRecursive(id object)
{
    if ([object isKindOfClass:[NSMutableArray class]] ||
        [object isKindOfClass:[NSMutableDictionary class]] ||
        [object isKindOfClass:[NSMutableSet class]]) {
        [object eraseNSNullRecursive];
#ifdef DEBUG
    } else if ([object isKindOfClass:[NSArray class]] ||
               [object isKindOfClass:[NSDictionary class]] ||
               [object isKindOfClass:[NSSet class]]) {
        // 一个需要递归移除NSNull的对象，不应该有NSArray/NSDictionary/NSSet这种nonmutable的容器存在
        assert(false);
#endif
    } else if (![object isKindOfClass:[NSValue class]] &&
               ![object isKindOfClass:[NSString class]] &&
               ![object isKindOfClass:[NSDate class]] &&
               ![object isKindOfClass:[NSData class]]) {
        // 非基础类型需要自行处理eraseNSNullRecursive
        if ([object respondsToSelector:@selector(eraseNSNullRecursive)]) {
            [object eraseNSNullRecursive];
        }
    }
}

@implementation NSMutableArray (NSNullEraser)

- (void)eraseNSNullRecursive
{
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    [self enumerateObjectsUsingBlock:^(id element, NSUInteger idx, BOOL *stop) {
        if ([element isKindOfClass:[NSNull class]]) {
            [indexSet addIndex:idx];
        } else {
            g_eraseNSNullRecursive(element);
        }
    }];
    if (indexSet.count != 0) {
        [self removeObjectsAtIndexes:indexSet];
    }
}

@end

@implementation NSMutableDictionary (NSNullEraser)

- (void)eraseNSNullRecursive
{
    NSMutableArray* keys = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id element, BOOL *stop) {
        if ([element isKindOfClass:[NSNull class]]) {
            [keys addObject:key];
        } else {
            g_eraseNSNullRecursive(element);
        }
    }];
    if (keys.count != 0) {
        [self removeObjectsForKeys:keys];
    }
}

@end

@implementation NSMutableSet (NSNullEraser)

- (void)eraseNSNullRecursive
{
    [self removeObject:[NSNull null]];
}

@end


