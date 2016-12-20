/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSArray (JSONIO)

- (id)encodeToJSON;

+ (NSArray*)arrayFromJSON:(id)json withInternalClass:(Class)cls;

@end

@interface NSNumber (JSONIO)

- (id)initWithJSON:(id)json;

- (id)encodeToJSON;

@end

@interface NSString (JSONIO)

- (id)initWithJSON:(id)json;

- (id)encodeToJSON;

@end