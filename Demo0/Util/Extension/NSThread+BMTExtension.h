/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSThread (BMTExtension)

- (void)performBlock:(void(^)())block;

- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay;

@end
