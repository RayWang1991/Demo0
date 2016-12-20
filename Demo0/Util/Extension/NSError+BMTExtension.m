/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSError+BMTExtension.h"

@implementation NSError (BMTExtension)

+ (instancetype)errorWithDomain:(NSString*)domain code:(NSInteger)code description:(NSString*)description, ...
{
    if (description == nil) {
        description = @"";
    }
    va_list vl;
    va_start(vl, description);
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:[[NSString alloc] initWithFormat:description arguments:vl]};
    NSError* result = [self errorWithDomain:domain code:code userInfo:userInfo];
    va_end(vl);
    return result;

}

@end
