/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeInfoTable.h 
 * Created by ray wang on 16/12/22.
 */


#import <Foundation/Foundation.h>
#import "DBKeyValueTable.h"
#import "MergeableObject.h"
#import "DBKeyValueIO.h"
#import "BMTEntityKnowledgeInfo.h"
#import "DBTableWithUniqueIntegerPrimaryKey.h"
#import "BMTKnowledgeInfoCategoryState.h"

@interface KnowledgeInfoTable : DBTableWithUniquePrimaryKey

@property (nonatomic)CATEGORY_ID catId;

- (instancetype)initWithDatabase:(FMDatabase *)db
                      categoryId:(NSUInteger)catId;

- (BOOL)addKnowledgeInfo:(BMTEntityKnowledgeInfo *)info;
- (BOOL)addKnowledgeInfoArray:(NSArray *)infoArray;
- (BOOL)deleteAllKnowledgeInfo;

//-(BOOL) updateBannerWithId:;
//-(BOOL) deleteBannerWithId:();


-(NSUInteger)itemsCount;

- (NSArray<BMTEntityKnowledgeInfo *> *)getKnowledgeInfosOrderedByName:(NSUInteger)num;
// always return the top informations of knowledge
// if numbers of item < num, return all

- (NSArray<BMTEntityKnowledgeInfo *> *)getKnowledgeInfosOrderedByName:
    (NSUInteger)num offset:(NSUInteger) offset;
// with offset

- (Class)queryClassWithResultDictionary:(NSDictionary *)dict;
@end
