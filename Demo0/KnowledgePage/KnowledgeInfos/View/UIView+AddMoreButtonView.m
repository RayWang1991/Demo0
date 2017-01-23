/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * AddMoreButtonView.m 
 * Created by ray wang on 16/12/26.
 */

#import "UIView+AddMoreButtonView.h"

@implementation UIView (AddMoreButtonView)


- (instancetype)initWithAddMoreButton {
  CGFloat width = [UIScreen mainScreen].bounds.size.width/3;
  self= [self initWithFrame:CGRectMake(0,0,width,80)];
  self.backgroundColor=[UIColor clearColor];
  UIButton *addMoreButton = [ UIButton buttonWithType:UIButtonTypeCustom];
  addMoreButton.frame=CGRectMake(width,20,width,40);
  [ addMoreButton setTitle:@"加载更多"
                       forState:UIControlStateNormal];
  [ addMoreButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
   addMoreButton
      .contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
   addMoreButton.backgroundColor=[UIColor blueColor];
   addMoreButton
      .contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
  [self addSubview: addMoreButton];
  return self;
}
@end
