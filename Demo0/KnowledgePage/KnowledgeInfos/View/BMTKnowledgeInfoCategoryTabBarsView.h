/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeInfoCategoryTabBarsView.h 
 * Created by ray wang on 16/12/27.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMTChangeCategoryDelegate.h"
#import "BMTKnowledgeTabBarLabel.h"

@interface BMTKnowledgeInfoCategoryTabBarsView : UIView

@property (nonatomic,weak) UIViewController<BMTChangeCategoryDelegate>
    *delegate;
@property (nonatomic,strong) NSArray * labels;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)setCatBarNames:(NSArray <NSString *>*)names;

-(void)setDefaultCatBarNames;

@end