/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSObject (BMTExtension)

- (void)whenDealloc:(void(^)())action;

- (void)printCallStackSymbols;

@end
