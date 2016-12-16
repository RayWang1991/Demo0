/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * SessionRequestManager.h 
 * Created by ray wang on 16/12/16.
 */

#import <Foundation/Foundation.h>
#import "RWBanner.h"
#import <UIKit/UIKit.h>
#import "WRPersonModel.h"
@interface SessionRequestManager : NSObject
+ (instancetype)sharedManager;

- (void)getObjFromServerSuccess:(void (^)(id obj))sucBlock
                        failure:(void (^)(NSError **error))failBlock;

- (void)getBannerFromServer:(NSInteger)num
                    success:(void (^)(NSMutableArray<RWBanner *> *array, RWBanner *banner))sucBlock
                    failure:(void (^)(NSError **error))
                        failBlock;
@end