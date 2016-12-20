/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import "Masonry.h"

@interface MASConstraint (DeviceAdapter)

#define mas_equalTo_iPhone5Or5S(...)  equalTo_iPhone5Or5S(MASBoxValue((__VA_ARGS__)))
#define mas_equalTo_iPhone6Or6S(...)  equalTo_iPhone6Or6S(MASBoxValue((__VA_ARGS__)))
#define mas_equalTo_iPhone6POr6SP(...)  equalTo_iPhone6POr6SP(MASBoxValue((__VA_ARGS__)))
#define mas_equalTo_iPhoneIPad(...)  equalTo_iPhoneIPad(MASBoxValue((__VA_ARGS__)))
#define mas_equalTo_iPhone5Or5SOr6Or6S(...)  equalTo_iPhone5Or5SOr6Or6S(MASBoxValue((__VA_ARGS__)))
#define mas_equalTo_iPhone6POr6SPOrIPad(...)  equalTo_iPhone6POr6SPOrIPad(MASBoxValue((__VA_ARGS__)))

- (MASConstraint * (^)(id attr))equalTo_iPhone5Or5S;

- (MASConstraint * (^)(id attr))equalTo_iPhone6Or6S;

- (MASConstraint * (^)(id attr))equalTo_iPhone6POr6SP;

- (MASConstraint * (^)(id attr))equalTo_iPhoneIPad;

- (MASConstraint * (^)(id attr))equalTo_iPhone5Or5SOr6Or6S;

- (MASConstraint * (^)(id attr))equalTo_iPhone6POr6SPOrIPad;

- (MASConstraint * (^)(CGFloat offset))iPhone5Or5SOffset;

- (MASConstraint * (^)(CGFloat offset))iPhone6Or6SOffset;

- (MASConstraint * (^)(CGFloat offset))iPhone6POr6SPOffset;

- (MASConstraint * (^)(CGFloat offset))iPhoneIPadOffset;

- (MASConstraint * (^)(CGFloat offset))iPhone5Or5SOr6Or6SOffset;

- (MASConstraint * (^)(CGFloat offset))iPhone6POr6SPOrIPadOffset;

@end
