/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowledgeInfoCategoryStateManager.h 
 * Created by ray wang on 16/12/23.
 */

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, CATEGORY_ID) {
  CAT_1 = 1,
  CAT_2,
  CAT_3,
  CAT_4,
};

@interface BMTKnowledgeInfoCategoryState : NSObject
@property (nonatomic) enum CATEGORY_ID categoryId;
// should show numbers info items at offset, after shown, refresh
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger offset;

- (instancetype)initWithCategoryId:(NSUInteger)catId
                            number:(NSUInteger)number
                            offset:(NSUInteger)offset;
-(void) refreshWithNumber:(NSUInteger)number offset:(NSUInteger) offset;

@end