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
@property (strong, nonatomic) NSMutableArray <NSNumber *>*knowledgeInfoNumStateArray;
@property(strong, nonatomic) NSMutableArray <BMTEntityKnowledgeInfo *>
    *knowledgeInfoArrayCat1;
@property(strong, nonatomic) NSMutableArray <BMTEntityKnowledgeInfo *>
    *knowledgeInfoArrayCat2;
@property(strong, nonatomic) NSMutableArray <BMTEntityKnowledgeInfo *>
    *knowledgeInfoArrayCat3;
@property(strong, nonatomic) NSMutableArray <BMTEntityKnowledgeInfo *>
    *knowledgeInfoArrayCat4;

@property(weak, nonatomic) FMDBManager *storageManager;
@property(weak, nonatomic) SessionRequestManager *requestManager;
-(instancetype)init;
-(void)getMoreKnowledgeInfo:(NSUInteger)number;
-(void)getRefreshedKnowledgeInfo:(NSUInteger)number;
//- (instancetype)initWithRandom;
@end