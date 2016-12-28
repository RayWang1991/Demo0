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



  [self.requestManager
      getKnowledgeInfosFromServerSuccess:^(NSArray *serverResultArray) {
        // if success , add the result array to entity array
        // and return the number of result array

        // reset the offset
        [currentCatEntityArray removeAllObjects];
        [currentCatEntityArray addObjectsFromArray:serverResultArray];
        self.knowledgeInfoOffsetStateArray[catIndex] =
            @(serverResultArray.count);

        NSLog(@"GET Refreshed Infos from SERVER");
        // notification
        [self sendNotificationWithAskedNum:number
                                 returnNum:serverResultArray.count];

        // save the result to database later
        [currentCatTable addKnowledgeInfoArray:serverResultArray];

      }
                                 failure:^(NSError *error) {
                                   // TODO deal with error

                                   NSLog(@"GET Refreshed Infos FAILED!");

                                   [self sendNotificationWithAskedNum:number
                                                            returnNum:-1];
                                 }
                              categoryId:catId
                                  offset:0
                                  number:number];
}

- (void)getLatestMicroClassInfo {
  // just get the latest mc information from server, if fail, use the backup
 [self.requestManager getLatestMicroClassInfoFromServerOnSuccess:^
     (BMTMicroClassInfoEntity *resultEntity){
       if(resultEntity){
         _microClassInfoEntity=resultEntity;
         [[NSNotificationCenter defaultCenter]
             postNotificationName:@"MicroClassInfoDataArrived"
                           object:self];
       }
       else{
        [self getBackUpMicroClassInfo];
       }
     }
                                                         failure:<#(void (^)(NSError *error))failBlock#>];
}

#pragma - private
-(void)getBackUpMicroClassInfo{

};
@end