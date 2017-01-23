/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "BMTJSONModel.h"

@implementation BMTJSONModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    // 参见头文件注释，先检查optionalKeys
    NSArray* optionalKeys = [self optionalKeys];
    if (optionalKeys != nil) {
        return [optionalKeys indexOfObject:propertyName] != NSNotFound;
    } else {
        NSArray* necessaryKeys = [self necessaryKeys];
        if (necessaryKeys != nil) {
            return [necessaryKeys indexOfObject:propertyName] == NSNotFound;
        } else {
            return NO;
        }
    }
}

@end


@implementation BMTJSONModel (Protected)

+ (NSArray*)necessaryKeys
{
    return nil;
}

+ (NSArray*)optionalKeys
{
    return nil;
}


@end