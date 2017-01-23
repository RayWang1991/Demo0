/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBAbstractTable+ForSubclassEyesOnly.h"
#import "DBRecordIO.h"
#import "BMTStorageConstant.h"
#import "NSError+BMTExtension.h"

@implementation DBAbstractTable (ForSubclassEyesOnly)

- (NSError*)createTableIfNeeded
{
    // you should implement this in you subclass
    assert(NO);
    return [NSError errorWithDomain:kStorageErrorDomain code:kShouldNotOccur description:@"you should implement createTableIfNeeded or override createTable"];
}

- (BOOL)allowAddEmptyItem
{
    return NO;
}

- (NSArray*)itemsFromResultSet:(FMResultSet*)set
{
    NSMutableArray* result = [NSMutableArray array];
    while ([set next]) {
        NSDictionary* resultDictionary = [set resultDictionary];
        Class itemClass = [self queryClassWithResultDictionary:resultDictionary];
        id item = [itemClass alloc];
        NSCAssert([item conformsToProtocol:@protocol(DBRecordIO)] || ![self respondsToSelector:@selector(initWithDBRecord:)],
                  @"%@.getItem Failed: %@ doesn't conform to protocol DBRecordIO", NSStringFromClass([self class]), NSStringFromClass([item class]));
        item = [item initWithDBRecord:resultDictionary];
        [result addObject:item];
    }
    return result;
}

- (NSArray*)colFromResultSet:(FMResultSet*)set
{
    NSMutableArray* result = [NSMutableArray array];
    while ([set next]) {
        NSDictionary* resultDictionary = [set resultDictionary];
        if (resultDictionary.count == 1) {
            NSString *value = [[resultDictionary allValues] firstObject];
            [result addObject:value];
        } else {
            return nil;
        }
    }
    return result;
}
@end
