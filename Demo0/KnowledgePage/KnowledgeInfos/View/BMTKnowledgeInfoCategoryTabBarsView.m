/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeInfoCategoryTabBarsView.m 
 * Created by ray wang on 16/12/27.
 */

#import "BMTKnowledgeInfoCategoryTabBarsView.h"

@implementation BMTKnowledgeInfoCategoryTabBarsView {

}

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  self.backgroundColor = [UIColor whiteColor];
  [self addSubviews];
  [self setDefaultCatBarNames];
  return self;
}

#pragma mark - barSetting
- (void)setCatBarNames:(NSArray <NSString *> *)names {
  assert(self.labels.count >= 4);
  for (NSUInteger i = 0; i < 4; i++) {
    UILabel *catBar = self.labels[i];
    catBar.text = names[i];
  }
}

- (void)setDefaultCatBarNames {
  NSArray *namesArray = @[@"孕前准备", @"孕后须知", @"自然避孕", @"生理周期"];
  [self setCatBarNames:namesArray];
}

#pragma mark - change category event

- (void)someLabelClicked:(UILabel *)subLabel {
  NSUInteger selectedNumber = 1;
  for (NSUInteger i = 0; i < 4; i++) {
    BMTKnowledgeTabBarLabel *label = self.labels[i];
    if (label.tag != subLabel.tag) {
      [label setUnselectedStyle];
    } else {
      [label setSelectedStyle];
      selectedNumber += i;
    }
  }
  [self.delegate changeCategoryTo:selectedNumber];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  UIView *view = touch.view;

  if ([view isDescendantOfView:self.labels[0]]) {
    [self someLabelClicked:self.labels[0]];
  } else if ([view isDescendantOfView:self.labels[1]]) {
    [self someLabelClicked:self.labels[1]];
  } else if ([view isDescendantOfView:self.labels[2]]) {
    [self someLabelClicked:self.labels[2]];
  } else if ([view isDescendantOfView:self.labels[3]]) {
    [self someLabelClicked:self.labels[3]];
  }
}
#pragma mark - private
- (void)addSubviews {
  CGFloat barWidth = self.bounds.size.width / 4;
  CGFloat barHeight = self.bounds.size.height;

  NSMutableArray *catArray =
      [[NSMutableArray alloc] initWithCapacity:4];

  for (int i = 0; i < 4; i++) {
    BMTKnowledgeTabBarLabel
        *catBar =
        [[BMTKnowledgeTabBarLabel alloc]
            initWithFrame:CGRectMake(barWidth * i, 0,
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
  _labels=catArray;

  // gray line
  UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(15,
                                                              barHeight - 1,
                                                              barWidth * 4 -
                                                                  2 * 15,
                                                              1)];
  grayLine.backgroundColor = [UIColor colorWithWhite:0
                                               alpha:0.26];
  grayLine.tag = 99;
  [self addSubview:grayLine];
}
@end
