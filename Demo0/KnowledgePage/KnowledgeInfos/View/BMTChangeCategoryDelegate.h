/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTChangeCategoryDelegate.h 
 * Created by ray wang on 16/12/27.
 */

#import <Foundation/Foundation.h>
@protocol BMTChangeCategoryDelegate<NSObject>
@required
-(void) changeCategoryTo:(NSUInteger)catId;
@end