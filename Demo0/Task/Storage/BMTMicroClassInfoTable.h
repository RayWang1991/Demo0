/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassInfoTable.h 
 * Created by ray wang on 16/12/28.
 */

#import <Foundation/Foundation.h>
#import "DBKeyValueTable.h"
#import "MergeableObject.h"
#import "DBKeyValueIO.h"
#import "BMTMicroClassInfoEntity.h"
#import "DBTableWithUniqueIntegerPrimaryKey.h"
#import "BMTKnowledgeInfoCategoryState.h"

@interface BMTMicroClassInfoTable : DBTableWithUniquePrimaryKey

- (BOOL)addMicroClassInfo:(BMTMicroClassInfoEntity *)info;
- (instancetype)initWithDatabase:(FMDatabase *)db;
- (BMTMicroClassInfoEntity *)getLatestMicroClassInfo;
@end
