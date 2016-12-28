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
#import "BMTKnowledgeInfoTable.h"
#import "BMTStorageConstant.h"

extern NSString *const kBMTStorageErrorDomain;

@interface FMDBManager : NSObject
@property(nonatomic) FMDatabaseQueue *db;
@property(nonatomic) BMTBannerTable *bannerTable;
@property(nonatomic) NSMutableArray <BMTKnowledgeInfoTable *>
    *knowledgeInfoTableArray;
+ (instancetype)sharedInstance;

- (void)prepare;

- (void)destroy;


@end
