/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeModel.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KnowledgeBriefModel : NSObject
@property (nonatomic, assign, readwrite) CGRect backViewFrame;
@property (nonatomic, assign, readwrite) CGRect imageFrame;
@property (nonatomic, assign, readwrite) CGRect titleFrame;
@property (nonatomic, assign, readwrite) CGRect contentFrame;
@property (nonatomic, assign, readwrite) CGRect bottomFrame;
//@property (nonatomic, assign, readwrite) CGRect timeLabelFrame;
@end