/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "DBKey2DBValue.h"


/**
 *  DBKeyValueIO 定义了如何将 self 序列化成一个Table中的键值对，以及如何再从键值对中恢复出数据的接口
 *  这里有两组encode与decode的接口，在使用时选择其中一组实现即可。
 */
@protocol DBKeyValueIO <NSObject>

@optional

/**
 *  从键值对中恢复出数据
 *
 *  @param content 键值对
 */
- (instancetype)initWithDBKey2DBValue:(DBKey2DBValue*)key2Value;


/**
 *  从键值对中恢复出数据, 与[self initWithDBKey2Value]区别是这个接口里key可以是重复的
 *
 *  @param content 键值对列表
 */
- (instancetype)initWithDBKeyValues:(NSArray*)keyValueRecords;

/**
 *  编码成键值对序列
 *
 *  @return 键值对
 */
- (DBKey2DBValue*)encodeForDBKey2DBValue;

/**
 *  编码成键值对序列
 *
 *  @return 键值对序列
 */
- (NSArray*)encodeForDBKeyValues;

@end
