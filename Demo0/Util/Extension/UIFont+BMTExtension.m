/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: zhangjunshuai@bongmi.com
 */

#import "UIFont+BMTExtension.h"
#import "BMTMiscUtil.h"

@implementation UIFont (BMTExtension)

+ (UIFont *)bm_setFontOfSize:(CGFloat)fontSize {
  if ([BMTMiscUtil isChineseLanguageEnvironment]) {
    return [self systemFontOfSize:fontSize];
  } else {
    return [self fontWithName:@"Bariol" size:fontSize];
  }
}

+ (UIFont *)bm_getFontOfName:(NSString *)name
                        size:(CGFloat)size
                 andSizeType:(BMTFontSizeType)sizeType {
  UIFont *font = [self fontWithName:[self getFontNameWithName:name andFontSizeType:sizeType] size:size];
  if (font == nil) {
    font = [self boldSystemFontOfSize:size];
  }
  return font;
}

+ (NSString *)getFontNameWithName:(NSString *)fontName
                  andFontSizeType:(BMTFontSizeType)sizeType {
  switch (sizeType) {
    case kBMTFontSizeTypeLight:
      fontName = [fontName stringByAppendingString:@"-Light"];
      break;
    case kBMTFontSizeTypeRegular:
      fontName = [fontName stringByAppendingString:@"-Regular"];
      break;
    case kBMTFontSizeTypeMedium:
      fontName = [fontName stringByAppendingString:@"-Medium"];
      break;
    case kBMTFontSizeTypeBold:
      fontName = [fontName stringByAppendingString:@"-Bold"];
      break;
    default:
      break;
  }
  return fontName;
}

@end
