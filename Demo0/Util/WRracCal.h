/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * WRracCal.h 
 * Created by ray wang on 16/12/15.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WRracCal : NSObject
@property(assign, nonatomic)int  result;
@property(assign, nonatomic)BOOL equal;
/*
 * @param receive a block indicates the calculate operations
 * the block receive an int value ,and make calculation moves, returns the
 * result
 * @return the WRraCal instance ,containing the refreshed result
 * */
-(WRracCal *) calculate : (int(^)(int value)) operation;
/*
 * @param receive a block indicates the is equal operation
 * the block receive an int value, and judge whether it's equal to some
 * certain value;
 * @return the isEqual bool
 * */
-(WRracCal *) isEquals : (BOOL(^)(int value)) operation;
@end

int main_WRrac();
