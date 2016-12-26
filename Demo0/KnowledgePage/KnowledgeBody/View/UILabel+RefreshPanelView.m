/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * UILabel+RefreshPanel.m 
 * Created by ray wang on 16/12/26.
 */

#import "UILabel+RefreshPanelView.h"

@implementation UILabel (RefreshPanelView)
- (instancetype)initWithHintText{

  CGRect frame=CGRectMake(0,-REFRESH_PANEL_HEIGHT,
                          [UIScreen mainScreen].bounds.size.width,
                          REFRESH_PANEL_HEIGHT);

  self= [[UILabel alloc] initWithFrame:frame];
  self.text=REFRESH_PANEL_HINT_TEXT;
  self.textAlignment=NSTextAlignmentCenter;
  self.backgroundColor=[UIColor clearColor];
  return self;
}


- (void)setHintText {
  self.text=REFRESH_PANEL_HINT_TEXT;
}
- (void)setCompleteText {
    self.text=REFRESH_PANEL_COMPLETE_TEXT;
}

@end
