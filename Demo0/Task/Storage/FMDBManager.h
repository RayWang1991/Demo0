/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * FMDBManager.h 
 * Created by ray wang on 16/12/19.
 */

#import <Foundation/Foundation.h>
#import "FMDB/FMDB.h"
#import "BMTBannerTable.h"
#import "BMTStorageConstant.h"


#define DBNAME @"raywang.db"

extern NSString *const kBMTStorageErrorDomain;
      // NSString *WRStorageDomain=@"WRSORAGE";

@interface FMDBManager : NSObject


+ (instancetype)sharedInstance;

- (void)prepare;

- (void)destroy;


@end
