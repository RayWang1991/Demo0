/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wuyike@bongmi.com
 */

#import "MASConstraint+DeviceAdapter.h"
#import "BMMacro.h"
#import "BMTUIConstants.h"
#import "MASConstraint+Private.h"

@implementation MASConstraint (DeviceAdapter)

- (MASConstraint * (^)(id attr))equalTo_iPhone5Or5S {
  return ^id(id attribute) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone5 &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone5) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(id attr))equalTo_iPhone6Or6S {
  return ^id(id attribute) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6 &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(id attr))equalTo_iPhone6POr6SP {
  return ^id(id attribute) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6p &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6p) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(id attr))equalTo_iPhoneIPad {
  return ^id(id attribute) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIpad &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIpad) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(id attr))equalTo_iPhone5Or5SOr6Or6S {
  return ^id(id attribute) {
    if ((WIDTH_SCREEN == kBMTDeviceScreenWidthIphone5 &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone5) ||
        (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6 &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6)) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(id attr))equalTo_iPhone6POr6SPOrIPad {
  return ^id(id attribute) {
    if ((WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6p &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6p) ||
        (WIDTH_SCREEN == kBMTDeviceScreenWidthIpad &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIpad)) {
      return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    } else {
      return self;
    }
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhone5Or5SOffset {
  return ^id(CGFloat offset) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone5 &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone5) {
      self.offset = offset;
    }
    return self;
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhone6Or6SOffset {
  return ^id(CGFloat offset) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6 &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6) {
      self.offset = offset;
    }
    return self;
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhone6POr6SPOffset {
  return ^id(CGFloat offset) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6p &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6p) {
      self.offset = offset;
    }
    return self;
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhoneIPadOffset {
  return ^id(CGFloat offset) {
    if (WIDTH_SCREEN == kBMTDeviceScreenWidthIpad &&
        HEIGHT_SCREEN == kBMTDeviceScreenHeightIpad) {
      self.offset = offset;
    }
    return self;
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhone5Or5SOr6Or6SOffset {
  return ^id(CGFloat offset) {
    if ((WIDTH_SCREEN == kBMTDeviceScreenWidthIphone5 &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone5) ||
        (WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6 &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6)) {
      self.offset = offset;
    }
    return self;
  };
}

- (MASConstraint * (^)(CGFloat offset))iPhone6POr6SPOrIPadOffset {
  return ^id(CGFloat offset) {
    if ((WIDTH_SCREEN == kBMTDeviceScreenWidthIphone6p &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIphone6p) ||
        (WIDTH_SCREEN == kBMTDeviceScreenWidthIpad &&
         HEIGHT_SCREEN == kBMTDeviceScreenHeightIpad)) {
      self.offset = offset;
    }
    return self;
  };
}

@end
