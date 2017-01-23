/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * WRLocalCacheManager.h 
 * Created by ray wang on 16/12/15.
 */

#import <Foundation/Foundation.h>
#import "EGOCache/EGOCache.h"

@interface WRStorageManager : NSObject
@property (strong, nonatomic)EGOCache *cacheManager;
-(instancetype) sharedManager;
+(BOOL) hasLocalCacheForKey:(NSString *)cacheName;

@end
