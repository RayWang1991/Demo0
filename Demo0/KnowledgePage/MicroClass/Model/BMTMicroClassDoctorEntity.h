/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassDoctorEntity.h 
 * Created by ray wang on 16/12/28.
 */

#import <Foundation/Foundation.h>
#import "JSONModel/JSONModel.h"

@interface BMTMicroClassDoctorEntity : NSObject
@property(nonatomic, strong) NSString *gender;
@property(nonatomic, strong) NSString *introduction;
@property(nonatomic, strong) NSNumber *doctorId;
@property(nonatomic, strong) NSString *organization;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *phoneNo;
@property(nonatomic, strong) NSString *name;

@end