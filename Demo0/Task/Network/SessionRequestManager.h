/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * SessionRequestManager.h 
 * Created by ray wang on 16/12/16.
 */

#import <Foundation/Foundation.h>
#import "BMTEntityBanner.h"
#import <UIKit/UIKit.h>
#import "WRPersonModel.h"
@interface SessionRequestManager : NSObject
+ (instancetype)sharedManager;

- (void)getObjsFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                         failure:(void (^)(NSError *error))failBlock
                            type:(Class)classType
                             num:(NSInteger)numbers;

- (void)getBannerFromServer:(NSInteger)num
                    success:(void (^)(NSArray *array))sucBlock
                    failure:(void (^)(NSError *error))failBlock;
@end