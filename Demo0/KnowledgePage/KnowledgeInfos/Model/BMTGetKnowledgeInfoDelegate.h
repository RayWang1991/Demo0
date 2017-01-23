/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * getKnowledgeInfoDelegate.h 
 * Created by ray wang on 16/12/27.
 */

#import <Foundation/Foundation.h>
@protocol BMTGetKnowledgeInfoDelegate<NSObject>

@required
- (void)getMoreKnowledgeInfo:(NSUInteger)number
                  categoryId:(NSUInteger)catId;

- (void)getRefreshedKnowledgeInfo:(NSUInteger)number
                       categoryId:(NSUInteger)catId;

- (void)getFirstShownKnowledgeInfo:(NSUInteger)number
                        categoryId:(NSUInteger)catId;
@end