/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeInfoCategoryTabBarsView.m 
 * Created by ray wang on 16/12/27.
 */

#import "KnowledgeInfoCategoryTabBarsView.h"

@implementation KnowledgeInfoCategoryTabBarsView {

}

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  self.backgroundColor = [UIColor clearColor];
  [self addSubViews];
  [self setDefaultCatBarNames];
  return self;
}

#pragma mark - barSetting
- (void)setCatBarNames:(NSArray <NSString *> *)names {
  assert(self.subviews.count >= 4);
  for (NSUInteger i = 0; i < 4; i++) {
    UILabel *catBar = self.subviews[i];
    catBar.text = names[i];
  }
}

- (void)setDefaultCatBarNames {
  NSArray *namesArray = @[@"孕前准备", @"孕后须知", @"自然避孕", @"生理周期"];
  [self setCatBarNames:namesArray];
}

#pragma mark - change category event

- (void)someLabelClicked:(UILabel *)subLabel {
  for (KnowledgeTabBarLabel *label in self.subviews) {
    if (label.tag != subLabel.tag) {
      [label setUnselectedStyle];
    } else {
      [label setSelectedStyle];
    }
  }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  UIView *view = touch.view;
  NSArray *array = self.subviews;
  if ([view isDescendantOfView:self.subviews[0]]) {
    [self someLabelClicked:self.subviews[0]];
  } else if ([view isDescendantOfView:self.subviews[1]]) {
    [self someLabelClicked:self.subviews[1]];
  } else if ([view isDescendantOfView:self.subviews[2]]) {
    [self someLabelClicked:self.subviews[2]];
  } else if ([view isDescendantOfView:self.subviews[3]]) {
    [self someLabelClicked:self.subviews[3]];
  }
}
#pragma mark - private
- (void)addSubViews {
  CGFloat barWidth = self.bounds.size.width / 4;
  CGFloat barHeight = self.bounds.size.height;
  NSMutableArray *catArray =
      [[NSMutableArray alloc] initWithCapacity:4];

  for (int i = 0; i < 4; i++) {
    KnowledgeTabBarLabel
        *catBar =
        [[KnowledgeTabBarLabel alloc] initWithFrame:CGRectMake(barWidth * i, 0,
                                                               barWidth,
                                                               barHeight)];

    catBar.tag = 100 + i;

    catBar.textAlignment = NSTextAlignmentCenter;

    catBar.userInteractionEnabled = YES;

    if (i) {
      [catBar setUnselectedStyle];
    } else {
      [catBar setSelectedStyle];
    }
    [catArray addObject:catBar];

    [self addSubview:catBar];
  }
}
@end
