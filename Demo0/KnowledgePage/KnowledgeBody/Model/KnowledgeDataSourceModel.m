/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeDataSourceModel.m 
 * Created by ray wang on 16/12/22.
 */

#import "KnowledgeDataSourceModel.h"

@implementation KnowledgeDataSourceModel {

}
-(instancetype)initWithRandom{
  self=[super init];
  self.eyes=arc4random();
  self.thumbs=arc4random();
  self.title= [NSString stringWithFormat:@"title %ld",arc4random()];
  self.detail= [NSString stringWithFormat:@"title %ld",arc4random()];
  return self;
}
@end