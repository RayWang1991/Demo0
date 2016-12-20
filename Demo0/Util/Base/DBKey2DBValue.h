/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "FMDB/FMDB.h"
#import <Foundation/Foundation.h>

@interface DBKey2DBValue : NSObject

- (instancetype) init;

// 从DBKeyAndValue数组里初始化，要求array里必须都是DBKeyAndValue对象
- (instancetype) initWithDBKeyAndValueArray:(NSArray*)array;

// 将原有数据清空，再从array里初始化，要求array里必须都是DBKeyAndValue对象，如果array为nil，表示只清空
- (void)resetFromDBKeyAndValueArray:(NSArray*)array;

// 转成DBKeyAndValue的数组
- (NSArray*)toDBKeyAndValueArray;

/********************************* Getter *********************************/

// 获取key对应的值, 转化为对应的number, 如果值为空，或者转化不成功，返回default（无default返回nil）
- (NSNumber*)boolValueForKey:(NSString*)key;
- (NSNumber*)boolValueForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSNumber*)intValueForKey:(NSString*)key;
- (NSNumber*)intValueForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSNumber*)integerValueForKey:(NSString*)key;
- (NSNumber*)integerValueForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSNumber*)longLongValueForKey:(NSString*)key;
- (NSNumber*)longLongValueForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSNumber*)floatValueForKey:(NSString*)key;
- (NSNumber*)floatValueForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSNumber*)doubleValueForKey:(NSString*)key;
- (NSNumber*)doubleValueForKey:(NSString*)key defaultValue:(NSNumber*)value;

// 获取key对应的值，转化为NSString，如果值为空，返回default（无default返回nil）
- (NSString*)stringValueForKey:(NSString*)key;
- (NSString*)stringValueForKey:(NSString*)key defaultValue:(NSString*)value;

// 获取key对应的值，转化为NSDate，如果值为空，返回default（无default返回nil）
- (NSDate*)dateValueForKey:(NSString*)key;
- (NSDate*)dateValueForKey:(NSString *)key defaultValue:(NSDate*)value;

// 获取key对应的值, 转化为cls对应的实例，要求cls必须实现了JSONIO(或为NSNumber，NSString)，如果值为空，返回default（无default返回nil）
- (id)objectValueForKey:(NSString*)key withClass:(Class)cls;
- (id)objectValueForKey:(NSString*)key withClass:(Class)cls defaultValue:(id)value;

// 获取key对应的值，转化为cls对应实例的array，要求cls必须实现JSONIO(或为NSNumber，NSString)，如果值为空，返回default（无default返回nil）
- (NSArray*)arrayValueForKey:(NSString*)key withInnerClass:(Class)cls;
- (NSArray*)arrayValueForKey:(NSString*)key withInnerClass:(Class)cls defaultValue:(NSArray*)value;

// 获取key对应的值，使用decoder进行解码，返回解码返回的内容，如果值为空，返回default（无default返回nil）
// 注意，如果decoder返回值为nil，则依然返回default
- (id)objectValueForKey:(NSString*)key withDecoder:(id(^)(NSString* value))decoder;
- (id)objectValueForKey:(NSString*)key withDecoder:(id(^)(NSString* value))decoder defaultValue:(id)value;


/********************************* Setter *********************************/

// 设置key对应的number，如果number为nil，不处理任何事情
- (void)setNumberValue:(NSNumber*)value forKey:(NSString*)key;

// 设置key对应的string, 如果string为nil，不处理任何事情
- (void)setStringValue:(NSString*)value forKey:(NSString*)key;

// 设置key对应的date，如果date为nil，不处理任何事情
- (void)setDateValue:(NSDate*)value forKey:(NSString*)key;

// 设置key对应的object, 要求object必须实现了JSONIO(或为NSNumber，NSString)，如果值为nil，不做任何事情
- (void)setObjectValue:(id)value forKey:(NSString*)key;

// 设置key对应的array，array内object需要实现JSONIO(或为NSNumber，NSString)，如果array为nil，不做任何事情
- (void)setArrayValue:(NSArray*)value forKey:(NSString*)key;

@end