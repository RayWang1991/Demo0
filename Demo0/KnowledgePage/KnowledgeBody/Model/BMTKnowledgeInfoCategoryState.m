/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowledgeInfoCategoryStateManager.m 
 * Created by ray wang on 16/12/23.
 */

#import "BMTKnowledgeInfoCategoryState.h"

@implementation BMTKnowledgeInfoCategoryState {

}
- (instancetype)initWithCategoryId:(NSUInteger)catId
                            number:(NSUInteger)number
                            offset:(NSUInteger)offset {
  self = [super init];
  if (self) {
    _categoryId=(enum CATEGORY_ID)(1+(catId%4));
    _offset = offset;
    _number = catId;
  }
  return self;
}
- (void)refreshWithNumber:(NSUInteger)number
                   offset:(NSUInteger)offset {
  self.number = number;
  self.offset = offset;
}

@end