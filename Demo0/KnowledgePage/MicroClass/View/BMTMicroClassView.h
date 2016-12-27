/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassView.h 
 * Created by ray wang on 16/12/27.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMTMicroClassInfoEntity.h"

@interface BMTMicroClassView : UIView
@property(nonatomic, strong) UIImageView *speakImageView;
@property(nonatomic, strong) UILabel *weikeLabel;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *participantsLabel;
@property(nonatomic, strong) UILabel *timeLabel;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setUpWithEntity:(BMTMicroClassInfoEntity *)entity;
@end
