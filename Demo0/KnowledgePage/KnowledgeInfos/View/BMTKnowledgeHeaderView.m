/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowledgeHeaderView.m 
 * Created by ray wang on 16/12/29.
 */

#import "BMTKnowledgeHeaderView.h"

@implementation BMTKnowledgeHeaderView {

}
-(UIView *)hitTest:(CGPoint)point
         withEvent:(UIEvent *)event {
  UIView *hitTestView=[super hitTest:point
                           withEvent:event];
  if(hitTestView==self){
    hitTestView=self.subviews[0].subviews[0];
  }
  return hitTestView;
}
@end
