/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassInfoDataManager.h 
 * Created by ray wang on 16/12/28.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SessionRequestManager.h"
#import "FMDBManager.h"
#import "BMTGetMicroClassInfoDelegate.h"
#import "BMTMicroClassInfoEntity.h"
@interface BMTMicroClassInfoDataManager : NSObject<BMTGetMicroClassInfoDelegate>

@property (strong, nonatomic)BMTMicroClassInfoEntity * microClassInfoEntity;
@property(weak, nonatomic) FMDBManager *storageManager;
@property(weak, nonatomic) SessionRequestManager *requestManager;
+ (instancetype)sharedManager;
- (instancetype)init;
- (void)getLatestMicroClassInfo;
@end