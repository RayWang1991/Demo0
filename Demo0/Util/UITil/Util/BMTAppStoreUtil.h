/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface BMTAppStoreUtil : NSObject

+ (NSString*)appId;

+ (NSString*)cnAppStoreURLString;

+ (NSString*)enAppStoreURLString;

+ (NSURL*)cnAppStoreURL;

+ (NSURL*)enAppStoreURL;

@end
