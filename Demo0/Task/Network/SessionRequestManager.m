/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * SessionRequestManager.m 
 * Created by ray wang on 16/12/16.
 */

#import "SessionRequestManager.h"
#import "BMTKnowledgeInfoEntity.h"
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
  BOOL isReachable =
      [[Reachability reachabilityForInternetConnection] isReachable];
  if (isReachable) {
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
                                         timeoutInterval:15];
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

                      if (aModel) {
                        NSLog(@"aModel isn't nil!");
                        [resArray addObject:aModel];
                      }
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
                                               userInfo:@{
                                                   @"error": @"no data"}];
                    NSLog(@"session fails without data");
                  }
                  failBlock(resError);
                }
              }] resume];
  } else {
    NSError *resError = [NSError errorWithDomain:NSCocoaErrorDomain
                                            code:-1
                                        userInfo:@{
                                            @"error": @"unreachable!"}];
    NSLog(@"session fails with unreachable!");
    failBlock(resError);
  }
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
                            type:[BMTKnowledgeInfoEntity class]
                             arg:dict];
}

- (void)getBannersFromServerNumber:(NSInteger)num
                           success:(void (^)(NSArray *array))sucBlock
                           failure:(void (^)(NSError *error))failBlock {
/*
  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            type:[BMTBannerEntity class]
                             num:num];
                             */
  NSDictionary *dict = @{@"num": @(num), @"language": @1};
  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            path:@"/w/poster"
                            type:[BMTBannerEntity class]
                             arg:dict];
}
- (void)getLatestMicroClassInfoFromServerOnSuccess:(void (^)(BMTMicroClassInfoEntity *resultEntity))sucBlock
                                           failure:(void (^)(NSError *error))failBlock {
  BOOL isReachable =
      [[Reachability reachabilityForInternetConnection] isReachable];
  if (isReachable) {
    NSString *URLStr = [kBMBASEURL stringByAppendingString:@"/mc/0"];

    NSURL *url = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:0
                                         timeoutInterval:15];

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
                    mcInfoEntity.infoId = dict[@"microClass"][@"id"];
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
                                               userInfo:@{
                                                   @"error": @"no data"}];
                    NSLog(@"session fails without data");
                  }
                  failBlock(resError);
                }
              }] resume];
  } else {
    NSError *resError = [NSError errorWithDomain:NSCocoaErrorDomain
                                            code:-1
                                        userInfo:@{
                                            @"error": @"unreachable!"}];
    NSLog(@"session fails with unreachable!");
    failBlock(resError);
  }
}
@end
