/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSNullEraser)

- (void)eraseNSNullRecursive;

@end



@interface NSMutableDictionary (NSNullEraser)

- (void)eraseNSNullRecursive;

@end


@interface NSMutableSet (NSNullEraser)

- (void)eraseNSNullRecursive;

@end
