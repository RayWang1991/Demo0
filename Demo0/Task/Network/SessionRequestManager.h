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
#import "BMTMicroClassInfoEntity.h"
@interface SessionRequestManager : NSObject
+ (instancetype)sharedManager;

- (void)getKnowledgeInfosFromServerSuccess:(void (^)(NSArray *objArray))sucBlock
                                   failure:(void (^)(NSError *error))failBlock
                                categoryId:(NSUInteger)categoryId
                                    offset:(NSUInteger)offset
                                    number:(NSUInteger)number;

- (void)getBannersFromServerNumber:(NSInteger)num
                           success:(void (^)(NSArray *array))sucBlock
                           failure:(void (^)(NSError *error))failBlock;

- (void)getLatestMicroClassInfoFromServerOnSuccess:(void (^)(BMTMicroClassInfoEntity *resultEntity))sucBlock
                                           failure:(void (^)(NSError *error))failBlock;
@end