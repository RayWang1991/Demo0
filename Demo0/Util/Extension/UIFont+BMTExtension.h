/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: zhangjunshuai@bongmi.com
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BMTFontSizeType) {
  kBMTFontSizeTypeLight,
  kBMTFontSizeTypeRegular,
  kBMTFontSizeTypeMedium,
  kBMTFontSizeTypeBold
};

@interface UIFont (BMTExtension)

+ (UIFont *)bm_setFontOfSize:(CGFloat)fontSize;

+ (UIFont *)bm_getFontOfName:(NSString *)name
                        size:(CGFloat)size
                 andSizeType:(BMTFontSizeType)sizeType;
@end
