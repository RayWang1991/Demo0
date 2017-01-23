/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * WRracCal.m 
 * Created by ray wang on 16/12/15.
 */

#import "WRracCal.h"
#define kValue (10)
@implementation WRracCal {

}

- (WRracCal *)calculate:(int (^)(int value))operation {
  self.result = operation(self.result);
  return self;
}
- (WRracCal *)isEquals:(BOOL(^)(int value))operation {
  self.equal = operation(self.result);
  return self;
}

@end

int main_WRrac()
{
  WRracCal * wRracCal=[[WRracCal alloc] init];
  BOOL cmpRes= [[wRracCal calculate:^(int value) {
    value += 2;
    value *= 5;
    return value;
  }] isEquals:^(int value){
      return  (BOOL)(value == kValue);
  }].equal;
    
    NSLog(@"the comperasion result is %@",cmpRes?@"EQUAL":@"NOT EQUAL");
  return 0;
}
