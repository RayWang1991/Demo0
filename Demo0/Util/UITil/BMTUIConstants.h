/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuzesheng@bongmi.com
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BMTAppleDeviceType) {
  kBMTAppleDevieTypeIphone5 = 1,
  kBMTAppleDeviceTypeIphone5s = 2,
  kBMTAppleDeviceTypeIphone6 = 3,
  kBMTAppleDeviceTypeIphone6p = 4,
  kBMTAppleDeviceTypeIphone6s = 5,
  kBMTAppleDeviceTypeIphone6sp = 6,
  kBMTAppleDeviceTypeIpad = 7,
  // Add new device type here
  kBMTAppleDeviceTypeNum
};

typedef NS_ENUM(NSUInteger, BMTDeviceScreenWidth) {
  kBMTDeviceScreenWidthIphone5 = 320,
  kBMTDeviceScreenWidthIphone5s = 320,
  kBMTDeviceScreenWidthIphone6 = 375,
  kBMTDeviceScreenWidthIphone6p = 414,
  kBMTDeviceScreenWidthIphone6s = 375,
  kBMTDeviceScreenWidthIphone6sp = 414,
  kBMTDeviceScreenWidthIpad = 768
};

typedef NS_ENUM(NSUInteger, BMTDeviceScreenHeight) {
  kBMTDeviceScreenHeightIphone5 = 568,
  kBMTDeviceScreenHeightIphone5s = 568,
  kBMTDeviceScreenHeightIphone6 = 667,
  kBMTDeviceScreenHeightIphone6p = 736,
  kBMTDeviceScreenHeightIphone6s = 667,
  kBMTDeviceScreenHeightIphone6sp = 736,
  kBMTDeviceScreenHeightIpad = 1024
};

extern NSString *const kBMTSyncTemperatureDataSuccessEvent;