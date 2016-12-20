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

#define DBNAME @"raywang.db"

NSString *WRStorageDomain=@"WRSORAGE";

@interface FMDBManager : NSObject
@property (strong, nonatomic)FMDatabaseQueue *db;
//-(NSError *)prepare;
-(NSError *)prepareInternal;
//-(NSError *)inDBForBanners:(NSError *(^)(FMDatabase *db,))
@end