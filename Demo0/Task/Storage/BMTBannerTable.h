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
#import "BMTBannerEntity.h"
#import "BMTResourceBanner.h"

@interface BMTBannerTable : DBTableWithUniquePrimaryKey

- (instancetype)initWithDatabase:(FMDatabase *)db;
-(BOOL) addBanner:(BMTBannerEntity *)banner;
-(BOOL) addBanners:(NSArray *)bannerArray;
-(BOOL) deleteAllBanners;

//-(BOOL) updateBannerWithId:;
//-(BOOL) deleteBannerWithId:();

- (NSArray<BMTBannerEntity *> *)getBannersOrderedByName:(NSUInteger)num;
//- (BMTBannerEntity *)getBanner
-(Class)queryClassWithResultDictionary:(NSDictionary *)dict;
@end
