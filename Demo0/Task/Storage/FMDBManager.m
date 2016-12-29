/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * FMDBManager.m 
 * Created by ray wang on 16/12/19.
 */

#import "FMDBManager.h"
#import "NSError+BMTExtension.h"
#import "FMDatabase+Extension.h"]

/*
@interface FMDBManager ()

@property (nonatomic) FMDatabaseQueue *db;
@property (nonatomic) BMTBannerTable * bannerTable;

@end
*/

@implementation FMDBManager {

}
+ (instancetype)sharedInstance {
  static FMDBManager *manager = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    if (!manager) {
      manager = [[self alloc] init];
    }
  });
  return manager;
}

- (void)destroy {
  [self.db close];
  NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES)[0];
  path = [path stringByAppendingPathComponent:BMT_DB_NAME];
  [[NSFileManager defaultManager] removeItemAtPath:path
                                             error:nil];
}

- (void)prepare {
  NSError *error = [self prepareInternal];
  if (error != nil) {
    DDLogError(@"BMTStorageManager prepare failed, error: %@", error);
  }
}

- (NSError *)prepareInternal {
  NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES)[0];
  path = [path stringByAppendingPathComponent:BMT_DB_NAME];

  NSLog(@"the  path is : %@", path);

  self.db = [FMDatabaseQueue databaseQueueWithPath:path];
  if (self.db == nil) {
    assert(NO);
    return [NSError errorWithDomain:kStorageErrorDomain
                               code:kShouldNotOccur
                        description:@"BMTStorageManager prepare db file failed,"
                                        " path is %@",
                                    path];
  }

  return [self.db inAutoRollbackSavePoint:^NSError *(FMDatabase *db) {
    // create table

    _bannerTable = [[BMTBannerTable alloc] initWithDatabase:db];
    _microClassInfoTable =
        [[BMTMicroClassInfoTable alloc] initWithDatabase:db];

    _knowledgeInfoTableArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 4; i++) {
      BMTKnowledgeInfoTable *knowledgeInfoTable = [[BMTKnowledgeInfoTable alloc]
          initWithDatabase:db
                categoryId:i];
      [self.knowledgeInfoTableArray addObject:knowledgeInfoTable];
    }
    NSArray *tables = @[self.bannerTable,
        self.microClassInfoTable,
        self.knowledgeInfoTableArray[0],
        self.knowledgeInfoTableArray[1],
        self.knowledgeInfoTableArray[2],
        self.knowledgeInfoTableArray[3],
    ];
    for (DBAbstractTable *table in tables) {
      BOOL success = [table createTable];
      if (!success) {
        return [NSError errorWithDomain:kStorageErrorDomain
                                   code:kShouldNotOccur
                            description:@"%@.createTable failed",
                                        NSStringFromClass([table class])];
      }
    }

    return nil;
  }];
}


@end
