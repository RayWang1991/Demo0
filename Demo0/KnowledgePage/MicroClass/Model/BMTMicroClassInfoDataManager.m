/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassInfoDataManager.m 
 * Created by ray wang on 16/12/28.
 */

#import "BMTMicroClassInfoDataManager.h"

@implementation BMTMicroClassInfoDataManager

+ (instancetype)sharedManager {
  static BMTMicroClassInfoDataManager *manager = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    if (!manager) {
      manager = [[self alloc] init];
    }
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    // default offset are all 0s;
    _storageManager = [FMDBManager sharedInstance];
    _requestManager = [SessionRequestManager sharedManager];
  }
  return self;
}

- (void)getLatestMicroClassInfo {
  // just get the latest mc information from server, if fail, use the backup
  [self.requestManager
      getLatestMicroClassInfoFromServerOnSuccess:^
      (BMTMicroClassInfoEntity *resultEntity) {
        if (resultEntity) {
          _microClassInfoEntity = resultEntity;
          [[NSNotificationCenter defaultCenter]
              postNotificationName:@"MicroClassInfoDataArrived"
                            object:self];
          [self.storageManager.microClassInfoTable
              addMicroClassInfo:resultEntity];
        } else {
          [self getBackUpMicroClassInfo];
        }
      }
                                         failure:^(NSError *error) {
                                           // TODO deal with
                                           // error
                                           NSLog(@"GET Refreshed Micro Class Info "
                                                     "FAILED!!!");
                                           // then  get backup data;
                                           [self getBackUpMicroClassInfo];
                                         }];
}

#pragma - private
- (void)getBackUpMicroClassInfo {

  BMTMicroClassInfoEntity *entity = self.microClassInfoEntity;
  if (entity) {
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"MicroClassInfoDataArrived"
                      object:self];
  } else {
    entity = [self.storageManager.microClassInfoTable getLatestMicroClassInfo];
    _microClassInfoEntity = entity;
    if (entity)
      [[NSNotificationCenter defaultCenter]
          postNotificationName:@"MicroClassInfoDataArrived"
                        object:self];
    // if no data, do nothing
  }
};
@end