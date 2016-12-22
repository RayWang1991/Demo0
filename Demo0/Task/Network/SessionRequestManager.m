/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * SessionRequestManager.m 
 * Created by ray wang on 16/12/16.
 */

#import "SessionRequestManager.h"
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

- (void)getObjsFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                         failure:(void (^)(NSError *error))failBlock
                            type:(Class)classType
                             num:(NSInteger)numbers {

  //NSString *str=kTESTURL(1);
  NSString *str = [kBMBASEURL stringByAppendingFormat:@"/w/poster?num=%d&language=1",numbers];

  NSLog(@"%@", str);
  NSURL *url = [NSURL URLWithString:str];
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
                NSLog(@"the dic is %@", data);

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
                  NSCAssert([result[0] isKindOfClass:[NSDictionary class]],
                            @"the result[0] isn't a dictionary");
                 // NSCAssert([result count]>=numbers,@"the returned numbers does not match");
                  NSMutableArray *resArray=[[NSMutableArray alloc]init];
                  for(int i=0;i<[result count];i++) {

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

- (void)getKnowledgeBriefsFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                                    failure:(void (^)(NSError *error))failBlock
                                 categoryId:(NSUInteger)categoryId {
  NSString *str = [kBMBASEURL
      stringByAppendingFormat:@"/w/knowledge?category_id=%d&language=%d"
                                  "&pageNo=%d&pageSize=%d",categoryId,1,1,5];

  NSLog(@"%@", str);
  NSURL *url = [NSURL URLWithString:str];
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
                NSLog(@"the dic is %@", data);

                if (dataError) {
                  // there may be data analysis error
                  NSLog(@"data analysis error : %@", dataError);
                  failBlock(dataError);
                } else {
                  // the give class must be a subclass of JSONModel
                  // NSCAssert([classType isSubclassOfClass:[JSONModel class]],
                            @"not a jsonmodel");

                  // now convert json dict to model
                  // assuming we receive an array containing
                  // dicionaries indicating the objects

                  NSCAssert([result isKindOfClass:[NSArray class]],
                            @"the result isn't an array");
                  NSCAssert([result[0] isKindOfClass:[NSDictionary class]],
                            @"the result[0] isn't a dictionary");
                  // NSCAssert([result count]>=numbers,@"the returned numbers does not match");
                  NSMutableArray *resArray=[[NSMutableArray alloc]init];
                  for(int i=0;i<[result count];i++) {

                    NSDictionary *dict = (NSDictionary *) result[i];
                    NSLog(@"the dict is %@", dict);

                    JSONModelError *jsonModelError = nil;

                    //i d aModel = [[classType alloc] initWithDictionary:dict
                    // error:&jsonModelError];

                    if (jsonModelError != nil) {
                      NSLog(@"Model convert fails, error: %@, json: %@",
                            jsonModelError, dict);
                    }
                   // [resArray addObject:aModel];
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
- (void)getBannerFromServer:(NSInteger)num
                    success:(void (^)(NSArray *array))sucBlock
                    failure:(void (^)(NSError *error))failBlock {

  [self getObjsFromServerSuccess:sucBlock
                         failure:failBlock
                            type:[BMTEntityBanner class]
                             num:num];
}
@end
