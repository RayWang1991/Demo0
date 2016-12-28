/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTGetMicroClassInfoDelegate.h 
 * Created by ray wang on 16/12/28.
 */

#import <Foundation/Foundation.h>
@protocol BMTGetMicroClassInfoDelegate<NSObject>
@required
-(void) getLatestMicroClassInfo;
@end