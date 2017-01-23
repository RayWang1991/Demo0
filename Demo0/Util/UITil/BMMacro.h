/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#ifndef BM_BMMACRO_H
#define BM_BMMACRO_H

// property
//#import "Modified_Samurai_Property.h"

// localization
// 正常说来，宏应该是大写，在代码编写中大写字母一般是按Shift键打出，但是打数字却不能按住Shift键
// 因此此处的l10n采用全小写，方便输入
#define l10n(key) NSLocalizedString(key, @"")

// img
#ifndef IMG
#define IMG(x) [UIImage imageNamed:x]
#endif // #ifndef IMG

// weakify and strongify
#ifndef weakify
#define weakify( x ) \
    autoreleasepool{} __weak typeof(x) __weak_##x##__ = x;
#endif // #ifndef weakify

#ifndef strongify
#define strongify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    autoreleasepool{} typeof(x) x = __weak_##x##__; \
    _Pragma("clang diagnostic pop")
#endif // #ifndef strongify

// double float equal
inline BOOL bmt_isCGFloatEqual(CGFloat v1, CGFloat v2) {
#if CGFLOAT_IS_DOUBLE
    return fabs(v1 - v2) <= DBL_EPSILON;
#else
    return fabsf(v1 - v2) <= FLT_EPSILON;
#endif
}

#define WIDTH_SCREEN [UIScreen mainScreen].bounds.size.width
#define HEIGHT_SCREEN [UIScreen mainScreen].bounds.size.height

#define MIN_STANDARDTEMPERATURE_CENTIGRADE 35.5
#define MAX_STANDARDTEMPERATURE_CENTIGRADE 37.5

#define MIN_STANDARDTEMPERATURE_FAHRENHEIT 95.8
#define MAX_STANDARDTEMPERATURE_FAHRENHEIT 99.8

#endif // #ifndef BM_BMMACRO_H
