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

+ (instancetype)sharedManager {
  static KnowledgeInfoDataSourceManager *manager = nil;
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
    _knowledgeInfoOffsetStateArray =
        [NSMutableArray arrayWithArray:@[@(0), @(0), @(0), @(0)]];

    // no info entities yet
    _knowledgeInfoEntityArray =
        [[NSMutableArray alloc] initWithCapacity:4];

    for (int i = 0; i < 4; i++) {
      [_knowledgeInfoEntityArray addObject:[[NSMutableArray alloc] init]];
    }

    _storageManager = [FMDBManager sharedInstance];
    _requestManager = [SessionRequestManager sharedManager];
  }
  return self;
}

#pragma mark -provide data to controller and implement getKnowledgeInfoDelegate
- (void)getMoreKnowledgeInfo:(NSUInteger)number
                  categoryId:(NSUInteger)catId {
  // add more event
  // just get more knowledge information, dont refresh
  // 0 get from current entity array(according to offset)
  // 1 get from database ,if fail/error/shortage then
  // 2 get from server, if success ,refresh the database

  NSUInteger catIndex = ((catId - 1) % 4);

  NSMutableArray <BMTEntityKnowledgeInfo *> *currentCatEntityArray = self
      .knowledgeInfoEntityArray[catIndex];

  KnowledgeInfoTable *currentCatTable = self.storageManager
      .knowledgeInfoTableArray[catIndex];

  NSUInteger currentOffset = self.knowledgeInfoOffsetStateArray[catIndex]
      .unsignedIntegerValue;

  if (currentCatEntityArray.count
      >= currentOffset + number) {
    // get from current entity array
    NSLog(@"GET More Infos from CURRENT ENTITY ARRAY");
    NSRange range = NSMakeRange(currentOffset, number);

    NSArray *resArray = [currentCatEntityArray subarrayWithRange:range];

    [currentCatEntityArray addObjectsFromArray:resArray];

    self.knowledgeInfoOffsetStateArray[catIndex] =
        @(currentOffset + resArray.count);
    // refresh the offset
    [self sendNotificationWithAskedNum:number
                             returnNum:resArray.count];

  } else {
    // get from database
    NSArray *resArray =
        [currentCatTable getKnowledgeInfosOrderedByName:number
                                                 offset:currentOffset];
    if (resArray != nil && resArray.count >= number) {
      NSLog(@"GET More Infos from CURRENT DATABASE");
      [currentCatEntityArray addObjectsFromArray:resArray];
      self.knowledgeInfoOffsetStateArray[catIndex] =
          @(currentOffset + resArray.count);
      [self sendNotificationWithAskedNum:number
                               returnNum:resArray.count];


    } else {
      [self.requestManager
          getKnowledgeBriefsFromServerSuccess:^(NSArray *serverResultArray) {
            // if success , add the result array to entity array
            // and return the number of result array
            [currentCatEntityArray addObjectsFromArray:serverResultArray];
            self.knowledgeInfoOffsetStateArray[catIndex] =
                @(currentOffset + serverResultArray.count);
            NSLog(@"GET More Infos from SERVER");
            // and save the result to database later
            [currentCatTable addKnowledgeInfoArray:serverResultArray];

            [self sendNotificationWithAskedNum:number
                                     returnNum:serverResultArray.count];
          }
                                      failure:^(NSError *error) {
                                        // deal with error
                                        NSLog(@"GET More Infos FAILED!");

                                        [self sendNotificationWithAskedNum:number
                                                                 returnNum: -1];
                                      }
                                   categoryId:catId
                                       offset:currentOffset
                                       number:number];
    }
  }
}

- (void)getRefreshedKnowledgeInfo:(NSUInteger)number
                       categoryId:(NSUInteger)catId {
  // refresh event
  // just get from server, if success , refresh the database

  NSUInteger catIndex = ((catId - 1) % 4);

  NSMutableArray <BMTEntityKnowledgeInfo *> *currentCatEntityArray = self
      .knowledgeInfoEntityArray[catIndex];

  KnowledgeInfoTable *currentCatTable = self.storageManager
      .knowledgeInfoTableArray[catIndex];

  /*NSUInteger currentOffset = self.knowledgeInfoOffsetStateArray[catIndex]
      .unsignedIntegerValue;
  */

  [self.requestManager
      getKnowledgeBriefsFromServerSuccess:^(NSArray *serverResultArray) {
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

//TODO
- (NSInteger)getBackupKnowledgeInfo:(NSUInteger)number
                         categoryId:(NSUInteger)catId {
  return -1;
}

- (void)getFirstShownKnowledgeInfo:(NSUInteger)number
                        categoryId:(NSUInteger)catId {

}

#pragma mark - private
- (void)sendNotificationWithAskedNum:(NSInteger)askNum
                           returnNum:(NSInteger)
                               returnNum {
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"KnowledgeInfoDataArrived"
                    object:self
                  userInfo:@{
                      @"askedNum": @(askNum),
                      @"returnNum": @(returnNum)}];
}

@end
