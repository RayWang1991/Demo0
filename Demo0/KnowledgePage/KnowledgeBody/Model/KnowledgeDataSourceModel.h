/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeDataSourceModel.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>

@interface KnowledgeDataSourceModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSUInteger thumbs;
@property (nonatomic) NSUInteger eyes;

-(instancetype)initWithRandom;
@end