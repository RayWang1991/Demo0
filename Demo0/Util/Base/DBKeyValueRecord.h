/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "MergeableObject.h"
#import "DBRecordIO.h"

@interface DBKeyValueRecord : MergeableObject<DBRecordIO>
@property (nonatomic) NSString* DBkey;
@property (nonatomic) NSString* DBvalue;
+ (instancetype) recordWithKey:(NSString*)key value:(NSString*)value;
@end
