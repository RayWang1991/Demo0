/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSDate+ForStorageField.h"

// 之所以单独做一个Catagory，一个原因时将转化方式封装在内部，还有一点就是保证nil的转换结果仍为nil
@implementation NSDate (ForStorageField)

+ (NSDate*)dateWithDBFieldNumber:(NSNumber*)time
{
    if (time == nil) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:(unsigned long long)[time unsignedLongLongValue]];
}

- (NSNumber*)numberValueForDBField
{
    return [NSNumber numberWithUnsignedLongLong:(unsigned long long)[self timeIntervalSince1970]];
}

@end
