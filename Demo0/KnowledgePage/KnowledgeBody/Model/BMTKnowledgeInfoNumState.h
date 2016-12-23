/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowledgeInfoNumStateManager.h 
 * Created by ray wang on 16/12/23.
 */

#import <Foundation/Foundation.h>
#import "BMTKnowledgeInfoCategoryState.h"

#define DEFAULT_KNOWLEDGE_NUMBERS (5u)


@interface BMTKnowledgeInfoNumState : NSObject
@property(nonatomic) BMTKnowledgeInfoCategoryState
    *currentCategoryStateManager;
@property(nonatomic) enum CATEGORY_ID catId;
@property(nonatomic) NSMutableArray <BMTKnowledgeInfoCategoryState *>
    *catStateManagerArray;
// init the should shown number in each category number manager, the default
// offset is always zero;

-(instancetype) initWithInfoNumbersInEachCategory:(NSUInteger) number;
-(instancetype) init;
-(void)setDefault;
@end