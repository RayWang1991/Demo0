/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTBannerTable.h 
 * Created by ray wang on 16/12/20.
 */

#import <Foundation/Foundation.h>
#import "DBKeyValueTable.h"
#import "MergeableObject.h"
#import "DBKeyValueIO.h"
#import "BMTEntityBanner.h"
#import "BMTResourceBanner.h"

@interface BMTBannerTable : DBTableWithUniquePrimaryKey

- (instancetype)initWithDatabase:(FMDatabase*)db;
- (NSArray*)getBannersOrderedById:(NSUInteger)num;
-(BOOL) updateBanner:(BMTEntityBanner *)banner;
//- (BOOL)updateBannerConfig:(BMTEntityBanner*)config;
@end
