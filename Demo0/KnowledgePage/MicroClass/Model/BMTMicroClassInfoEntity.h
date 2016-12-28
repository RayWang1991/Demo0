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
// what we need to display
@property(nonatomic, strong) NSNumber *infoId;
@property(nonatomic, strong) NSString *avatarAddress;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *applicants;
@property(nonatomic, assign) NSNumber *startTimestamp;

- (instancetype)initWithDBRecord:(NSDictionary *)content;

- (NSDictionary *)encodeForDBRecord;
@end