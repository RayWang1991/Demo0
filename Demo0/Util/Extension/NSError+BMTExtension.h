/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSError (BMTExtension)

+ (instancetype)errorWithDomain:(NSString*)domain code:(NSInteger)code description:(NSString*)description, ...;

@end
