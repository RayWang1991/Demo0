/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSNotificationCenter+BMTAutoDetached.h"
#import "NSObject+BMTExtension.h"
#import "BMTStorageConstant.h"
#import "Constants.h"
@implementation NSNotificationCenter (BMTAutoDetached)

- (void)addAutoDetachedObserver:(id)observer
                       selector:(SEL)aSelector
                           name:(NSString *)aName
                         object:(id)anObject
{
    [self addObserver:observer selector:aSelector name:aName object:anObject];
    @weakify(self);
    @weakify(observer);
    [observer whenDealloc:^{
        @strongify(self);
        @strongify(observer);
        [self removeObserver:observer name:aName object:observer];
    }];
}


@end
