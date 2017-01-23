/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

/**
 *  DBRecordIO 协议定义了如何将 self 序列化/反序列化 成一条数据库记录 的接口
 */
@protocol DBRecordIO <NSObject>

/**
 *  从一条数据库记录解码出所需信息
 *
 *  @param content 字段名到字段值的对应关系
 */
- (instancetype)initWithDBRecord:(NSDictionary*)content;

/**
 *  编码成一条数据库记录
 *
 *  @return 返回数据库字段名到字段值的对应关系
 */
- (NSDictionary*)encodeForDBRecord;

@end
