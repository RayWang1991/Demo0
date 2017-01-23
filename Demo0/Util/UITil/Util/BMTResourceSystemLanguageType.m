/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import "BMTResourceSystemLanguageType.h"

@implementation BMTResourceSystemLanguageTypeHelper

+ (NSDictionary *)type2String {
  return @{
           @(kBMTLanguageTypeChinese) : @"CHINESE",
           @(kBMTLanguageTypeEnglish) : @"ENGLISH"
           };
}

+ (BMTSystemLanguageType)systemLanguageTypeFromString:(NSString *)systemLanguageString {
  NSArray *keys = [[self type2String] allKeysForObject:systemLanguageString];
  assert(keys.count == 1);
  if (keys.count > 0) {
    return [keys[0] integerValue];
  }
  return kBMTLanguageTypeUnknow;
}

+ (NSString *)stringFromSystemLanguageType:(BMTSystemLanguageType)systemLanguageType {
  if (systemLanguageType == kBMTLanguageTypeUnknow) {
    assert(NO);
    return nil;
  }
  NSString *result = [[self class] type2String][@(systemLanguageType)];
  assert(result != nil);
  return result;
}

@end
