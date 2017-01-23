/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import <Foundation/Foundation.h>

#import "JSONValueTransformer.h"

typedef NS_ENUM(NSInteger, BMTSystemLanguageType) {
  kBMTLanguageTypeUnknow = 0,
  kBMTLanguageTypeChinese = 1,
  kBMTLanguageTypeEnglish = 2
};

@interface BMTResourceSystemLanguageTypeHelper : NSObject

+ (BMTSystemLanguageType)systemLanguageTypeFromString:(NSString *)systemLanguageString;

+ (NSString *)stringFromSystemLanguageType:(BMTSystemLanguageType)systemLanguageType;

@end
