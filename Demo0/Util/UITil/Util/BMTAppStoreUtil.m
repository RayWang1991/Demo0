/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "BMTAppStoreUtil.h"

@implementation BMTAppStoreUtil

+ (NSString*)appId {
#ifdef THERMOMETER_VERSION
    return @"1015458128";
#endif
  
#ifdef THERACKER_VERSION
    return @"1159631020";
#endif
    return @"1015458128";
}

+ (NSURL*)cnAppStoreURL {
  return [NSURL URLWithString:[self cnAppStoreURLString]];
}

+ (NSURL*)enAppStoreURL {
  return [NSURL URLWithString:[self enAppStoreURLString]];
}

+ (NSString*)cnAppStoreURLString {
  return [@"https://itunes.apple.com/cn/app/id" stringByAppendingString:[self appId]];
}

+ (NSString*)enAppStoreURLString {
  return [@"https://itunes.apple.com/us/app/id" stringByAppendingString:[self appId]];
}

@end
