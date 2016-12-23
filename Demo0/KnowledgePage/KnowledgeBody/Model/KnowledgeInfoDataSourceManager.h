/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeDataSourceModel.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>
#import "BMTKnowledgeInfoNumState.h"
#import "BMTEntityKnowledgeInfo.h"
#import "BMTEntityKnowledgeInfo.h"
#import "FMDBManager.h"
#import "SessionRequestManager.h"

@interface KnowledgeInfoDataSourceManager : NSObject
//@property(strong, nonatomic) BMTKnowledgeInfoNumState *knowledgeInfoNumState;
@property(strong, nonatomic) NSMutableArray <NSNumber *>
    *knowledgeInfoOffsetStateArray;
@property(strong, nonatomic) NSMutableArray <NSMutableArray<BMTEntityKnowledgeInfo *> *>
    *knowledgeInfoEntityArray;

@property(weak, nonatomic) FMDBManager *storageManager;
@property(weak, nonatomic) SessionRequestManager *requestManager;
+ (instancetype)sharedManager;
- (instancetype)init;

- (NSInteger)getMoreKnowledgeInfo:(NSUInteger)number
                       categoryId:(NSUInteger)catId;

- (NSInteger)getRefreshedKnowledgeInfo:(NSUInteger)number
                       categoryId:(NSUInteger)catId;


@end