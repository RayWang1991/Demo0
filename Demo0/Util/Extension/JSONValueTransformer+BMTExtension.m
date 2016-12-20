/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "JSONValueTransformer+BMTExtension.h"

@implementation JSONValueTransformer (BMTExtension)

// 在我们的整个项目中， NSDate都使用number记法

- (NSDate*)NSDateFromNSString:(NSString*)string
{
    return [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
}

- (id)JSONObjectFromNSDate:(NSDate*)date
{
    return @((unsigned long long)[date timeIntervalSince1970]);
}

@end
