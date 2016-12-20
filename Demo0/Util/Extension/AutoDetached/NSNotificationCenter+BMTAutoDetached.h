/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (BMTAutoDetached)

// wrap addObserver:selector:name:object:
- (void)addAutoDetachedObserver:(id)observer
                       selector:(SEL)aSelector
                           name:(NSString *)aName
                         object:(id)anObject;

@end
