/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KeyValueView.h 
 * Created by ray wang on 16/12/12.
 */

#import <UIKit/UIKit.h>

@interface KeyValueView : UIView
@property(strong, nonatomic) UILabel *keyLabel;
@property(strong, nonatomic) UILabel *valueLabel;

-(void) setUpKey:(NSString *)key value:(NSString *)value;
@end