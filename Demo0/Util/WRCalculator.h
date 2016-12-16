/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * WRCalculator.h 
 * Created by ray wang on 16/12/15.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WRCalculator : NSObject
@property (assign, nonatomic) CGFloat result;

-(instancetype)init;

+(CGFloat)makeCalculation:(void(^) (WRCalculator *)) operation;

-(WRCalculator *(^)(int)) add;

-(WRCalculator *(^)(int)) mul;
@end
int main_WRCal();
