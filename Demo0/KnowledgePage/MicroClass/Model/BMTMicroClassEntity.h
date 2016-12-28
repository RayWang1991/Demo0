/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassEntity.h 
 * Created by ray wang on 16/12/28.
 */

#import <Foundation/Foundation.h>
#import "JSONModel/JSONModel.h"
@interface BMTMicroClassEntity : JSONModel
@property (nonatomic,strong) NSNumber *classId;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSNumber *applicants;
@property (nonatomic, strong) NSNumber *startTimestamp;
@property (nonatomic, strong) NSNumber *endTimestamp;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSNumber *heartCount;
@property (nonatomic, strong) NSNumber *flowerCount;
@property (nonatomic, strong) NSNumber *doctorId;
@property (nonatomic, strong) NSNumber *initialApplicants;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *mode;
@property (nonatomic, strong) NSNumber *viewCount;
@property (nonatomic, strong) NSNumber *shareCount;
@property (nonatomic, strong) NSNumber *participants;
@property (nonatomic, strong) NSString *imServerGroupId;
@property (nonatomic, strong) NSNumber *pennantCount;
@property (nonatomic, strong) NSNumber *status;

@end