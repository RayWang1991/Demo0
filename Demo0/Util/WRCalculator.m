/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * WRCalculator.m 
 * Created by ray wang on 16/12/15.
 */

#import "WRCalculator.h"

@implementation WRCalculator {

}
- (instancetype)init {
  self = [super init];
  if (self) {
    _result = 0.0;
  }
  return self;
}
+ (CGFloat)makeCalculation:(void (^)(WRCalculator *))operation {
  WRCalculator *wrCal = [[WRCalculator alloc] init];
  operation(wrCal);
  return wrCal.result;
}

- (WRCalculator *(^)(int))add {
  return ^WRCalculator *(int value) {
    _result += value;
    return self;
  };
}

- (WRCalculator *(^)(int))mul {
  return ^WRCalculator *(int i) {
    self.result *= i;
    return self;
  };
}

@end

int main_WRCal() {
  WRCalculator *myCal = [[WRCalculator alloc] init];
  CGFloat res1 = myCal.add(1).add(2).mul(3).add(4).result;
  NSLog(@"result1 = %f", res1);

  CGFloat res2 = [WRCalculator
      makeCalculation:^(WRCalculator *maker) {
        maker.add(1).add(2).add(15);
      }];
  NSLog(@"result2 = %.4f", res2);
  return 0;
}