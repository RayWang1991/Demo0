/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowledgeInfoNumStateManager.m 
 * Created by ray wang on 16/12/23.
 */

#import "BMTKnowledgeInfoNumState.h"
#define CAT(x) CAT_##x

@implementation BMTKnowledgeInfoNumState {

}
- (instancetype)initWithInfoNumbersInEachCategory:(NSUInteger)number {
  self = [super init];
  if (self) {
    _catStateManagerArray =
        [[[NSMutableArray alloc] init] initWithCapacity:4];
    for (NSUInteger i = 1; i <= 4; i++) {
      BMTKnowledgeInfoCategoryState
          *categoryStateManager = [[BMTKnowledgeInfoCategoryState alloc]
          initWithCategoryId:i
                      number:number
                      offset:0];
      [_catStateManagerArray addObject:categoryStateManager];
    }
    self.catId = CAT_1;
    self.currentCategoryStateManager = self.catStateManagerArray[0];
  }
  return self;
}
- (instancetype)init {
  return [self initWithInfoNumbersInEachCategory:DEFAULT_KNOWLEDGE_NUMBERS];
}
- (void)setDefault {

  for (BMTKnowledgeInfoCategoryState *catManager in self
      .catStateManagerArray) {
    [catManager setOffset:0];
    [catManager setNumber:DEFAULT_KNOWLEDGE_NUMBERS];
  }
  self.catId = CAT_1;
  self.currentCategoryStateManager = self.catStateManagerArray[0];
}


@end