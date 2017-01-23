/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "MergeableObject.h"

@interface MergeableObject (ForSubclassEyesOnly)

/**
 *  在将要对具体key进行merge操作时调用
 *
 *  @param value 将要进行merge的key
 *  @param key   将要进行merge的value
 *
 *  @return 如不进行默认merge操作，请返回NO
 */
- (BOOL)willMergeValue:(id)value forKey:(NSString*)key;

@end
