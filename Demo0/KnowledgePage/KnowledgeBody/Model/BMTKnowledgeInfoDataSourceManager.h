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
#import "BMTGetKnowledgeInfoDelegate.h"

@interface BMTKnowledgeInfoDataSourceManager : NSObject<BMTGetKnowledgeInfoDelegate>
//@property(strong, nonatomic) BMTKnowledgeInfoNumState
// *knowledgeInfoNumState;
@property(strong, nonatomic) NSMutableArray <NSNumber *>
    *knowledgeInfoOffsetStateArray;
@property(strong, nonatomic) NSMutableArray <NSMutableArray<BMTEntityKnowledgeInfo *> *>
    *knowledgeInfoEntityArray;
@property(strong, nonatomic) NSMutableArray <BMTEntityKnowledgeInfo *> *
    currentEntityArray;
@property(weak, nonatomic) FMDBManager *storageManager;
@property(weak, nonatomic) SessionRequestManager *requestManager;
+ (instancetype)sharedManager;
- (instancetype)init;

- (void)getMoreKnowledgeInfo:(NSUInteger)number
                  categoryId:(NSUInteger)catId;

- (void)getRefreshedKnowledgeInfo:(NSUInteger)number
                       categoryId:(NSUInteger)catId;

- (void)getFirstShownKnowledgeInfo:(NSUInteger)number
                        categoryId:(NSUInteger)catId;

@end
