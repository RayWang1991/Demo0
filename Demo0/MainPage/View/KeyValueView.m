/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KeyValueView.m 
 * Created by ray wang on 16/12/12.
 */

#import "KeyValueView.h"

@implementation KeyValueView {

}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                          0,
                                                          CGRectGetWidth(self.frame)
                                                              / 3,
                                                          CGRectGetHeight(self.frame))];
    _keyLabel.backgroundColor=[UIColor clearColor] ;
    _keyLabel.textAlignment= NSTextAlignmentLeft;
    _keyLabel.font= [UIFont systemFontOfSize:16];
    _keyLabel.textColor = [UIColor blackColor];
    [self addSubview:_keyLabel];
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(
        CGRectGetWidth(self.frame) / 3,
        0,
        CGRectGetWidth(self.frame)*2 / 3,
        CGRectGetHeight(self.frame))];
    _valueLabel.backgroundColor=[UIColor clearColor] ;
    _valueLabel.textAlignment= NSTextAlignmentLeft;
    _valueLabel.font= [UIFont systemFontOfSize:16];
    _valueLabel.textColor = [UIColor blackColor];
    [self addSubview:_valueLabel];
  }
  return self;
}
- (void)setUpKey:(NSString *)key
           value:(NSString *)value {
  self.keyLabel.text=key;
  self.valueLabel.text=value;
}

@end