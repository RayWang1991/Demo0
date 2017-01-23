/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface JSONUtil : NSObject

+ (id)nonNSNullJsonFromData:(NSData*)content error:(NSError**)error;

+ (id)nonNSNullJsonFromData:(NSData*)content;

+ (id)nonNSNullJsonFromString:(NSString*)content error:(NSError**)error;

+ (id)nonNSNullJsonFromString:(NSString*)content;

+ (id)jsonFromData:(NSData*)content error:(NSError**)error;

+ (id)jsonFromData:(NSData*)content;

+ (id)jsonFromString:(NSString*)content error:(NSError**)error;

+ (id)jsonFromString:(NSString*)content;

+ (id)jsonFromFileInBundle:(NSString *)fileName ofType:(NSString *)type;

+ (NSString*)stringFromJSON:(id)json;

+ (NSString*)stringFromObject:(id)object;

@end
