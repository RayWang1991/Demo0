/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * SessionRequestManager.m 
 * Created by ray wang on 16/12/16.
 */

#import "SessionRequestManager.h"
#import "BMTEntityKnowledgeInfo.h"
#define kBMBASEURL @"https://api.bongmi.com/v1"

#define kTESTURL(d) @"https://raw.githubusercontent.com/RayWang1991/TestData/master/person" # d ".json"

@implementation SessionRequestManager {

}
+ (instancetype)sharedManager {
  static SessionRequestManager *manager = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    if (!manager) {
      manager = [[SessionRequestManager alloc] init];
    }
  });
  return manager;
}

#pragma - private
- (void)getObjsFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                         failure:(void (^)(NSError *error))failBlock
                            path:(NSString *)path
                            type:(Class)classType
                             arg:(NSDictionary *)dict {
  NSMutableString *appendStr = [NSMutableString string];
  [appendStr appendString:path];
  if (dict && dict.count) {
    NSUInteger argNumber = dict.count;
    [appendStr appendString:@"?"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      [appendStr appendFormat:@"%@=%@&",
                              key,
                              dict[key]];
    }];
    [appendStr deleteCharactersInRange:NSMakeRange(appendStr.length - 1, 1)];
    // delete the last '&'
  }
  NSString *URLStr = [kBMBASEURL stringByAppendingString:appendStr];

  NSURL *url = [NSURL URLWithString:URLStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url
                                           cachePolicy:0
                                       timeoutInterval:30];
  [[[NSURLSession sharedSession]
      dataTaskWithRequest:request
        completionHandler:
            ^(NSData *_Nullable data, NSURLResponse *_Nullable response,
              NSError *_Nullable sessionError) {
              if (!sessionError && data) {
                NSError *dataError = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data
                                                            options:0
                                                              error:&dataError];
                NSLog(@"the dic is %@", result);

                if (dataError) {
                  // there may be data analysis error
                  NSLog(@"data analysis error : %@", dataError);
                  failBlock(dataError);
                } else {
                  // the give class must be a subclass of JSONModel
                  NSCAssert([classType isSubclassOfClass:[JSONModel class]],
                            @"not a jsonmodel");

                  // now convert json dict to model
                  // assuming we receive an array containing
                  // dicionaries indicating the objects

                  NSCAssert([result isKindOfClass:[NSArray class]],
                            @"the result isn't an array");

                  // TODO optimize here
                  NSCAssert([result[0] isKindOfClass:[NSDictionary class]],
                            @"the result[0] isn't a dictionary");
                  // NSCAssert([result count]>=numbers,@"the returned numbers does not match");
                  NSMutableArray *resArray = [[NSMutableArray alloc] init];
                  for (int i = 0; i < [result count]; i++) {

                    NSDictionary *dict = (NSDictionary *) result[i];
                    NSLog(@"the dict is %@", dict);

                    JSONModelError *jsonModelError = nil;

                    id aModel = [[classType alloc] initWithDictionary:dict
                                                                error:&jsonModelError];

                    if (jsonModelError != nil) {
                      NSLog(@"Model convert fails, error: %@, json: %@",
                            jsonModelError, dict);
                    }
                    [resArray addObject:aModel];
                  }
                  sucBlock(resArray);
                }

              } else {
                NSError *resError = nil;
                // there may be session error or no data error
                if (sessionError) {
                  resError = sessionError;
                  NSLog(@"session fails with error: %@", sessionError);
                } else {
                  resError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-1
                                             userInfo:@{@"error": @"no data"}];
                  NSLog(@"session fails without data");
                }
                failBlock(resError);
              }
            }] resume];
}

#pragma - public

- (void)getKnowledgeInfosFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                                   failure:(void (^)(NSError *error))failBlock
                                categoryId:(NSUInteger)categoryId
                                    offset:(NSUInteger)offset
                                    number:(NSUInteger)number {
  NSDictionary *dict =
      @{@"category_id": @(categoryId),
          @"language": @(1),
          @"count": @(number),
          @"pageNo": @(1),
          @"pageSize": @(offset)};

  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            path:@"/w/knowledge"
                            type:[BMTEntityKnowledgeInfo class]
                             arg:dict];
}

- (void)getBannersFromServerNumber:(NSInteger)num
                           success:(void (^)(NSArray *array))sucBlock
                           failure:(void (^)(NSError *error))failBlock {
/*
  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            type:[BMTEntityBanner class]
                             num:num];
                             */
  NSDictionary *dict = @{@"num": @(num), @"language": @1};
  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            path:@"/w/poster"
                            type:[BMTEntityBanner class]
                             arg:dict];
}
- (void)getLatestMicroClassInfoFromServerOnSuccess:(void (^)(BMTMicroClassInfoEntity *resultEntity))sucBlock
                                           failure:(void (^)(NSError *error))failBlock {

  NSString *URLStr = [kBMBASEURL stringByAppendingString:@"/mc/0"];

  NSURL *url = [NSURL URLWithString:URLStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url
                                           cachePolicy:0
                                       timeoutInterval:30];

  [[[NSURLSession sharedSession]
      dataTaskWithRequest:request
        completionHandler:
            ^(NSData *_Nullable data, NSURLResponse *_Nullable response,
              NSError *_Nullable sessionError) {
              if (!sessionError && data) {
                NSError *dataError = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data
                                                            options:0
                                                              error:&dataError];
                NSLog(@"the dic is %@", result);

                if (dataError) {
                  // there may be data analysis error
                  NSLog(@"data analysis error : %@", dataError);
                  failBlock(dataError);
                } else {
                  // TODO optimize here
                  NSDictionary *dict = (NSDictionary *) result;
                  NSLog(@"the dict is %@", dict);

                  BMTMicroClassInfoEntity *mcInfoEntity =
                      [[BMTMicroClassInfoEntity alloc] init];
                  mcInfoEntity.infoId=dict[@"microClass"][@"id"];
                  mcInfoEntity.avatarAddress = dict[@"avatarAddress"];
                  mcInfoEntity.title =
                      dict[@"microClass"][@"subject"];
                  mcInfoEntity.startTimestamp =
                      dict[@"microClass"][@"startTimestamp"];
                  mcInfoEntity.applicants =
                      dict[@"microClass"][@"applicants"];

                  sucBlock(mcInfoEntity);
                }
              } else {
                NSError *resError = nil;
                // there may be session error or no data error
                if (sessionError) {
                  resError = sessionError;
                  NSLog(@"session fails with error: %@", sessionError);
                } else {
                  resError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-1
                                             userInfo:@{@"error": @"no data"}];
                  NSLog(@"session fails without data");
                }
                failBlock(resError);
              }
            }] resume];

}
@end
