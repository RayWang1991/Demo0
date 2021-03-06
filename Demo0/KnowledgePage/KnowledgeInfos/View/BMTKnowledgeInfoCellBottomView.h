/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BottomView.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BMTKnowledgeInfoCellBottomView : UIView
@property(strong, nonatomic) UIImageView *eyeImageView;
@property(strong, nonatomic) UIImageView *thumbImageView;
@property(strong, nonatomic) UILabel *clickedNumLabel;
@property(strong, nonatomic) UILabel *likeNumLabel;

/*
- (void)setEyeImageView:(UIImage *)eyeImageView
         thumbImageView:(UIImage *)thumbImageView;
- (instancetype)initWithEyeNum:(NSUInteger)eyeNum
                      thumbNum:(NSUInteger)thumbNum;
                      */
@end