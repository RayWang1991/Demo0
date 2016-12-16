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


- (void)getObjFromServerSuccess:(void (^)(id obj))sucBlock
                        failure:(void (^)(NSError **error))failBlock {

    NSString *str=kTESTURL(1);
    NSLog(@"%@",str);
  NSURL *url = [NSURL URLWithString:kTESTURL(0)];
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
                  failBlock(&dataError);
                } else {
                  // assuming we receive a dictionary indicating the object
                  // here we've nearly done the job
                  NSDictionary *dict = (NSDictionary *) result;
                  NSLog(@"the dict is %@", dict);

                  unsigned int uId = (unsigned int) [result[@"userId"] integerValue];
                  NSString *userName = result[@"name"];
                  NSString *userSex = [result[@"sex"] integerValue] ? @"male" : @"female";
                  NSString *userPhone = result[@"phone"];
                  NSString *userEmail = result[@"email"];
                  NSString *userBirthday = result[@"birthday"];
                  WRPersonModel *aModel =
                      [[WRPersonModel alloc] initWithUserId:uId
                                                       Name:userName
                                                        Sex:userSex
                                                   Birthday:userBirthday
                                                      Phone:userPhone
                                                      Email:userEmail];
                  sucBlock(aModel);
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
                failBlock(&resError);
              }
            }] resume];
}

- (void)getBannerFromServer:(NSInteger)num
                    success:(void (^)(NSMutableArray<RWBanner *> *array, RWBanner *banner))sucBlock
                    failure:(void (^)(NSError **error))failBlock {
  NSURL *url = [NSURL URLWithString:kTESTURL(0)];
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
                  failBlock(&dataError);
                } else {
                  // assuming we receive a dictionary indicating the object
                  // here we've nearly done the job
                  NSDictionary *dict = (NSDictionary *) result;
                  NSLog(@"the dict is %@", dict);

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
                failBlock(&resError);
              }
            }] resume];
};
@end
