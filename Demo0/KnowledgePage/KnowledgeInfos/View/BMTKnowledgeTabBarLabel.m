/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeTabBarLabel.m 
 * Created by ray wang on 16/12/27.
 */

#import "BMTKnowledgeTabBarLabel.h"
#import "UILabel+RefreshPanelView.h"

@implementation BMTKnowledgeTabBarLabel {

}

- (void)setUnselectedStyle {
  self.textColor = [UIColor grayColor];
  for (UIView *view in self.subviews) {
    view.hidden = YES;
  }
}
- (void)setSelectedStyle {
  self.textColor = [UIColor blueColor];
  for (UIView *view in self.subviews) {
    view.hidden = NO;
  }
}

#pragma - override
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.backgroundColor= [UIColor clearColor];
  CGFloat y = self.bounds.size.height - 2;
  CGFloat x = (self.bounds.size.width - 70) / 2;
  UIView
      *highlightLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, 70, 2)];
  highlightLine.backgroundColor = [UIColor blueColor];
  highlightLine.hidden = YES;

  self.font=[UIFont fontWithName:@"Helvetica"
                            size:14];
  [self addSubview:highlightLine];
  return self;
}

@end