/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeDataSourceModel.m 
 * Created by ray wang on 16/12/22.
 */

#import "KnowledgeInfoDataSourceManager.h"

@implementation KnowledgeInfoDataSourceManager {

}
- (instancetype)init {
  self = [super init];
  if (self) {
    // default offset are all 0s;
    _knowledgeInfoNumStateArray =
        [NSMutableArray arrayWithArray:@[@(0), @(0), @(0), @(0)]];

    // no info entities yet
    _knowledgeInfoArrayCat1 =
        [[NSMutableArray alloc] init];
    _knowledgeInfoArrayCat2 =
        [[NSMutableArray alloc] init];
    _knowledgeInfoArrayCat3 =
        [[NSMutableArray alloc] init];
    _knowledgeInfoArrayCat4 =
        [[NSMutableArray alloc] init];

    _storageManager = [FMDBManager sharedInstance];
    _requestManager = [SessionRequestManager sharedManager];
  }
  return self;
}
- (void)getMoreKnowledgeInfo:(NSUInteger)number {
  // add more event
  // just get more knowledge information, dont refresh
  // 1 get from database ,if fail/error/shortage then
  // 2 get from server, if success ,refresh the database

}
- (void)getRefreshedKnowledgeInfo:(NSUInteger)number {
  // refresh event
  // just get from server, if success , refresh the database

}


@end