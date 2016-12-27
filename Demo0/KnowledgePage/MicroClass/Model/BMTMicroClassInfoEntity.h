/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassInfoEntity.h 
 * Created by ray wang on 16/12/27.
 */

#import <Foundation/Foundation.h>
#import "JSONModel/JSONModel.h"

@interface BMTMicroClassInfoEntity : JSONModel
@property(nonatomic, strong) NSString *avatarAddress;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *participants;
@property(nonatomic, assign) NSNumber *startTimestamp;

@end