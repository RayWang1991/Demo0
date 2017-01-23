/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface DeepCopyable : NSObject<NSCoding>

// 深复制本对象, 效率较低, 需要实现NSCoding
- (instancetype)deepCopy;

@end
