/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTResourceBanner.h 
 * Created by ray wang on 16/12/20.
 */

#import <Foundation/Foundation.h>
#import "BMTJSONModel.h"

@interface BMTResourceBanner : BMTJSONModel

@property(strong, nonatomic) NSString *altText;
@property(strong, nonatomic) NSNumber *height;
@property(strong, nonatomic) NSNumber *width;
@property(strong, nonatomic) NSString *href;
@property(strong, nonatomic) NSString *imgSrc;
@property(strong, nonatomic) NSNumber *language;

@property(strong, nonatomic) NSNumber *status;
@property(strong, nonatomic) NSNumber *type;

@end

